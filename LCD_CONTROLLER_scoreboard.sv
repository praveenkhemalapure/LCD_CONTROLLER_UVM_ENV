

class LCD_CONTROLLER_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(LCD_CONTROLLER_scoreboard)

  // Declaring TLM Analysis Implement ports(s)
//   `uvm_analysis_imp_decl(_MASTER_req_export)
//   `uvm_analysis_imp_decl(_SLAVE_resp_export)
  
  
//uvm_analysis_export #(LCD_CONTROLLER_output_msg_item) LCD_CONTROLLER_output_score_port;
uvm_tlm_analysis_fifo #(LCD_CONTROLLER_output_msg_item) moni_out_lcdvd;
uvm_tlm_analysis_fifo #(LCD_CONTROLLER_output_msg_item) moni_out_ahbclk;
uvm_analysis_port #(LCD_CONTROLLER_output_msg_item) LCD_CONTROLLER_sb_port;

LCD_CONTROLLER_output_msg_item lcd_out_ahbclk;
LCD_CONTROLLER_output_msg_item lcd_out_lcdvd;
LCD_CONTROLLER_output_msg_item lcd_out_drop;


int queue[$];
int data[int];
int out,pixel,frames,frame,fd,fh,ff,count,i,aclks,aaclks;
logic [23:0]value;
int failure;
string typ,testname;    
  

  // Class constructor
  function new(string name = "LCD_CONTROLLER_scoreboard", uvm_component parent);    
    super.new(name, parent);
   LCD_CONTROLLER_sb_port = new("LCD_CONTROLLER_sb_port",this);
    moni_out_ahbclk = new("moni_out_ahbclk",this);
    moni_out_lcdvd  = new("moni_out_lcdvd",this);
  endfunction : new

  
  
  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    lcd_out_drop = LCD_CONTROLLER_output_msg_item::type_id::create("lcd_out_drop");
  endfunction : build_phase

  
  // UVM CONNECT PHASE
  virtual function void connect_phase(uvm_phase phase);
// LCD_CONTROLLER_output_score_port.connect(moni_out);  
  endfunction : connect_phase
  
  
task run_phase(uvm_phase phase);
begin
    collect();
    collect_f();
    fork
    run_compare();
//    check_ahbclks();
    join
end 
endtask : run_phase


  
function void report_phase(uvm_phase phase);
 if(failure > 0) 
 begin
    `uvm_error("oops",$sformatf("There are %d errors in frames in file %s",failure,testname));
 end 
endfunction : report_phase


task drop();
if(frame == 1)
begin
    lcd_out_drop.flag = 1;
    LCD_CONTROLLER_sb_port.write(lcd_out_drop);                 
end 
else 
begin
frame = frame - 1;
end 
endtask : drop
  
task run_compare();
begin
    failure = 0;
    do
    begin
    fork
    drop();
    check_output();
    check_ahbclks();
    join
    frames = frames - 1;
    $display("FAIL : %d",failure);
    end while(frames > 0);
    drop();
end 
endtask : run_compare
  
  
task check_output();
        i=0;
//        $display("index value is %h, %h",i,pixel);
        while(i < pixel)
        begin
                moni_out_lcdvd.get(lcd_out_lcdvd);
                if(data[i] == lcd_out_lcdvd.lcdvd)
                    begin
                       `uvm_info("LCD_CONTROLLER_scoreboard",$sformatf("SUCCESS Expected : %h, Received : %h ",data[i],lcd_out_lcdvd.lcdvd),UVM_LOW);                    
                    end 
                else
                    begin
                       `uvm_info("LCD_CONTROLLER_scoreboard",$sformatf("FAILURE Expected : %h, Received : %h ",data[i],lcd_out_lcdvd.lcdvd),UVM_LOW);                   
                        failure = failure + 1;
                    end 
                    i++;
        end     
endtask : check_output
  
  
  
task check_ahbclks();
    begin
            moni_out_ahbclk.get(lcd_out_ahbclk);
            if(aaclks == lcd_out_ahbclk.ahbclks)
                begin                
                   `uvm_info("LCD_CONTROLLER_scoreboard",$sformatf("SUCCESS AHBCLKS Expected :%d, Received :%d ",aclks,lcd_out_ahbclk.ahbclks),UVM_LOW);                    
                end 
            else
                begin
             `uvm_info("LCD_CONTROLLER_scoreboard",$sformatf("FAILURE AHBCLKS Expected : %d, Received : %d ",aclks,lcd_out_ahbclk.ahbclks),UVM_LOW);                    
             `uvm_error("oops",$sformatf("FAILURE AHBCLKS Expected :%d, Received :%d in file %s",aclks,lcd_out_ahbclk.ahbclks,testname));
                end 
    end
endtask : check_ahbclks
  
  
  
task collect();
       count = 0; 
   if ($test$plusargs("272test="))
   begin
       $value$plusargs("272test=%s", testname);
       fd = $fopen(testname,"r");
        while(!$feof(fd))
        begin
            fh=$fscanf(fd,"%s %h",typ,out);
            if(typ == "d")     
            begin
            queue.push_back(out);
            data[count] = out;
            count = count + 1;
            end 
            else if(typ == "a")
            begin
            pixel  = out;
            end 
            else if(typ == "n")
            begin
            frames = out;
            end 
        end 
        pixel = count;
        frame = frames + 1;
//         $display("dataaaaa %d",frame);
        
   end  
endtask : collect


  
task collect_f();
   if ($test$plusargs("272test="))
   begin
       $value$plusargs("272test=%s", testname);
       fd = $fopen(testname,"r");
        while(!$feof(fd))
        begin
            fh=$fscanf(fd,"%s",typ);
            if(typ === "f")
            begin
            fh=$fscanf(fd,"%d",out);
            aclks  = out;
            end 
        end 
        aaclks = aclks;
        
   end  
endtask : collect_f




endclass : LCD_CONTROLLER_scoreboard
  
  


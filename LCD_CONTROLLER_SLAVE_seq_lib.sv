

class LCD_CONTROLLER_SLAVE_seq extends uvm_sequence #(LCD_CONTROLLER_SLAVE_resp_item);
  `uvm_object_utils(LCD_CONTROLLER_SLAVE_seq)
//  `uvm_declare_p_sequencer(LCD_CONTROLLER_SLAVE_sequencer)
    
    int fd,fh,da,ad,cnt,cnnt;
    string typ,testname,ff;
    int count,add;
    int dataa[int];
    int addrr[int];
    
  // Class constructor
  function new(string name = "LCD_CONTROLLER_SLAVE_seq");
    super.new(name);
  endfunction : new

  LCD_CONTROLLER_SLAVE_resp_item mem_item;
  
  
  // Modify this body() method as per project requirements
 task body();
    mem_item = LCD_CONTROLLER_SLAVE_resp_item::type_id::create("mem_item");
    num_elements();
    collect();
    rst();
    send_items();
  endtask : body

  
    virtual task send_items();
    cnnt = 0;
    while (cnnt <= count)
    begin
    start_item(mem_item);
    add           = addrr[cnnt];
    mem_item.addr = addrr[cnnt];
    mem_item.data = dataa[add];;
            cnnt  = cnnt + 1;
   mem_item.reset = 0;      
    finish_item(mem_item);            
    end
    endtask : send_items
  
  
  virtual task num_elements();
  begin
       count = 0;     
    if($test$plusargs("272test="))
       begin
        $value$plusargs("272test=%s", testname);
       fd = $fopen(testname,"r");
       while(!$feof(fd))
     begin
            fh=$fscanf(fd,"%s %h %h",typ,ad,da);
            if(typ == "m")     
            begin
            count = count + 1;
            end 
     end 
        end 
        $display("no of num_elements = %h",count);
  end 
  endtask : num_elements
  
  
  
       virtual task collect();
   if ($test$plusargs("272test="))
   begin
   $value$plusargs("272test=%s", testname);
   $display("file name is %s",testname);
       fd = $fopen(testname,"r");
       cnt = 0;
     while(!$feof(fd))
     begin
            fh=$fscanf(fd,"%s %h %h",typ,ad,da);
            if(typ == "m")     
            begin
//            start_item(mem_item);
            dataa[ad]  = da;
            addrr[cnt]  = ad;
            cnt = cnt + 1;
//             $display("Addr : %h, Data : %h",ad,da );
//            finish_item(mem_item);
            end 
     end 
     end 
      endtask : collect
   
   
           virtual task rst();
            begin
                repeat(1)
                begin
                start_item(mem_item);
                mem_item.reset = 1;
                mem_item.noofel = count;
                $display("reset = %b",mem_item.reset);
                finish_item(mem_item);
                end
            end 
        endtask : rst
   
//         virtual task derst();
//             begin
//                 repeat(2)
//                 begin   
//                 start_item(mem_item);
//                 mem_item.reset = 0;
//                 finish_item(mem_item);
//                 end 
//             end 
//         endtask : derst
// 

endclass : LCD_CONTROLLER_SLAVE_seq


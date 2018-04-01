
class LCD_CONTROLLER_SLAVE_driver extends uvm_driver #(LCD_CONTROLLER_SLAVE_resp_item);
  `uvm_component_utils(LCD_CONTROLLER_SLAVE_driver)

  virtual AHBIF Q;

  // Declare all local fields here;
    logic [2:0]states,state;
    int data[int];
    int da,ad,fd,fh,add;
    string typ;
    int count,add;
    logic push_data;

  // Class constructor
  function new(string name = "LCD_CONTROLLER_SLAVE_driver", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Getting the interface here
    if(!uvm_config_db#(virtual AHBIF)::get(this,"","Q",Q))
      `uvm_fatal("**ERROR LCD_CONTROLLER_SLAVE_driver build phase", "Virtual interface was not received")
  endfunction : build_phase
  
  
  
virtual task run_phase(uvm_phase phase);
    begin
//     phase.raise_objection(this);
    forever
        begin    
    LCD_CONTROLLER_SLAVE_resp_item data_item;
    data_item = LCD_CONTROLLER_SLAVE_resp_item::type_id::create("data_item");    
    seq_item_port.get_next_item(data_item);

        if(data_item.reset == 1)
            begin
            push_data <= 0;
            add =0;
            count    <= data_item.noofel;
//             $display("no of elements :::::::::::::: %h",data_item.noofel);
            end 
        else
            begin
                if(count >= 0)
                    begin
                        if(count == 0)
                        begin
                        fork
                        drive_dut();
                        drive_grant();
                        drive_memdata();
                        join
//                         $display("driving dut");
                        end 
                        else
                        begin
                        data[data_item.addr] <= data_item.data;         
                        count = count - 1;
                        end 
                    end 
                else
                    begin
                    fork
//                     $display("driving dut");
                    drive_dut();
                    join
                    end 
            
            end 
        seq_item_port.item_done();        
     end    
//     phase.drop_objection(this);
    
    end 
  endtask 
  
  
  task drive_grant();
  forever
  begin
        Q.mHREADY <=  #1 1;
    @(posedge Q.HCLK)
    if((Q.HRESET == 0) && (Q.mHBUSREQ == 1))
        begin
        Q.mHGRANT <=  #1 1;
        end 
    else    
        begin
        Q.mHGRANT <=  #1 0;
//        Q.mHREADY <=   0;
        end 
  end
  endtask
  

  
  task drive_memdata();
  forever
  begin
                #1;
            @(posedge Q.HCLK)
              if((Q.mHGRANT == 1) && ((Q.mHTRANS[1] == 1)))
                    begin
                    push_data <=  1;
                    add       <= Q.mHADDR;
                    end 
              else      
                    begin                    
                    push_data <=  0;
                    end 
  end 
  endtask
  
  
  
   task drive_dut();
 forever
 begin 
@(posedge Q.HCLK)
            begin
                #1;
                if((Q.mHGRANT == 1) && ((Q.mHTRANS[1] == 1)))
                begin
//                $display("dataa %h addr %h",data[Q.mHADDR],Q.mHADDR);    
                Q.mHRDATA <=   #1 data[Q.mHADDR];
                end
                else
                begin                
                Q.mHRDATA <=  #1  16'h4321;
                end 
            end     
        
end 
endtask : drive_dut
    

  
  
  
/*
  // UVM Run Phase
  virtual task run_phase(uvm_phase phase);
//    drive_default_signal_values();
//    phase.raise_objection(this);
    collect();
    rst();
    derst();
//    rst();
//    derst();
    drive_dut();
//    phase.drop_objection(this);
    endtask : run_phase

    
 task drive_dut();
 forever
 begin 
 @(posedge Q.HCLK)
 case(states) 
 0:
    if(Q.HRESET == 0)
    begin
        if(Q.mHBUSREQ == 1)
        begin
        Q.mHGRANT <=  #1 1;
        Q.mHREADY <=  #1 1;
        add       <=     Q.mHADDR;    
        states    <=     0;
            if(Q.mHGRANT == 1)
            begin
            Q.mHRDATA <=  #1 data[Q.mHADDR];
            end 
            else
            begin
            Q.mHRDATA <=  #1 0;            
            end 
        end 
        else
        begin
        Q.HRESET  <=  #1 0;
        Q.mHGRANT <=  #1 0;
        states    <=  0;
        Q.mHRDATA <=  #1 0;
        end 
    end     
   else
    begin
        Q.HRESET  <=  #1 0;
        Q.mHGRANT <=  #1 0;
        Q.mHREADY <=  #1 0;
        states    <=     0;
        Q.mHRDATA <=  #1 0;    
    end 
 1:
 
    begin
        $display("mem addr %h   data %h ",add,data[add]);
//        Q.mHRDATA <=  #1 data[add];
       states <=  0;
    end 
default : states <=  0;
endcase
 end 
 endtask : drive_dut
    
    
    
    
    
    
    
    task collect();
    
    fd = $fopen("t1.txt","r");
     while(!$feof(fd))
     begin
            fh=$fscanf(fd,"%s %h %h",typ,ad,da);
            if(typ == "m")     
            begin
            data[ad] = da;
            end 
     end 
    
    
    endtask : collect   
    
       
              virtual task rst();
            begin
//                @(posedge Q.HCLK)
                repeat(17)
                begin
                Q.HRESET = 1;
                Q.HSEL   = 0;
                Q.HWDATA = 1234;
                Q.HADDR  = 0;
                $display("reset : %b",Q.HRESET);
                end
            end 
        
        endtask : rst
   
        virtual task derst();
            begin
                @(posedge Q.HCLK)
                repeat(8)
                begin   
                Q.HRESET = 0;
                $display("reset : %b",Q.HRESET);
                end 
            end 
        
        endtask : derst
*/
    
    
    
    
    
    
    
    
    
    
    
//   task collect();
//     forever
//         begin
//             LCD_CONTROLLER_SLAVE_resp_item data_item;
//             data_item = LCD_CONTROLLER_SLAVE_resp_item::type_id::create("data_item");
// 
//         seq_item_port.get_next_item(data_item);
//             if(data_item.reset == 1)
//             begin
//             Q.HRESET <= #1 1;
//             Q.HADDR  <= #1 0;
//             Q.HWDATA <= #1 0;
//             Q.HTRANS <= #1 0;
//             end
// 
//             data[data_item.addr] = data_item.data;
//         //        drive_dut();
//                 //$display("memory data is %h, addr is : %h",data[data_item.addr],data_item.addr);
//         
//  //        drive_dut();
//         seq_item_port.item_done();        
//         drive_dut();
// 
//         end         
//         
//    endtask : collect
// 
//    
//    task drive_dut();
// //      $display("memory dataaa is ");
//                 @(posedge Q.HCLK);
//             case(states)
//                0: 
//                 if(Q.mHGRANT == 1)
//                     begin
//                         Q.mHREADY  <= #1 1;
//                         Q.mHWRITE  <= #1 0;
//                         states     <= 1;
//                     end
//                 1:
//                     begin
//                         Q.mHRDATA  <= #1  data[Q.mHADDR];
//                         $display("memory dataaa is %h",data[Q.mHADDR]);
//                         states     <=  0;
//                     end     
//           default : states = 0; 
//           endcase
//    endtask : drive_dut
   
   

   
   
   
  // Task to drive actual interface signals
//  task drive_resp(LCD_CONTROLLER_SLAVE_resp_item LCD_CONTROLLER_resp);
    // Add your SLAVE driver core logic here
//  endtask : drive_resp

  // Function to drive default signal values on to the interface
//  virtual function void drive_default_signal_values;
    // Write your default signal values driving logic here
//  endfunction : drive_default_signal_values

endclass : LCD_CONTROLLER_SLAVE_driver


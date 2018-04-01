

class LCD_CONTROLLER_MASTER_driver extends uvm_driver #(LCD_CONTROLLER_MASTER_req_item);
  `uvm_component_utils(LCD_CONTROLLER_MASTER_driver)

  virtual AHBIF Q;
    
  // Declare all local fields here;
    logic [2:0] states;
    int config_items [*];
    int num_elements;
    int data[int];
    int addr[int];
    logic [31:0]count,number;
    int fh,fd,ad,da,add,cnt;
    string typ;
    logic statuss;

  // Class constructor
  function new(string name = "LCD_CONTROLLER_MASTER_driver", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Getting the interface here
    if(!uvm_config_db#(virtual AHBIF)::get(this,"*","Q",Q))
      `uvm_fatal("**ERROR LCD_CONTROLLER_MASTER_driver build phase", "Virtual interface was not received")
  endfunction : build_phase


  virtual task run_phase(uvm_phase phase);
    begin
    
//    phase.raise_objection(this);
    forever
        begin    
        LCD_CONTROLLER_MASTER_req_item mem_item;
        mem_item = LCD_CONTROLLER_MASTER_req_item::type_id::create("mem_item");    
        seq_item_port.get_next_item(mem_item);

//         if(statuss == 1)
//             begin
//             phase.drop_objection(this);
//             end 


    
        if(mem_item.reset == 1)
            begin
            count        <= mem_item.configel;
            num_elements <= mem_item.configel;
            cnt      <= 0;
            statuss  <= 0;
            rst();
            end 
        else
            begin
                if(count > 0)
                    begin
                        if(count == 1)
                        begin
                        //$display("count is 1");
                        data[mem_item.addr] <= mem_item.data;   
                        addr[cnt]           <= mem_item.addr;
                        print();
                        main();
                        //$display("driving dut");
                        end 
                        else
                        begin
                        data[mem_item.addr] <= mem_item.data;   
                        addr[cnt]           <= mem_item.addr;
                        count               <= count - 1;
                        cnt                 <= cnt + 1;
                        
                        end 
                    end 
                else
                    begin
                    //$display("driving dut");
                    end 
            
            end 
        seq_item_port.item_done();        
     end    
//     phase.drop_objection(this);
    
    end 
  endtask 
  





        
  virtual task print();
  begin
       fd = $fopen("t1.txt","r");
       while(!$feof(fd))
     begin
            fh=$fscanf(fd,"%s %h %h",typ,ad,da);
            if(typ == "w")     
            begin
//            $display("data is %h",data[ad]);
            end 
     end 
  end 
  endtask : print






  
  
  virtual task rst();
  begin
  repeat(2)
    begin
    Q.HRESET     <=  1;
    Q.HSEL       <=  0;
    Q.HADDR      <=  0;
    Q.HTRANS     <=  0;   
    number       <=  0;
    Q.HWDATA     <=  0;
    Q.HWRITE     <=  0;
    add          <=  0;
    end 
//     Q.HRESET <= 0;
    #21;
  end
  endtask : rst
  


task main();  
forever
begin
    Q.HRESET <= 0;
        @(posedge Q.HCLK)
        begin
         case(states)
          0: 
            if(Q.HRESET == 1)
            begin
                 states       <=  0;
                 Q.HSEL       <=  0;
                 Q.HADDR      <=  0;
                 Q.HTRANS     <=  0;   
                 number       <=  0;
                 Q.HWDATA     <=  0;
                 Q.HBURST     <=    0;
            end 
            else
            begin
               #1;
                if((number < num_elements))
                begin
//                   if(^addr[number] === 32'bz)
//                   begin
//                     Q.HSEL       <=    0;
//                     Q.HWRITE     <=    0;
// //                    add          <=    addr[number];
//                     Q.HADDR      <=    0;
//                     Q.HTRANS     <=    0;   
//                     Q.HWDATA     <=    0;                  
//                     Q.HBURST     <=    0;
//                   end 
//                   else
                    begin
//                   $display("addrr %h data %h",addr[number],data[addr[number]]);

                    Q.HSEL       <=    1;
                    Q.HWRITE     <=    1;
                    add          <=    addr[number];
                    Q.HADDR      <=    addr[number];
//                     Q.HWDATA     <=    data[add];
                    Q.HTRANS     <=    2;   
                    Q.HBURST     <=    0;
                   end 
                    
//                $display("addr %h,   data %h",add,data[add]);                
                number       <=   number + 1;
                states       <=   2;
                end 
                else
                begin
                Q.HTRANS     <=   0;   
                states       <=     0;
                Q.HSEL       <=   0;
                statuss      <=   1;
                Q.HWRITE     <=   0;
                Q.HBURST     <=    0;
                break;
                end 
            end 
                
          2:  
            begin
            #1;    
            Q.HTRANS     <=    1;   
            Q.HWDATA     <=    data[add];
                $display("addr %h,   data %h",add,data[add]);                
            states       <=    0;
            end 
        default :
                states <=  0;
        endcase
        end 
    end 
endtask : main

  
  
  
  

endclass : LCD_CONTROLLER_MASTER_driver


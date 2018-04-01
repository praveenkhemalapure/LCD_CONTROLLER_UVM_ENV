

class LCD_CONTROLLER_OUTPUT_monitor extends uvm_monitor;
  `uvm_component_utils(LCD_CONTROLLER_OUTPUT_monitor)

  virtual AHBIF Q;
  virtual LCDOUT lcdout;
  int count,frame_count,count1,count2;

  // Declaring TLM Analysis port(s)
  uvm_analysis_port #(LCD_CONTROLLER_output_msg_item) LCD_CONTROLLER_output_port_lcdvd;
  uvm_analysis_port #(LCD_CONTROLLER_output_msg_item) LCD_CONTROLLER_output_port_ahbclk;


  // Class constructor
  function new(string name = "LCD_CONTROLLER_OUTPUT_monitor", uvm_component parent);
    super.new(name, parent);
    LCD_CONTROLLER_output_port_lcdvd  = new("LCD_CONTROLLER_output_port_lcdvd",this);
    LCD_CONTROLLER_output_port_ahbclk = new("LCD_CONTROLLER_output_port_ahbclk",this);

    
  endfunction : new

  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Getting the interface here
    if(!uvm_config_db#(virtual LCDOUT)::get(this,"*","lcdout",lcdout))
      `uvm_fatal("**ERROR LCD_CONTROLLER_OUTPUT_monitor build phase", "Virtual interface was not received")
    if(!uvm_config_db#(virtual AHBIF)::get(this,"*","Q",Q))
      `uvm_fatal("**ERROR LCD_CONTROLLER_OUTPUT_monitor build phase", "Virtual interface was not received")
  endfunction : build_phase

  
//   UVM Run Phase
//   virtual task run_phase(uvm_phase phase);
//     begin
//         forever
//         begin
//         LCD_CONTROLLER_output_msg_item moni_item;
//         moni_item = LCD_CONTROLLER_output_msg_item::type_id::create("moni_item");
//         @(posedge lcdout.LCDDCLK);
//                 if(lcdout.LCDENA_LCDM == 1)
//                     begin
//                     moni_item.lcdvd  = lcdout.LCDVD;
//                     #1;
//                     LCD_CONTROLLER_output_port.write(moni_item);                 
//                     end 
//         end            
//     end 
//   endtask : run_phase



virtual task run_phase(uvm_phase phase);
forever
begin
        fork
            lcdvd();
            eventt();
            ahbclk();
        join    
end 
endtask : run_phase

task eventt();
forever
begin
        @(posedge lcdout.LCDFP);
            begin
            frame_count = frame_count + 1;
//            $display(" frame count is %h , %t",frame_count,$time);
            end 

end 
endtask : eventt



task ahbclk();
forever
begin
        LCD_CONTROLLER_output_msg_item moni_ahbclk_item;
        moni_ahbclk_item = LCD_CONTROLLER_output_msg_item::type_id::create("moni_ahbclk_item");
    @(posedge Q.HCLK)
        if(frame_count == 1)
                begin
                count = count + 1;
//                $display("lcd_frame %d",lcdout.lcd_frame);
                end 
                
        if(frame_count == 2)
                begin                
                moni_ahbclk_item.ahbclks  = count;            
                if(count1 == 0)
                begin
                LCD_CONTROLLER_output_port_ahbclk.write(moni_ahbclk_item);                 
//                $display("count is %d",moni_ahbclk_item.ahbclks);
                end 
                count1 = count1 + 1;
                end 

        if(frame_count == 3)
                begin
                moni_ahbclk_item.ahbclks  = count1;
                if(count1 == 0)
                begin
                LCD_CONTROLLER_output_port_ahbclk.write(moni_ahbclk_item);                 
//                $display("count1 is %d",moni_ahbclk_item.ahbclks);
                end 
                count2 = count2 + 1;
                end 
                
        if(frame_count == 4)
                begin
                moni_ahbclk_item.ahbclks  = count2;
                LCD_CONTROLLER_output_port_ahbclk.write(moni_ahbclk_item);                 
//                $display("count2 is %d",moni_ahbclk_item.ahbclks);
                end 
                
end 
endtask : ahbclk


task lcdvd();
begin
        forever
        begin
        LCD_CONTROLLER_output_msg_item moni_lcdvd_item;
        moni_lcdvd_item = LCD_CONTROLLER_output_msg_item::type_id::create("moni_lcdvd_item");
        @(posedge lcdout.LCDDCLK);
                if(lcdout.LCDENA_LCDM == 1)
                    begin
                    moni_lcdvd_item.lcdvd  = lcdout.LCDVD;
                    #1;
                    LCD_CONTROLLER_output_port_lcdvd.write(moni_lcdvd_item);                 
                    end 
        end            
end 
endtask : lcdvd


endclass : LCD_CONTROLLER_OUTPUT_monitor

    


// This is LCD_CONTROLLER_base_test class
class LCD_CONTROLLER_base_test extends uvm_test;

  `uvm_component_utils(LCD_CONTROLLER_base_test)

  LCD_CONTROLLER_env env;
  LCD_CONTROLLER_OUTPUT_env env_out;
  LCD_CONTROLLER_MASTER_agent MASTER_agent;
  LCD_CONTROLLER_MASTER_seq config_seq;
  LCD_CONTROLLER_SLAVE_agent SLAVE_agent;
  LCD_CONTROLLER_SLAVE_seq mem_seq;
  LCD_CONTROLLER_scoreboard lcd_score;
  

  
  uvm_tlm_analysis_fifo #(LCD_CONTROLLER_output_msg_item) test_item;
LCD_CONTROLLER_output_msg_item lcd_out;
  
  // Class constructor
  function new(string name = "LCD_CONTROLLER_base_test", uvm_component parent);
    super.new(name, parent);
    test_item = new("test_item",this);
  endfunction : new


  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = LCD_CONTROLLER_env::type_id::create("env",this);
    env_out = LCD_CONTROLLER_OUTPUT_env::type_id::create("env_out",this);
    lcd_score = LCD_CONTROLLER_scoreboard::type_id::create("lcd_score",this);
    config_seq = LCD_CONTROLLER_MASTER_seq :: type_id :: create ("config_seq",this);
    mem_seq = LCD_CONTROLLER_SLAVE_seq :: type_id :: create ("mem_seq",this);
  endfunction : build_phase

  
   virtual function void connect_phase(uvm_phase phase);
//   lcd_score.LCD_CONTROLLER_output_score_port.connect(lcd_score.moni_out.analysis_export);  
   env_out.LCD_CONTROLLER_output_env_out_port_lcdvd.connect(lcd_score.moni_out_lcdvd.analysis_export);  
   env_out.LCD_CONTROLLER_output_env_out_port_ahbclk.connect(lcd_score.moni_out_ahbclk.analysis_export);  
   lcd_score.LCD_CONTROLLER_sb_port.connect(test_item.analysis_export);
    endfunction : connect_phase 
  
  
  // UVM End_of_Elaboration Phase
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction : end_of_elaboration_phase

  // UVM Start_of_simulation Phase
  virtual function void start_of_simulation_phase(uvm_phase phase);
    uvm_test_done.set_drain_time(this,100ns);
  endfunction : start_of_simulation_phase

  
  
  
  
  // UVM Run Phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    // Start your request sequences here
        fork
        config_seq.start(env.MASTER_agent.sequencer);
         mem_seq.start(env.SLAVE_agent.sequencer);
    forever
        begin
        test_item.get(lcd_out);
//         $display("flag is %h",lcd_score.flag);
        if(lcd_out.flag == 1)
           begin
           #20;
            phase.drop_objection(this);
           end 
        end
        join
  endtask : run_phase
  
  
  
endclass : LCD_CONTROLLER_base_test



/*
// This is LCD_CONTROLLER_sample_test class
class LCD_CONTROLLER_sample_test extends LCD_CONTROLLER_base_test;
//  `uvm_component_utils(LCD_CONTROLLER_sample_test)

  // Declare your requesting sequences here
    LCD_CONTROLLER_MASTER_seq config_seq;
  `uvm_component_utils_begin(LCD_CONTROLLER_sample_test)
    `uvm_field_object(config_seq,UVM_ALL_ON)
  `uvm_component_utils_end
  
    
  // Class constructor
  function new(string name = "LCD_CONTROLLER_sample_test", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    config_seq = LCD_CONTROLLER_MASTER_seq :: type_id :: create ("config_seq",this);

    endfunction : build_phase

  // UVM Run Phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    // Start your request sequences here
//        config_seq.start(env.sequencer);

//    phase.drop_objection(this);
# 10000000
  endtask : run_phase

endclass : LCD_CONTROLLER_sample_test
*/

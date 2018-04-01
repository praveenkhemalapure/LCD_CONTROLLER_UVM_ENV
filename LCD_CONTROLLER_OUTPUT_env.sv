
class LCD_CONTROLLER_OUTPUT_env extends uvm_env;
  
  LCD_CONTROLLER_OUTPUT_agent LCDOUT_agent;
  
  
  `uvm_component_utils_begin(LCD_CONTROLLER_OUTPUT_env)
    `uvm_field_object(LCDOUT_agent,UVM_ALL_ON)
  `uvm_component_utils_end
  

 uvm_analysis_port #(LCD_CONTROLLER_output_msg_item) LCD_CONTROLLER_output_env_out_port_lcdvd;
 uvm_analysis_port #(LCD_CONTROLLER_output_msg_item) LCD_CONTROLLER_output_env_out_port_ahbclk;


  // Class constructor
  function new(string name = "LCD_CONTROLLER_OUTPUT_env", uvm_component parent);
    super.new(name, parent);
    LCD_CONTROLLER_output_env_out_port_lcdvd = new("LCD_CONTROLLER_output_env_out_port_lcdvd",this);
    LCD_CONTROLLER_output_env_out_port_ahbclk = new("LCD_CONTROLLER_output_env_out_port_ahbclk",this);
  endfunction : new

  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    LCDOUT_agent = LCD_CONTROLLER_OUTPUT_agent::type_id::create("LCDOUT_agent",this);
  endfunction : build_phase

  // UVM Connect Phase
  virtual function void connect_phase(uvm_phase phase);
//   LCDOUT_agent.LCD_CONTROLLER_output_agent_in_port.connect(LCDOUT_agent.LCD_CONTROLLER_output_agent_out_port); 
  LCDOUT_agent.LCD_CONTROLLER_output_agent_port_lcdvd.connect(LCD_CONTROLLER_output_env_out_port_lcdvd); 
  LCDOUT_agent.LCD_CONTROLLER_output_agent_port_ahbclk.connect(LCD_CONTROLLER_output_env_out_port_ahbclk); 
    // Connect MASTER agent monitor tlm port(s) to scoreboard tlm export(s)
//    MASTER_agent.monitor.LCD_CONTROLLER_req_port.connect(scoreboard.MASTER_req_export);
    // Connect SLAVE agent monitor tlm port(s) to scoreboard tlm export(s)
//    SLAVE_agent.monitor.LCD_CONTROLLER_resp_port.connect(scoreboard.SLAVE_resp_export);
  endfunction : connect_phase

endclass : LCD_CONTROLLER_OUTPUT_env


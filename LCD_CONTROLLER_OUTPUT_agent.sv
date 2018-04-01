
class LCD_CONTROLLER_OUTPUT_agent extends uvm_agent;

  LCD_CONTROLLER_OUTPUT_monitor monitor;

  `uvm_component_utils_begin(LCD_CONTROLLER_OUTPUT_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_component_utils_end

  
  uvm_analysis_port #(LCD_CONTROLLER_output_msg_item) LCD_CONTROLLER_output_agent_port_lcdvd;
  uvm_analysis_port #(LCD_CONTROLLER_output_msg_item) LCD_CONTROLLER_output_agent_port_ahbclk;
//  uvm_analysis_port #(LCD_CONTROLLER_output_msg_item) LCD_CONTROLLER_output_agent_in_port;

  
  
  
  // Class constructor
  function new(string name = "LCD_CONTROLLER_OUTPUT_agent", uvm_component parent);
    super.new(name, parent);
    LCD_CONTROLLER_output_agent_port_lcdvd  = new("LCD_CONTROLLER_output_agent_port_lcdvd",this);
    LCD_CONTROLLER_output_agent_port_ahbclk  = new("LCD_CONTROLLER_output_agent_port_ahbclk",this);
//    LCD_CONTROLLER_output_agent_out_port = new("LCD_CONTROLLER_output_agent_out_port",this);
  endfunction : new

  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    monitor = LCD_CONTROLLER_OUTPUT_monitor::type_id::create("monitor",this);
  endfunction : build_phase

  // UVM Connect Phase
  virtual function void connect_phase(uvm_phase phase);
  monitor.LCD_CONTROLLER_output_port_lcdvd.connect(LCD_CONTROLLER_output_agent_port_lcdvd); 
  monitor.LCD_CONTROLLER_output_port_ahbclk.connect(LCD_CONTROLLER_output_agent_port_ahbclk); 
  endfunction : connect_phase

endclass : LCD_CONTROLLER_OUTPUT_agent


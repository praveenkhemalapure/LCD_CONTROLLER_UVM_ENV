
class LCD_CONTROLLER_env extends uvm_env;
  
  LCD_CONTROLLER_MASTER_agent MASTER_agent;
  LCD_CONTROLLER_SLAVE_agent  SLAVE_agent;
  
  
  `uvm_component_utils_begin(LCD_CONTROLLER_env)
    `uvm_field_object(MASTER_agent,UVM_ALL_ON)
    `uvm_field_object(SLAVE_agent,UVM_ALL_ON)
  `uvm_component_utils_end
  
  
//  LCD_CONTROLLER_SLAVE_agent SLAVE_agent;
//  LCD_CONTROLLER_scoreboard scoreboard;

  // Class constructor
  function new(string name = "LCD_CONTROLLER_env", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    MASTER_agent = LCD_CONTROLLER_MASTER_agent::type_id::create("MASTER_agent",this);
    SLAVE_agent  = LCD_CONTROLLER_SLAVE_agent::type_id::create("SLAVE_agent",this);
//    scoreboard = LCD_CONTROLLER_scoreboard::type_id::create("scoreboard",this);
  endfunction : build_phase

  // UVM Connect Phase
  virtual function void connect_phase(uvm_phase phase);
    // Connect MASTER agent monitor tlm port(s) to scoreboard tlm export(s)
//    MASTER_agent.monitor.LCD_CONTROLLER_req_port.connect(scoreboard.MASTER_req_export);
    // Connect SLAVE agent monitor tlm port(s) to scoreboard tlm export(s)
//    SLAVE_agent.monitor.LCD_CONTROLLER_resp_port.connect(scoreboard.SLAVE_resp_export);
  endfunction : connect_phase

endclass : LCD_CONTROLLER_env


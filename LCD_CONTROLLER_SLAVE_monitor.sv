

class LCD_CONTROLLER_SLAVE_monitor extends uvm_monitor;
  `uvm_component_utils(LCD_CONTROLLER_SLAVE_monitor)

  virtual LCD_CONTROLLER_if virt_if;

  // Declaring TLM Analysis port(s)
  uvm_analysis_port #(LCD_CONTROLLER_SLAVE_resp_item) LCD_CONTROLLER_resp_port;

  // Declare all local fields here;


  // Declare covergoups here;


  // Class constructor
  function new(string name = "LCD_CONTROLLER_SLAVE_monitor", uvm_component parent);
    super.new(name, parent);
    LCD_CONTROLLER_resp_port = new("LCD_CONTROLLER_resp_port",this);
    // Create covergoups here;

  endfunction : new

  // UVM Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Getting the interface here
    if(!uvm_config_db#(virtual LCD_CONTROLLER_if)::get(this,"","virt_if",virt_if))
      `uvm_fatal("**ERROR LCD_CONTROLLER_SLAVE_monitor build phase", "Virtual interface was not received")
  endfunction : build_phase

  // UVM Run Phase
  virtual task run_phase(uvm_phase phase);
    @(posedge virt_if.clk);
    // Write your own monitor logic here;

    // Write into tlm ports here;

    // Sample covergoups here;

  endtask : run_phase

  // UVM Extract Phase
  virtual function void extract_phase(uvm_phase phase);
    // Add your extract phase logic here
  endfunction : extract_phase

  // UVM Check Phase
  virtual function void check_phase(uvm_phase phase);
    // Add your check phase logic here
  endfunction : check_phase

  // UVM Report Phase
  virtual function void report_phase(uvm_phase phase);
    // Add your report phase logic here
  endfunction : report_phase

endclass : LCD_CONTROLLER_SLAVE_monitor


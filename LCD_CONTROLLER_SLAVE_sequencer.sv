

class LCD_CONTROLLER_SLAVE_sequencer extends uvm_sequencer #(LCD_CONTROLLER_SLAVE_resp_item);
  `uvm_component_utils(LCD_CONTROLLER_SLAVE_sequencer)

  // Class constructor
  function new(string name = "LCD_CONTROLLER_SLAVE_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction : new

endclass : LCD_CONTROLLER_SLAVE_sequencer




class LCD_CONTROLLER_MASTER_req_item extends uvm_sequence_item;

  logic [31:0] addr;
  logic [31:0] data;
  string cha;
  int configel;
  logic reset;
  
  `uvm_object_utils_begin(LCD_CONTROLLER_MASTER_req_item)
    // Factory Register all your sequence item fields here
    // Example:
    // `uvm_field_int(data, UVM_ALL_ON)
     `uvm_field_int(data, UVM_ALL_ON)
     `uvm_field_int(addr, UVM_ALL_ON)
     `uvm_field_string(cha, UVM_ALL_ON)
    `uvm_object_utils_end

  // Class constructor
  function new(string name = "LCD_CONTROLLER_MASTER_req_item");
    super.new(name);
  endfunction : new


endclass : LCD_CONTROLLER_MASTER_req_item


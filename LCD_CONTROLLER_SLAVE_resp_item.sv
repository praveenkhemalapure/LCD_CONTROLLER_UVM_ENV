

class LCD_CONTROLLER_SLAVE_resp_item extends uvm_sequence_item;

  int addr;
  int data;
  logic reset;
  int noofel;

//  string cha;
  
  `uvm_object_utils_begin(LCD_CONTROLLER_SLAVE_resp_item)
     `uvm_field_int(data, UVM_ALL_ON)
     `uvm_field_int(addr, UVM_ALL_ON)
     `uvm_field_int(reset, UVM_ALL_ON)
     `uvm_field_int(noofel, UVM_ALL_ON)
//     `uvm_field_int(cha, UVM_ALL_ON)
  `uvm_object_utils_end

  // Class constructor
  function new(string name = "LCD_CONTROLLER_SLAVE_resp_item");
    super.new(name);
  endfunction : new


  
  
endclass : LCD_CONTROLLER_SLAVE_resp_item


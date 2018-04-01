class LCD_CONTROLLER_output_msg_item extends uvm_sequence_item;
int lcdvd;
logic flag;
int ahbclks;

    // Factory Register all your sequence item fields here
  `uvm_object_utils_begin(LCD_CONTROLLER_output_msg_item)
     `uvm_field_int(lcdvd, UVM_ALL_ON)
     `uvm_field_int(ahbclks, UVM_ALL_ON)
     `uvm_field_int(flag, UVM_ALL_ON)
    `uvm_object_utils_end

    
     // Class constructor
  function new(string name = "LCD_CONTROLLER_output_msg_item");
    super.new(name);
  endfunction : new
 
    
endclass : LCD_CONTROLLER_output_msg_item


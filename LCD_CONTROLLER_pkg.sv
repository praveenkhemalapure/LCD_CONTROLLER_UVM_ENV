

package LCD_CONTROLLER_pkg;

  `include "uvm_macros.svh"
// Importing uvm_pkg
  import uvm_pkg::*;

//  `include "LCD_CONTROLLER_types_and_enums.sv"

   // MASTER ENV
  `include "LCD_CONTROLLER_MASTER_req_item.sv"
  `include "LCD_CONTROLLER_MASTER_seq_lib.sv"
  `include "LCD_CONTROLLER_MASTER_monitor.sv"
  `include "LCD_CONTROLLER_MASTER_sequencer.sv"
  `include "LCD_CONTROLLER_MASTER_driver.sv"
  `include "LCD_CONTROLLER_MASTER_agent.sv"
  
  
  // SLAVE ENV 
  `include "LCD_CONTROLLER_SLAVE_resp_item.sv"
  `include "LCD_CONTROLLER_SLAVE_seq_lib.sv"
  `include "LCD_CONTROLLER_SLAVE_sequencer.sv"
  `include "LCD_CONTROLLER_SLAVE_driver.sv"
  `include "LCD_CONTROLLER_SLAVE_agent.sv"


  `include "LCD_CONTROLLER_OUTPUT_msg.sv"  
  `include "LCD_CONTROLLER_OUTPUT_monitor.sv" 
  `include "LCD_CONTROLLER_OUTPUT_agent.sv"
  `include "LCD_CONTROLLER_OUTPUT_env.sv"  
  `include "LCD_CONTROLLER_env.sv"
  `include "LCD_CONTROLLER_scoreboard.sv"  
  `include "LCD_CONTROLLER_test_lib.sv"

endpackage : LCD_CONTROLLER_pkg


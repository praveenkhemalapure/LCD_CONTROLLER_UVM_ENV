
class LCD_CONTROLLER_MASTER_seq extends uvm_sequence #(LCD_CONTROLLER_MASTER_req_item);
  `uvm_object_utils(LCD_CONTROLLER_MASTER_seq)
//  `uvm_declare_p_sequencer(LCD_CONTROLLER_MASTER_sequencer)

    int count;



  // Class constructor
  function new(string name = "LCD_CONTROLLER_MASTER_seq");
    super.new(name);
  endfunction : new


  LCD_CONTROLLER_MASTER_req_item config_item;

   int fd,fh;
   logic [31:0] ad,da;
   int i,j;
    string typ,testname;
  
  // Modify this body() method as per project requirements
task body();
//    while(1) begin
    config_item = LCD_CONTROLLER_MASTER_req_item::type_id::create("config_item");
//    rst();
//    derst();
    num_elements();
    rst();
    items();
//    end
  endtask : body

   virtual task items();
   if ($test$plusargs("272test="))
   begin
       $value$plusargs("272test=%s", testname); 
       fd = $fopen(testname,"r");
     while(!$feof(fd))
     begin
            fh=$fscanf(fd,"%s %h %h",typ,ad,da);
            if(typ == "w")     
            begin
            start_item(config_item);
 //           $display("Data : %h, Addr : %h",da,ad);
            config_item.addr = ad;
            config_item.data = da;
            config_item.cha  = "w";
            config_item.reset = 0;
            finish_item(config_item);
            end 
     end 
   end   
   endtask : items


        virtual task rst();
            begin
                repeat(1)
                begin
                start_item(config_item);
                config_item.reset = 1;
                config_item.configel = count;
                finish_item(config_item);
                end
            end 
        
        endtask : rst
        
        
  virtual task num_elements();
  begin
       count = 0;     
   if ($test$plusargs("272test="))
   begin
       $value$plusargs("272test=%s", testname);
       fd = $fopen(testname,"r");
       while(!$feof(fd))
     begin
            fh=$fscanf(fd,"%s %h %h",typ,ad,da);
            if(typ == "w")     
            begin
            count = count + 1;
            end 
     end 
        $display("no of num_elements = %h",count);
  end 
  end 
  endtask : num_elements

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//    
//         virtual task derst();
//             begin
//                 repeat(2)
//                 begin   
//                 start_item(config_item);
//                 config_item.reset = 0;
//                 $display("reset : %b",config_item.reset);
//                 finish_item(config_item);
//                 end 
//             end 
//         
//         endtask : derst
   
  
  
endclass : LCD_CONTROLLER_MASTER_seq


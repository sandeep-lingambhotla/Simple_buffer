class simple_driver extends uvm_driver#(simple_pkt);
  `uvm_component_utils(simple_driver)
  
  virtual simple_intf vif;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    void'(uvm_config_db #(virtual interface simple_intf)::get(null, "*", "simple_vif", vif));
      
  endfunction // build_phase
      
   task run_phase(uvm_phase phase);
     drive();
   endtask //run_phase
      
      virtual task drive();
        simple_pkt pkt;
        @(posedge vif.clk);
        vif.reset = 1;
        @(posedge vif.clk);
        vif.reset = 0;
        
        forever begin
          @(posedge vif.clk)
          seq_item_port.get_next_item(pkt);
          vif.in = pkt.in;
          seq_item_port.item_done();          
        end      
      endtask
      
endclass // simple_driver

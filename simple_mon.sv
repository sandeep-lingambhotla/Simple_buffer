class simple_input_mon extends uvm_monitor;
  `uvm_component_utils(simple_input_mon)
  
  uvm_analysis_port#(simple_pkt) input_port;
  
  virtual interface simple_intf vif;
    
    function new (string name, uvm_component parent);
      super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      void'(uvm_config_db#(virtual interface simple_intf)::get(null, "*", "simple_vif", vif));
      input_port = new(.name("input_port"), .parent(this));
        
    endfunction // build_phase
        
    task run_phase(uvm_phase phase);
      simple_pkt pkt;
      pkt = simple_pkt::type_id::create(.name("pkt"), .contxt(get_full_name()));
      forever begin
        @(posedge vif.clk)
        pkt.in = vif.in;
        //`uvm_info("Mon", $sformatf("Find me writing to input_port \n %s", pkt.sprint()), UVM_LOW)
        input_port.write(pkt);
      end
    endtask
endclass
        
class simple_output_mon extends uvm_monitor;
  `uvm_component_utils(simple_output_mon)
  
  uvm_analysis_port#(simple_pkt) output_port;
  
  virtual interface simple_intf vif;
    
    function new (string name, uvm_component parent);
      super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      void'(uvm_config_db#(virtual interface simple_intf)::get(null, "*", "simple_vif", vif));
        output_port = new(.name("output_port"), .parent(this));
        
    endfunction // build_phase
        
    task run_phase(uvm_phase phase);
      simple_pkt pkt;
      pkt = simple_pkt::type_id::create(.name("pkt"), .contxt(get_full_name()));
      forever begin
        @(posedge vif.clk)
        pkt.out = vif.out;
        //`uvm_info("Mon", $sformatf("Find me writing to output_port \n %s", pkt.sprint()), UVM_LOW)
        output_port.write(pkt);
      end
    endtask
endclass

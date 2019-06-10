class simple_agent extends uvm_agent;
  `uvm_component_utils(simple_agent)
  
  uvm_analysis_port#(simple_pkt) input_port;
  uvm_analysis_port#(simple_pkt) output_port;
  
  simple_sequencer     sequencer;
  simple_driver        driver   ;
  simple_output_mon    output_mon;
  simple_input_mon     input_mon;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("agent", $sformatf("Find me inside agent new"), UVM_LOW)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("agent", $sformatf("Find me inside agent build_phase"), UVM_LOW)
    
    input_port  = new(.name("input_port"),  .parent(this));
    output_port = new(.name("output_port"), .parent(this));
    
    sequencer   = simple_sequencer::type_id::create(.name("sequencer"),  .parent(this));
    driver      = simple_driver::type_id::create(.name("driver"),        .parent(this));
    output_mon  = simple_output_mon::type_id::create(.name("output_mon"),.parent(this));
    input_mon   = simple_input_mon::type_id::create(.name("input_mon"),  .parent(this));
    
  endfunction // build_phase
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("agent", $sformatf("Find me inside agent connect_phase"), UVM_LOW)
    
    driver.seq_item_port.connect(sequencer.seq_item_export);
    input_mon.input_port.connect(input_port);
    output_mon.output_port.connect(output_port);
    
  endfunction // connect_phase
    
    
endclass
  

class simple_env extends uvm_env;
  `uvm_component_utils(simple_env)
  
  simple_agent agent;
  simple_sb    sb;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("env", $sformatf("Find me inside env new"), UVM_LOW)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("env", $sformatf("Find me inside env build_phase"), UVM_LOW)
    agent = simple_agent::type_id::create(.name("agent"), .parent(this));
    sb    = simple_sb::type_id::create(.name("sb"),       .parent(this));
  endfunction // build_phase
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("env", $sformatf("Find me inside env connect_phase"), UVM_LOW)
    agent.input_mon.input_port.connect(sb.input_port);
    agent.output_mon.output_port.connect(sb.output_port);
  endfunction // connect_phase
  
endclass
  
  
  

class simple_test extends uvm_test;
  `uvm_component_utils(simple_test)
  
  simple_env env;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = simple_env::type_id::create(.name("env"), .parent(this));
  endfunction // build_phase
  
  task run_phase(uvm_phase phase);
    simple_sequence seq;
    
    phase.raise_objection(.obj(this));
    seq = simple_sequence::type_id::create(.name("seq"), .parent(this));
    assert(seq.randomize());
    seq.start(env.agent.sequencer);
    phase.drop_objection(.obj(this));
  endtask // run_phase
  
endclass

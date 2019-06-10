class simple_sequence extends uvm_sequence#(simple_pkt);
  `uvm_object_utils(simple_sequence)
  
  int count;
  
  function new(string name="simple_sequence");
    super.new(name);
  endfunction
  
  task body();
    simple_pkt pkt;
    
    repeat(100) begin
      pkt = simple_pkt::type_id::create(.name("pkt"), .contxt(get_full_name()));
      start_item(pkt);
      assert(pkt.randomize());
      if(count > 5) pkt.in = 1
      //`uvm_info("pkt_created", pkt.sprint(), UVM_LOW)
      finish_item(pkt);
      count++;
    end
  endtask // body
  
endclass

typedef uvm_sequencer#(simple_pkt) simple_sequencer;
  
  

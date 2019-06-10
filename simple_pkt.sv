class simple_pkt extends uvm_sequence_item;
  rand bit in;
  bit out;
  
  `uvm_object_utils_begin(simple_pkt)
  `uvm_field_int(in,  UVM_DEFAULT)
  `uvm_field_int(out, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new(string name="simple_pkt");
    super.new(name);
    
    in  = 0;
    out = 0;
  endfunction
  
endclass // simple_pkt

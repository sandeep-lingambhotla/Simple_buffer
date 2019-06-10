class simple_sb extends uvm_scoreboard;
  `uvm_component_utils(simple_sb)
  
  `uvm_analysis_imp_decl(_input_port);
  `uvm_analysis_imp_decl(_output_port);
  
  simple_pkt  in_pkt,out_pkt;
  virtual interface simple_intf vif;
  
  uvm_analysis_imp_input_port  #(simple_pkt, simple_sb)  input_port;
  uvm_analysis_imp_output_port #(simple_pkt, simple_sb)  output_port;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    input_port  = new("input_port",  this);
    output_port = new("output_port", this);
    in_pkt      = new();
    out_pkt     = new();
    `uvm_info("SB", $sformatf("Find me inside SB new"), UVM_LOW)
  endfunction
    
  
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    void'(uvm_config_db#(virtual interface simple_intf)::get(null, "*", "simple_vif", vif));
    endfunction
  
      task run_phase(uvm_phase phase);
//        fork
        
//          begin
//           forever begin
//            if(in_pkt.in) begin
//             repeat(1)(@posedge vif.clk)
//             if(in_pkt.in) begin
//               repeat(1)(@posedge vif.clk)
//               if(!out_pkt.out) `uvm_error("simple_sb", "Mismatch between input and output")
// .           end
//            end 
//           end // forever         
//          end  // begin after fork

//        join_none
      endtask
      
  extern function void write_input_port(simple_pkt pkt);
  extern function void write_output_port(simple_pkt pkt);
  //extern task wait_for_two_cycles();
endclass
    
    function void simple_sb::write_input_port(simple_pkt pkt);
      `uvm_info("SB", $sformatf("Find me inside SB write_input_port pkt sent is \n %s", pkt.sprint()), UVM_LOW)
      in_pkt = pkt;
    endfunction // write_input_port
    
    function void simple_sb::write_output_port(simple_pkt pkt);
      `uvm_info("env", $sformatf("Find me inside SB write_output_port pkt received is \n %s", pkt.sprint()), UVM_LOW)
      out_pkt = pkt;
    endfunction // write_output_port
    

   
   

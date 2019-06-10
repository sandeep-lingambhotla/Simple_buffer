// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
`include "simple_intf.sv"

module top();
     import uvm_pkg::*;
  
    `include "simple_pkt.sv"
    `include "simple_mon.sv"
    `include "simple_sequencer.sv"
    `include "simple_driver.sv"
    `include "simple_agent.sv"
    `include "simple_sb.sv"
    `include "simple_env.sv"
    `include "simple_test.sv"
  
  simple_intf intf();
  bit  clk;
 
  bit  reset;
  bit  in;
  bit  out;
  

      
  
  initial begin
    // Dump waves
    
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    `uvm_info("top", $sformatf("Find me inside top"), UVM_LOW)
    
    uvm_config_db #(virtual interface simple_intf)::set(null, "*", "simple_vif", intf);
    clk = 0;
    intf.clk = 0;
      run_test("simple_test");
  end
  
  initial begin
    forever begin
      #5 clk = ~clk;
      intf.clk = clk;
    end
  end
      
        
      simple dut(.clk    (intf.clk), 
                 .reset  (intf.reset), 
                 .in     (intf.in), 
                 .out    (intf.out)
                );
  
endmodule

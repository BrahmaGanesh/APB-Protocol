`include "apb_interface.sv"
`include "apb_package.sv"
module top;
  import apb_pkg::*;
  bit pclk;
  apb_interface intf(pclk);
  slave dut(intf);
  apb_env env;
  
  initial begin
    forever #5 pclk=~pclk;
  end
  
  initial begin
    intf.rst_n=0;
    #10 intf.rst_n=1;
  end
  initial begin
      #2000;
    env.soc.report();
    $display("Coverage of APB monitor: %0.2f%%", env.mon.cg.get_coverage());
    $finish;
  end
  initial begin
    env=new(intf);
    env.build();
    env.run();
  end
endmodule
  
  
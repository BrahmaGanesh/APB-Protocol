`include "apb_interface.sv"
`include "apb_package.sv"
module top;
  import apb_pkg::*;
  bit pclk;
  apb_interface intf(pclk);
  slave dut(intf);
  apb_genarator gen;
  apb_driver drv;
  apb_monitor mon;
  mailbox mbxgd;
  mailbox mbxdm;
  
  initial begin
    forever #5 pclk=~pclk;
  end
  
  initial begin
    intf.rst_n=0;
    #10 intf.rst_n=1;
    #40;
  end
  initial begin
      #2000;
    $finish;
  end
  initial begin
    mbxgd=new();
    mbxdm=new();
    gen=new(mbxgd);
    drv=new(intf,mbxgd);
    mon=new(intf);
    fork
      gen.run();
      drv.run();
      mon.run();
    join_none
  end
endmodule
  
  
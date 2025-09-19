interface apb_interface(input bit pclk);
  logic rst_n;
  logic [31:0] pwdata;
  logic [31:0] paddr;
  logic [31:0] prdata;
  logic pwrite;
  logic penable;
  logic pslaverr;
  logic psel,pready;
  
  clocking cb_drv @(posedge pclk);
    default input #1 output #1;
    output pwrite,pwdata,paddr,penable,psel;
    input prdata,pready,pslaverr;
  endclocking
  
  clocking cb_mon @(posedge pclk);
    input pwrite,pwdata,paddr,penable,psel,pready,prdata,pslaverr;
  endclocking
endinterface
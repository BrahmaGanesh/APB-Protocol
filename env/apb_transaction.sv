class apb_transaction;
  rand bit [31:0] pwdata;
  rand bit [31:0] paddr;
  rand bit pwrite;
  bit [31:0] prdata;
  bit penable;
  bit psel;
  bit pready;
  bit pslaverr;
  
  constraint pwrite_c {soft pwrite inside {0,1};}
  constraint paddr_c {paddr <32;}
  
  function void display(string a);
    $display("[%0t] [%s] penable=%d psel=%d pwrite=%d pready=%d pwdata=%0d paddr=%0d prdata=%0d",$time,a,this.penable,this.psel,this.pready,this.pwrite,this.pwdata,this.paddr,this.prdata);
  endfunction
endclass
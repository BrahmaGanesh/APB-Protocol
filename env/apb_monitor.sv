class apb_monitor;
  virtual apb_interface vif;
  apb_transaction tr;
  function new(virtual apb_interface vif);
    this.vif=vif;
  endfunction
  
  task run();
    forever begin
      tr=new();
      @(vif.cb_mon iff(vif.cb_mon.psel && !vif.cb_mon.penable));
        @(vif.cb_mon iff(vif.cb_mon.psel && vif.cb_mon.penable && vif.cb_mon.pready));
          tr.pwdata  = vif.pwdata;
          tr.paddr = vif.paddr;
          tr.pwrite = vif.pwrite;
          tr.prdata =vif.prdata;
          tr.psel =vif.psel;
          tr.penable =vif.penable;
          tr.pready =vif.pready;
          tr.pslaverr =vif.pslaverr;
          tr.display("MON");
          #1;
    end
  endtask
endclass
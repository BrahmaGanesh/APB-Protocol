class apb_monitor;
  virtual apb_interface vif;
  mailbox mbxms;
  apb_transaction tr;
  function new(virtual apb_interface vif,mailbox mbxms);
    this.vif=vif;
    this.mbxms=mbxms;
  endfunction
  
  task run();
    forever begin
      tr=new();
      @(vif.cb_mon);
      if(vif.cb_mon.psel && !vif.cb_mon.penable)begin
        @(vif.cb_mon);
        if(vif.cb_mon.psel && vif.cb_mon.penable)begin
          wait(vif.cb_mon.pready);
          tr.pwdata  = vif.pwdata;
          tr.paddr = vif.paddr;
          tr.pwrite = vif.pwrite;
          tr.prdata =vif.prdata;
          tr.psel =vif.psel;
          tr.penable =vif.penable;
          tr.pready =vif.pready;
          tr.pslaverr =vif.pslaverr;
          tr.display("MON");
        end
        mbxms.put(tr);
      end
    end
  endtask
endclass
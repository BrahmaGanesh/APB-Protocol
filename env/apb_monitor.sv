class apb_monitor;
  virtual apb_interface vif;
  mailbox mbxms;
  apb_transaction tr;
  
  covergroup cg;
    coverpoint vif.pwrite {
      bins write={1};
      bins read={0};}
   coverpoint vif.pwdata {
    bins all_values[] = {[0:2**32-1]};
  }
  endgroup
  
  function new(virtual apb_interface vif,mailbox mbxms);
    this.vif=vif;
    this.mbxms=mbxms;
    cg=new();
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
          cg.sample();
        end
        mbxms.put(tr);
      end
    end
  endtask
endclass
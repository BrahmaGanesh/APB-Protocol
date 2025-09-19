class apb_driver;
  virtual apb_interface vif;
  apb_transaction tr;
  mailbox mbxgd;
  
  function new(virtual apb_interface vif,mailbox mbxgd);
    this.vif=vif;
    this.mbxgd=mbxgd;
  endfunction
  
  task run();
    forever begin
      tr=new();
      mbxgd.get(tr);
      @(vif.cb_drv);
      vif.cb_drv.psel<=1;
      vif.cb_drv.pwrite<=tr.pwrite;
      vif.cb_drv.pwdata<=tr.pwdata;
      vif.cb_drv.paddr<=tr.paddr;
      vif.cb_drv.penable<=0;
      @(vif.cb_drv);
      vif.cb_drv.penable<=1;
      tr.display("DRV");
      wait(vif.cb_drv.pready == 1 );
      @(vif.cb_drv);
       vif.cb_drv.psel<=0;
      vif.cb_drv.penable<=0;
      
      #1;

    end
  endtask
endclass
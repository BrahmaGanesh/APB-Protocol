class apb_env;
  apb_genarator gen;
  apb_driver drv;
  apb_monitor mon;
  apb_scoreboard soc;
  mailbox mbxgd;
  mailbox mbxdm;
  mailbox mbxms;
  
  virtual apb_interface intf;
  function new(virtual apb_interface intf);
    this.intf=intf;
  endfunction
  
  task build();
    mbxgd=new();
    mbxdm=new();
    mbxms=new();
    gen=new(mbxgd);
    drv=new(intf,mbxgd);
    mon=new(intf,mbxms);
    soc=new(intf,mbxms);
  endtask
  task run();
    #20;
    start_process();
  endtask
  task start_process();
     fork
      gen.run();
      drv.run();
      mon.run();
      soc.run();
    join_none
  endtask
endclass
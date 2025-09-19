class apb_genarator;
  apb_transaction tr;
  mailbox mbxgd;
  
  function new(mailbox mbxgd);
    this.mbxgd=mbxgd;
  endfunction
  
  task run();
    tr=new();
    for(int i=0;i<=20;i++)begin
      if(i<=10)begin
        assert(tr.randomize() with { pwrite == 1; paddr < 32; });
      end
      else begin
         assert(tr.randomize() with { pwrite == 0; paddr < 32; });
      end
      tr.display("GEN");
      mbxgd.put(tr);
      #1;
    end
  endtask
endclass
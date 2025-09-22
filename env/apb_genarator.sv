class apb_genarator;
  apb_transaction tr;
  mailbox mbxgd;
  
  function new(mailbox mbxgd);
    this.mbxgd=mbxgd;
  endfunction
  
  task run();
    for(int i=0;i<=40;i++)begin
          tr=new();
      if(i<=10)begin
        if(tr.randomize() with { pwrite == 1; paddr < 32; })begin
        tr.display("GEN");
      mbxgd.put(tr);
        end
      end
      else begin
        if(tr.randomize() with { pwrite == 0; paddr < 32; })begin
        tr.display("GEN");
      mbxgd.put(tr);
        end
      end
    end
  endtask
endclass
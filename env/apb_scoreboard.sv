class apb_scoreboard;
  virtual apb_interface vif;
  apb_transaction tr;
  mailbox mbxms;
  bit [31:0] ref_mem [0:31];
  int pass_count;
  int fail_count;
  int total_check;
  bit [31:0] expected;
  bit [31:0] actual;
  
  
  function new(virtual apb_interface vif,mailbox mbxms);
    this.vif=vif;
    this.mbxms=mbxms;
  endfunction
  
  task run();
    tr=new();
    forever begin
      mbxms.get(tr);
      @(vif.pclk);
      if(tr.pwrite)begin
        ref_mem[tr.paddr]=tr.pwdata;
        $display("[%0t] [SOC] Write : paddr=%d pwdata=%d",$time,tr.paddr,tr.pwdata);
      end
      else begin
        total_check++;
        expected = ref_mem[tr.paddr];
        actual=tr.prdata;
        if(expected == actual)begin
          pass_count++;
         $display("[SOC] PASS: addr=%0d expected=%0d actual=%0d",
         tr.paddr, expected, actual);
        end
        else begin
          fail_count++;
          $display("[SOC] FAIL: addr=%0d expected=%0d actual=%0d",
         tr.paddr, expected, actual);
        end
      end
    end
  endtask
   function void report();
    $display("==================================");
    $display(" APB Scoreboard Summary ");
    $display(" Total checks = %0d", total_check);
    $display(" Pass         = %0d", pass_count);
    $display(" Fail         = %0d", fail_count);
    $display("==================================");
  endfunction
endclass
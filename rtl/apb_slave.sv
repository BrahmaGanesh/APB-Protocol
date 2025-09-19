module slave(apb_interface intf);
  logic [31:0] mem [0:31];

  always_ff @(negedge intf.rst_n or posedge intf.pclk) begin
    if (!intf.rst_n) begin
      intf.prdata   <= 0;
      intf.pready   <= 0;
      intf.pslaverr <= 0;
      for (int i = 0; i < 32; i++) mem[i] <= 0;
    end
    else begin
      intf.pready <= 0;
      if (intf.psel && !intf.penable) begin
        intf.pready <= 0;
      end
      else if (intf.psel && intf.penable) begin
        intf.pready <= 1; 

        if (intf.pwrite) begin
          mem[intf.paddr] <= intf.pwdata;
        end
        else begin
          intf.prdata <= mem[intf.paddr];
        end
      end
    end
  end

endmodule

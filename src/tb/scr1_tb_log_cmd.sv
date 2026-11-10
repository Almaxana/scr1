module scr1_tb_log_cmd();

wire        clk   = scr1_top_tb_ahb.i_top.i_imem_ahb.clk;
wire [1:0]  resp  = scr1_top_tb_ahb.i_top.i_imem_ahb.imem_resp;
wire [31:0] instr = scr1_top_tb_ahb.i_top.i_imem_ahb.imem_rdata;

`define CSR scr1_top_tb_ahb.i_top.i_core_top.i_pipe_top.i_pipe_csr
`define MPRF scr1_top_tb_ahb.i_top.i_core_top.i_pipe_top.i_pipe_mprf

always_ff @(posedge clk) begin
    if (resp == 2'b01) begin
        if ((instr[6:0]   == 7'b0110011) &&
            (instr[14:12] == 3'b000)     &&
            (instr[31:25] == 7'b0100000)) begin
            $display("  mstatus: MIE=%b MPIE=%b",
                     `CSR.csr_mstatus_mie_ff, `CSR.csr_mstatus_mpie_ff);
            $display("  mie:     MSIE=%b MTIE=%b MEIE=%b",
                     `CSR.csr_mie_msie_ff, `CSR.csr_mie_mtie_ff, `CSR.csr_mie_meie_ff);
            $display("  mtvec:   MODE=%b (0-direct, 1-vectored)",
                     `CSR.csr_mtvec_mode_ff);
            $display("  mepc:    %h", {`CSR.csr_mepc_ff, 1'b0});
            $display("  mcause:  INTERRUPT=%b CODE=%0d",
                     `CSR.csr_mcause_i_ff, `CSR.csr_mcause_ec_ff);
            for (int i = 1; i <= 6; i++) begin
                $display("  x%0d = %h", i, `MPRF.mprf_int[i]);
            end
            for (int i = 28; i <= 29; i++) begin
                $display("  x%0d = %h", i, `MPRF.mprf_int[i]);
            end
        end
    end
end

endmodule
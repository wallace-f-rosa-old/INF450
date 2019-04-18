`ifndef _branch_unit
`define _branch_unit

module branch_unit(
    input wire clk, //clock
    output wire WRt, //manda a tabela atualizar a tag 
    output wire WRp, //manda a tabela atualizar a predição
    input wire H, //h do fetch
    input wire P, //p do fetch
    input wire Hd, //h do decode
    input wire Pd, //p do decode
    input wire B, //se a instrução é um beq ou não
    input wire C, //comparador data1==data2(se o beq desvia ou não)
    output reg flush_s1 //da flush na barreira s1 se precisar desfazer algo
    output wire [1:0] MUX_B, //mux que contra o fluxo do PC
);

always @(posedge clk) 
begin
    if((B == 1'b0) && (H == 1'b0)) begin
        MUX_B <= 2'b0;
        WRp <= 1'b0;
        WRt <= 1'b0;
        flush_s1 <= 0;
    end else if ((H == 1'b1)&&(P == 1'b0)) begin
        MUX_B <= 2'b0;
        WRp <= 1'b0;
        WRt <= 1'b0;
        flush_s1 <= 0;
    end else if ((H == 1'b1)&&(P == 1'b0)) begin
        MUX_B <= 2'b01;
        WRp <= 1'b0;
        WRt <= 1'b0;
        flush_s1 <= 0;
    end else if ((H == 1'b0)&&(Hd == 1'b0)&&(C==1'b0)&&(B==1'b1)) begin
        MUX_B <= 2'b00;
        WRp <= 1'b1;
        WRt <= 1'b1;
        flush_s1 <= 0;
    end   
end

endmodule

`endif
`ifndef _branch_table
`define _branch_table

module branch_table(
    input wire clk, //clock
    input wire [31:0] pc4, //PC+4 do fetch
    input wire WRt, //decide se atualiza a tag de uma linha da tabela
    input wire WRp,//decide se atualiza o palpite de uma linha da tabela
    input wire [31:0] BdestIN, //qual o PC de destino do beq que entra
    output wire [31:0] Bdest, //PC destino (se a instrução estiver cadastrada)
    input wire Pin, //se for atualizar palpite, qual é o palpite novo
    output wire P, //palpite cadastrado na tabela
    output wire H, //hit (ou não)
    input wire [31:0] PC4d //PC+4 que vem do decode
);

    reg wire P, reg wire [31:0] Bdest;
    parameter BM_DATA = "BM_DATA.txt";
    reg [25:0] tag [0:15];
    reg pred[0:15];
    reg [31:0] dest [0:15];

initial begin
    $redmemh(BM_DATA,tag,0,15);
end

    always @(posedge clk) begin
        if(WRt) begin //cadastrando instrução
            tag[PC4d[5:2]] = PC4d[31:6];
            dest[PC4d[5:2]] = BdestIN;    
        end
        if (WRp) begin //atualiza predição
            pred[PC4d[5:2]] = Pin;
        end
        assign Bdest = dest[pc4[5:2]][31:0];
        assign H = (tag[pc4[5:2]] == pc4[31:6]);
        assign P = pred[pc4[5:2]];
    end


endmodule

`endif
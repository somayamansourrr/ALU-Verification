//interface intf(input logic clock);
interface intf();
  logic reset;
  logic [3:0] ALU_Sel;
  logic [7:0] A;
  logic [7:0] B;
  logic [7:0] ALU_Out;
  logic CarryOut;
endinterface: intf

interface clk_if();
  logic tb_clk;
  initial tb_clk<=0;
  always #10 tb_clk=~tb_clk;
endinterface


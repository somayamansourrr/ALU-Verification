`include "interface.sv"
`include "test.sv"

// Multiplication 0010 -> AND 1000 -> XNOR 1101
module testcase_17;
  bit tb_clk;
  intf intf_top();
  clk_if m_clk_if();
  
  alu DUT(intf_top.A, intf_top.B, intf_top.ALU_Sel, intf_top.ALU_Out, intf_top.CarryOut);
  
  initial begin
    test t0; 
    fork begin
      fork begin
  	intf_top.ALU_Sel=4'b0010;
    	t0=new();
    	t0.env.vif=intf_top;
    	t0.env.m_clk_vif=m_clk_if;
    	t0.env.gen.ALU_Sel=4'b0010;
    	t0.run(); 
        end
        
        #10 intf_top.ALU_Sel=4'b1000;
   	#10 t0.env.gen.ALU_Sel=4'b1000;
  
        #20 intf_top.ALU_Sel=4'b1101;
   	#20 t0.env.gen.ALU_Sel=4'b1101;

   join 
end
join_any
    #200 $finish;

  end
endmodule 

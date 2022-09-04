class transaction;
  rand bit [7:0] A;
  rand bit [7:0] B;
  bit [3:0] ALU_Sel;
  
  bit reset;
  bit [7:0] ALU_Out;
  bit CarryOut;

  function new(bit [3:0] ALU_Sel);
	this.ALU_Sel=ALU_Sel;
  endfunction 

 
  function void print ();
    $display("*******Transaction*******");
    $display("Inputs a = %0h, b = %0h, ALU_Sel=%0h and ALU_Out = %0h CarryOut=%0h", A, B, ALU_Sel, ALU_Out,CarryOut);
  endfunction: print
  
  function void copy (transaction tr);
    this.A=tr.A;
    this.B=tr.B;
    this.ALU_Sel=tr.ALU_Sel;
    this.ALU_Out=tr.ALU_Out;
    this.CarryOut=tr.CarryOut;
    this.reset=tr.reset;
  endfunction
  
endclass

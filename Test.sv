`include "environment.sv"

class test;
  environment env;
  mailbox drv_mbx;
  bit [3:0] ALU_Sel;
  


function new();
    drv_mbx=new();
    env=new();
  endfunction 



  virtual task run();
    env.driv.gen2driv=drv_mbx;
    env.run();
  endtask


  
endclass


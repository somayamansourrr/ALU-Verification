`include "transaction.sv"

class generator;
  transaction tx;
  bit [3:0] ALU_Sel;
  mailbox gen2driv;
  event drv_done;
  int tx_count=4;
  

  
  task main();
    $display("[ GENERATOR ] ****** GENERATOR STARTED ******");
    for(int i=0; i<tx_count;i++) begin
      tx = new(ALU_Sel);
      $display("Generator ALU_Sel=%0d, time=%0t", tx.ALU_Sel,$time);
      assert(tx.randomize());
      tx.print();
      $display("reset=%0b",tx.reset);
      gen2driv.put(tx);
      @(drv_done);
    end
    $display("[ GENERATOR ] ****** GENERATOR ENDED ******");
  endtask
endclass


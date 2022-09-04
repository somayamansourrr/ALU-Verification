class driver;
  int tx_count;
  event drv_done;
  
  virtual clk_if m_clk_vif;
  virtual intf intf_vi;
  
  mailbox gen2driv;


  task main;
    $display("[ DRIVER ] ****** DRIVER STARTED ******");
    forever begin
      transaction tx;
      gen2driv.get(tx);
      $display("Driver ALU_Sel=%0d, time=%0t", tx.ALU_Sel, $time);
      @(posedge m_clk_vif.tb_clk);
      //tx_count1++;
      intf_vi.reset <= tx.reset;
      intf_vi.A <= tx.A;
      intf_vi.B <= tx.B;
      intf_vi.ALU_Sel <= tx.ALU_Sel;
      -> drv_done;
    end
    $display("[ DRIVER ] ****** DRIVER ENDED ******");
  endtask
endclass


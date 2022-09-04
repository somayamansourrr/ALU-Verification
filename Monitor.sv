class monitor;
  virtual intf vif;
  virtual clk_if m_clk_if;
  
  mailbox mon_to_sb;

  task main;
    forever begin
      transaction mon_tr=new(vif.ALU_Sel);
     
      @(posedge m_clk_if.tb_clk);
      #1;
         $display("Monitor ALU_Sel=%0d, A=%0d, time=%0t", vif.ALU_Sel, vif.A, $time);
      	mon_tr.A = vif.A;
      	mon_tr.B = vif.B;
        mon_tr.ALU_Sel = vif.ALU_Sel;
      	mon_tr.ALU_Out = vif.ALU_Out;
      	mon_tr.CarryOut = vif.CarryOut;
      	mon_tr.reset=vif.reset;
      mon_to_sb.put(mon_tr);
    end
  endtask
endclass

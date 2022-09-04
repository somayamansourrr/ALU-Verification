//`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "coverage.sv"


class environment;

  generator gen;
  driver driv;
  monitor mon;
  scoreboard scb;
  coverage ccg;

  
  mailbox gen2driv;
  mailbox mon_to_sb;
  bit [3:0] ALU_Sel;
  event drv_done;
  event passed;
  
  virtual intf vif;
  virtual clk_if m_clk_vif;
 

 function new();
    gen2driv = new();
    mon_to_sb=new();

    gen=new();
    driv=new();
    mon=new();
    scb=new();
    ccg=new;

    
  endfunction 


  task test();
    fork
      gen.main();
      driv.main();
      mon.main();
      scb.main();
      ccg.main();
    join_any

  endtask
  
  
  task run;
    driv.intf_vi=vif;
    mon.vif=vif;
    ccg.vif=vif;

    driv.m_clk_vif=m_clk_vif;
    mon.m_clk_if=m_clk_vif;
    ccg.m_clk_if=m_clk_vif;


    driv.gen2driv=gen2driv;
    gen.gen2driv=gen2driv;
    
    mon.mon_to_sb=mon_to_sb;
    scb.mon_to_sb=mon_to_sb;
    
    driv.drv_done=drv_done;
    gen.drv_done=drv_done;
    ccg.passed=passed;

    scb.passed=passed;
    
    test();
endtask

endclass


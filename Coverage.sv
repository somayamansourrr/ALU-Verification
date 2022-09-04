//`include "transaction.sv"
class coverage;
  virtual intf vif;
  virtual clk_if m_clk_if;
  event passed;
   
    covergroup cg @(passed);
     Instructions: coverpoint vif.ALU_Sel { option.weight=16;
				bins all []= {[0:$]}  ;
 			
                                    }
     Transitioning: coverpoint vif.ALU_Sel{ option.weight=1;
	bins transition = (4'b0010 => 4'b1000 => 4'b1101); }
    
  	endgroup
    
  function new();
    cg=new();
  endfunction
  
  
  task main();
    forever begin
      @(passed);
    	cg.sample();
          $display("Coverage=%0.2f %%", cg.get_coverage());
    end 

  endtask

endclass


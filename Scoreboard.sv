//typedef class transaction;
class scoreboard;
  int compare_cnt;
  mailbox mon_to_sb;
  event passed;

  
  task main;
    forever begin
      transaction tr,ref_tr;
      mon_to_sb.get(tr);
      
      ref_tr=new(tr.ALU_Sel);
      ref_tr.copy(tr);
      
     $display("Time=%0t", $time);
     $display("ALU_Sel=%0d, A=%0d", tr.ALU_Sel, tr.A);
     $display("Reference ALU_Sel=%0d", ref_tr.ALU_Sel);
      case(tr.ALU_Sel)
        4'b0000: // Addition 
          begin
            if(!ref_tr.reset)
              {ref_tr.CarryOut, ref_tr.ALU_Out} = ref_tr.A + ref_tr.B;
            else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
            
            if(ref_tr.ALU_Out==tr.ALU_Out) begin
              if(ref_tr.CarryOut==tr.CarryOut) begin
		
                $display("Addition-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
		//ccg.cg.start();
		-> passed;
	      end
              else begin
		$display("ALU_Sel=%0d" , tr.ALU_Sel);
                $display("Addition-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
  end            
end else begin
		$display("ALU_Sel=%0d" , tr.ALU_Sel);
                $display("Addition-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
            end
          end 
        4'b0001: // Subtraction
          begin
            if(!ref_tr.reset)
        {ref_tr.CarryOut, ref_tr.ALU_Out}= ref_tr.A - ref_tr.B;
            else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
            
            if(ref_tr.ALU_Out==tr.ALU_Out) begin
              $display("Subtraction-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
-> passed;            
end else
                $display("Subtraction-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        
        
          end
        4'b0010: // Multiplication
          begin
            if(!ref_tr.reset)
        {ref_tr.CarryOut, ref_tr.ALU_Out}= ref_tr.A * ref_tr.B;
            else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
            
            if(ref_tr.ALU_Out==tr.ALU_Out) begin
                $display("Multiplication-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
              -> passed;
     compare_cnt++;
          end
end

        4'b0011: // Division
          begin
            if(!ref_tr.reset)
        {ref_tr.CarryOut, ref_tr.ALU_Out}= ref_tr.A / ref_tr.B;
            else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
            
            if(ref_tr.ALU_Out==tr.ALU_Out) begin
              $display("Division-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
            -> passed;
	 end else
                $display("Division-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        
 
          end
        4'b0100: // Logical shift left
          begin
            if(!ref_tr.reset)
        {ref_tr.CarryOut, ref_tr.ALU_Out}= ref_tr.A <<1;
            else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
            
            if(ref_tr.ALU_Out==tr.ALU_Out) begin
              $display("Logical Shift Left-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
               -> passed;
	 end else
                $display("Logical Shift Left-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        
 
          end
         4'b0101: // Logical shift right
           begin
             if(!ref_tr.reset)
        {ref_tr.CarryOut, ref_tr.ALU_Out}= ref_tr.A >> 1;
             else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
             
             if(ref_tr.ALU_Out==tr.ALU_Out) begin
               $display("Logical Shift Right-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
          -> passed;
   end else
                $display("Logical Shift Right-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        
           end
         4'b0110: // Rotate left
           begin
             if(!ref_tr.reset)
        {ref_tr.CarryOut, ref_tr.ALU_Out}= {ref_tr.A[6:0], ref_tr.A[7]};
             else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
             
             if(ref_tr.ALU_Out==tr.ALU_Out) begin
               $display("Rotate Left-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
         -> passed;
  end else
                $display("Rotate Left-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        
    
           end
         4'b0111: // Rotate right
           begin
             if(!ref_tr.reset)
        {ref_tr.CarryOut, ref_tr.ALU_Out}= {ref_tr.A[0],ref_tr.A[7:1]} ;
             else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
             
             if(ref_tr.ALU_Out==tr.ALU_Out) begin
                 $display("Rotate Right-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
         -> passed;
       end else
                $display("Rotate Right-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        
     
           end
          4'b1000: //  Logical and 
            begin
              if(!ref_tr.reset)
        {ref_tr.CarryOut, ref_tr.ALU_Out}= ref_tr.A & ref_tr.B;
              else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
              if(ref_tr.ALU_Out==tr.ALU_Out) begin
                $display("Logical AND-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        -> passed;
         end else
                $display("Logical AND-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        
     
      compare_cnt++;
            end
          4'b1001: //  Logical or
            begin
              if(!ref_tr.reset)
        {ref_tr.CarryOut, ref_tr.ALU_Out}= ref_tr.A | ref_tr.B;
              else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
              
              if(ref_tr.ALU_Out==tr.ALU_Out) begin
                  $display("Logical OR-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
      -> passed;
          end else
                $display("Logical OR-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        
     
            end
          4'b1010: //  Logical xor 
           begin
             if(!ref_tr.reset)
        {ref_tr.CarryOut, ref_tr.ALU_Out}= ref_tr.A ^ ref_tr.B;
             else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
             
             if(ref_tr.ALU_Out==tr.ALU_Out) begin
                $display("Logical XOR-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
            -> passed;
    end else
                $display("Logical XOR-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        
    
           end
          4'b1011: //  Logical nor
            begin
              if(!ref_tr.reset)
        {ref_tr.CarryOut, ref_tr.ALU_Out}= ~(ref_tr.A | ref_tr.B);
              else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
              
              if(ref_tr.ALU_Out==tr.ALU_Out) begin
                 $display("Logical NOR-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        -> passed;
          end else
                $display("Logical NOR-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        
     
            end
          4'b1100: // Logical nand 
            begin
              if(!ref_tr.reset)
              {ref_tr.CarryOut, ref_tr.ALU_Out}= ~( ref_tr.A & ref_tr.B);
              else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
              
              if(ref_tr.ALU_Out==tr.ALU_Out) begin
                $display("Logical NAND-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
           -> passed;
          end else 
                $display("Logical NAND-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        
       end
          4'b1101: // Logical xnor
            begin
              if(!ref_tr.reset)
        {ref_tr.CarryOut, ref_tr.ALU_Out}= ~(ref_tr.A ^ ref_tr.B);
              else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
              
              if(ref_tr.ALU_Out==tr.ALU_Out) begin
                $display("Logical XNOR-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        -> passed;
      end else
                $display("Logical XNOR-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        
    
            end
          4'b1110: // Greater comparison
            begin
              if(!ref_tr.reset)
        {ref_tr.CarryOut, ref_tr.ALU_Out}= (ref_tr.A > ref_tr.B)?8'd1:8'd0;
              else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
              
              if(ref_tr.ALU_Out==tr.ALU_Out) begin
                $display("Greater Comparison-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
         -> passed;
          end else
                $display("Greater Comparison-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
        
           end
          4'b1111: // Equal comparison   
            begin
              if(!ref_tr.reset)
        {ref_tr.CarryOut, ref_tr.ALU_Out}= (ref_tr.A==ref_tr.B)?8'd1:8'd0;
              else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
              
              if(ref_tr.ALU_Out==tr.ALU_Out) begin
                $display("Equal Comparison-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
          -> passed;
            end else
                $display("Equal Comparison-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
         end
          default: 
            begin
              if(!ref_tr.reset)
              {ref_tr.CarryOut, ref_tr.ALU_Out} = ref_tr.A + ref_tr.B;
            else
            {ref_tr.CarryOut, ref_tr.ALU_Out}=0;
            
            if(ref_tr.ALU_Out==tr.ALU_Out) begin
              if(ref_tr.CarryOut==tr.CarryOut) begin
		
                $display("Addition-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
		//ccg.cg.start();
		-> passed;
	      end
              else begin
		$display("ALU_Sel=%0d" , tr.ALU_Sel);
                $display("Addition-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
  end            
end else begin
		$display("ALU_Sel=%0d" , tr.ALU_Sel);
                $display("Addition-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", tr.A, tr.B, tr.ALU_Out, tr.CarryOut);
            end
         end
        endcase
      end 
  endtask
endclass


Problem													
The Oakfield Corporation manufactures tables and chairs.  A table requires 1 hour of labour and 9 square board metres of wood, and a chair requires 1 hour of labour and 5 square board metres of wood.  Currently, 6 hours of labour and 45 square board metres of wood are available.  Each table contributes R8 to profit, and each chair contributes R5 to profit.  Formulate and solve an IP to maximise Oakfield’s profit.													
                                                    
                                                    
Decision Variables						
x1 =	# of tables manufactured					
x2 =	# of chairs manufactured					

Integer Programming Model							
Max z =	8x1	+	5x2				
s.t	x1	+	x2	≤	6		Labour restriction
    9x1	+	5x2	≤	45		Carpentry restriction
    x1, x2	≥	0				
    x1, x2	integer					when relaxing, we take out the integer constraint, then we do a solver


Solver: Primary IP 		ran a solver on excel to get this... do we need it in branch&bound?				
    x1	x2	ref.	sign	rhs	
var.	3.75	2.25				
obj.	8	5	41.25	=	max	
s.t.	1	1	6	≤	6	
    9	5	45	≤	45	


convert to canonical
Canonical						
Max z ->						
    -8x1	-5x2		=	0	
    +x1	+x2	+s1	=	6	
    +9x1	+5x2	+s2	=	45	
                        

Branch & Bound Algorithm									
                                    
    T-i	x1	x2	s1	s2	rhs	ratio		using primal, it is feasible, but not optimal (negatives in Z row)
    z	-8	-5			0			pivot column = greatest negative (x1)
    labour	1	1	1		6	6		pivot row = smallest POSITIVE ratio
    wood	9	5		1	45	5		
                                    
    T-2	x1	x2	s1	s2	rhs	ratio		using primal, it is feasible, but not optimal (negatives in Z row)
    z	0    	- 5/9	0    	 8/9	40    			pivot column = greatest negative (x1)
    labour	0    	 4/9	1    	- 1/9	1    	2 1/4		pivot row = smallest POSITIVE ratio
    wood	1    	 5/9	0    	 1/9	5    	9    		
                                    
    T-3	x1	x2	s1	s2	rhs			
    z	0    	0    	1 1/4	 3/4	41 1/4			
    labour	0    	1    	2 1/4	- 1/4	2 1/4			
    wood	1    	0    	-1 1/4	 1/4	3 3/4			


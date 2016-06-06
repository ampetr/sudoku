/*********************************************
 * OPL 12.6.0.0 Model
 * Author: Anna
 * Creation Date: Jun 4, 2016 at 10:41:52 PM
 *********************************************/

 int ndigits = 9; // update the box dimension 
 int sqrt_ndigits = 3; // this number should be the square root of the above number 
 
 range N = 1..ndigits;
 range Ns = 1..sqrt_ndigits; 
 
 dvar int+ x[N][N][N] in 0..1;
  
 minimize 0; 
  
 
 subject to{
 
 	forall(val in N){
 		// each row should have 1..N
		forall(row in N){
			sum(i in N)(x[val][row][i]) == 1;
		 }
		
		// each column should have 1..N 
		forall(col in N){
			sum(i in N)(x[val][i][col]) == 1 ; 
		}
		
		// each box should have 1..N
		forall(b1 in Ns){ // eg 1..2
			forall(b2 in Ns){
				sum(i in Ns)(sum(j in Ns)(x[val][i + (b1-1)*sqrt_ndigits ][j+ (b2-1)*sqrt_ndigits ])) ==1 ;
			}
		}

 	}
 	
 	forall(row in N){
 		forall(col in N){
 			sum(val in N)(x[val][row][col]) == 1; // cant assign more than one value to a cell 		
 		}
 		   	
 	}
// here add the values that were initially specified
// eventually will add a script to read these from file 
//x[1][2][3]==1; // means row 2, column 3 is a 1 

 }
 
 execute show_solution{ // print the solution to the scripting log window 
  
	var row = 1;
	var col, val, row_str, z; 
	
	var hr = "| ";
	var i = 1;
	while(i <= ndigits){
	 hr = hr + "-- ";
	 if( i % sqrt_ndigits == 0){
	 	hr = hr + "| "; 
	 }
	 i = i + 1;	
	}
	writeln(hr);
	while(row <= ndigits){
		col = 1; 
		row_str = "| ";
		while(col <= ndigits){
			val = 1;		
			while(val <= ndigits){
				if(x[val][row][col]==1){
					if(val < 10 ){
						val = " "+val;	
					}
					row_str = row_str + val + " ";
  				}
				val = val + 1;
  			}
  		if( col % sqrt_ndigits == 0){
	 		row_str = row_str + "| "; 
	 	}				
		col = col + 1;	
		}
		
	
	writeln(row_str); // new line 
	if( row % sqrt_ndigits==0){
		writeln(hr);	
	}
	
	row = row + 1;
	}
	 	
}	

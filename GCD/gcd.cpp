

int gcd (int a, int b){
	int done = 0;
	int a_temp = a;
	int b_temp = b;
	
	while (!done){
		if (a_temp < b_temp){
			swap = a_temp;
			a_temp = b_temp;
			b = swap;
		}
		else if (b_temp != 0)
			a_temp = a_temp - b_temp;
		else
			done = 1;
	}
	return a_temp; 
}


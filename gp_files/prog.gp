multiply (first_number, second_number) = 
{

	my(Rf = 1, first_17_primes = primes(17), first_machine_val = first_number, second_machine_val = second_number);
	
	for( i = 1, 7,
	Rf = Rf * first_17_primes[i]);
	print("Rf: " Rf);

	first_machine_val = first_machine_val * Rf;
	print("First machine val: "first_machine_val);

	second_machine_val = second_machine_val * Rf;
	print("Second machine val: "second_machine_val);
	
	

}

fibo (n) = 
{
	my(u0 = 0, u1 = 1);
	for( i = 2, n, [u0,u1] = [u1,u0 + u1]);
	u1;
}

rho(n) = 
{
	my(x=2 ,y=5);
	while(gcd(y-x,n) == 1,
		x = (x^2 + 1) %n;
		y = (y^2 + 1) %n;
		y = (y^2 + 1) %n
		);
	gcd(n, y-x);

}
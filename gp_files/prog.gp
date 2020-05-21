multiply (first_number, second_number) = 
{

	my(Rf = 1, first_18_primes = primes(18),
	first_machine_val = first_number, 
	second_machine_val = second_number,
	first_val_RNS = vector(18),
	second_val_RNS = vector(18)
	);
	
	print(first_18_primes);
	for( i = 1, 7,
	Rf = Rf * first_18_primes[i]);
	print("Rf: " Rf);

	first_machine_val = first_machine_val * Rf;
	print("First machine val: "first_machine_val);

	second_machine_val = second_machine_val * Rf;
	print("Second machine val: "second_machine_val);
	
	for( i = 1, 18,
	first_val_RNS[i] = Mod(first_machine_val, first_18_primes[i]);
	second_val_RNS[i] = Mod(second_machine_val, first_18_primes[i]);
	);
	print(first_val_RNS);
	print(second_val_RNS);

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
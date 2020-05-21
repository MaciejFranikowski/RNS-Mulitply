multiply (first_number, second_number) = 
{
	\\ Create necessary local variables.
	
	my(Rf = 1, first_18_primes = primes(18),
	first_machine_val = first_number, 
	second_machine_val = second_number,
	first_val_RNS = vector(18),
	second_val_RNS = vector(18),
	product_RNS = vector(18)
	);
	
	\\ Calcualte the Rf value, based on the first 7 prime numbers.
	print("\nFirst 18 primes: "first_18_primes);
	for( i = 1, 7,
	Rf = Rf * first_18_primes[i]);
	print("Rf: " Rf);

	\\ Calcualte the machine values of given numbers.
	first_machine_val = first_machine_val * Rf;
	print("\nFirst machine val: "first_machine_val);
	second_machine_val = second_machine_val * Rf;
	print("Second machine val: "second_machine_val);
	
	
	for( i = 1, 18,
	first_val_RNS[i] = Mod(first_machine_val, first_18_primes[i]);
	second_val_RNS[i] = Mod(second_machine_val, first_18_primes[i]);
	);
	print("\nFirst number in RNS: "first_val_RNS);
	print("\nSecond number in RNS: "second_val_RNS);


	for( i = 1, 18,
	product_RNS[i] = first_val_RNS[i] * second_val_RNS[i];
	);
	
	print("\nProduct of numbers in RNS: "product_RNS);
}



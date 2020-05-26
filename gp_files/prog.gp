multiply (first_number, second_number) = 
{
	\\ Create necessary local variables.
	my(Rf = 1, first_15_primes = primes(15),
	first_machine_val = first_number, 
	second_machine_val = second_number,
	first_val_RNS = vector(15),
	second_val_RNS = vector(15),
	product_RNS = vector(15)
	);
	
	\\ Calcualte the Rf value, based on the first 7 prime numbers.
	for( i = 1, 7,
	Rf = Rf * first_18_primes[i]);
	print("Rf: " Rf);

	\\ Calcualte the machine values of given numbers.
	first_machine_val = first_machine_val * Rf;
	print("\nFirst machine val:  "first_machine_val);
	second_machine_val = second_machine_val * Rf;
	print("Second machine val: "second_machine_val);
	
	\\ Calculate RNS values using IntMods from PARI.
	for( i = 1, 15,
	first_val_RNS[i] = Mod(first_machine_val, first_15_primes[i]);
	second_val_RNS[i] = Mod(second_machine_val, first_15_primes[i]);
	);
	print("\nFirst number in RNS:  "first_val_RNS);
	print("Second number in RNS: "second_val_RNS);

	\\ Calcuate the product of the RNS numbers.
	for( i = 1, 15,
	product_RNS[i] = first_val_RNS[i] * second_val_RNS[i];
	);
	print("\nProduct of numbers in RNS: "product_RNS);
	
	
	lifo = convert_RNS_to_MRN(product_RNS);
	print("\nProduct converted to MRN: "lifo);
	lifo_conversion = convert_MRN_to_RNS(lifo, product_RNS);
	print("Product, truncated and converted back to RNS: "lifo_conversion);
	
}


convert_RNS_to_MRN(vector_RNS) = 
{
	\\ Create local variables.
	my(skipped_Mods = vector(15),
	lifo = vector(30),
	i = 1
	);
	
	\\ Main loop, runs until the given RNS vector contains nothing but 0's.
	while(1 == 1,
	
	\\ Mod[i] skipped? If == 0 (not skipped ->  continue algo)  else   (skipped -> increment i)
	if(how_many_in_vector(skipped_Mods, vector_RNS[i].mod) == 0,
	
	\\ Push value[i] to Lifo, lift exctacts the value from intMod.
	lifo = vector_push(lifo, lift(vector_RNS[i]));

	\\ Is value[i] == 0? if yes, dont do anything, else subtract value[i] from vector_RNS[i].
	\\ The function calls can only pass arguments as values, so we have to assign the return
	\\ value of subtract_from_vector, otherwise nothing changes.
	if(lift(vector_RNS[i]) != 0, vector_RNS = subtract_from_vector(vector_RNS, lift(vector_RNS[i]), i));
	
	\\ Main exit condition, vector_RNS containing nothing but 0's
	if(how_many_in_vector(vector_RNS, 0) == 15, break;);
	
	\\ Add current Mod to skipped Mods.
	skipped_Mods[i] = vector_RNS[i].mod;

	\\ Divide A (vector_RNS) by Mod[i]
	vector_RNS = divide_By_Mi(vector_RNS, vector_RNS[i].mod);

	lifo = vector_push(lifo, vector_RNS[i].mod);


	);
	
	i = i + 1
	);
	lifo;
}


\\ Returns the number of how many times a value appears in the vector.
how_many_in_vector(tab,  value) =
{
	my(x = 0);
	
	for (i = 1, length(tab),
	if(lift(tab[i]) == value, x = x + 1 ));
	
	x;
}

\\ Subtracts a value from the WHOLE vector
\\ starting at position "from". 
subtract_from_vector(tab, value, from) =
{	
	\\ 'From' exists to not disturb values set earlier.	
	for (i = from, length(tab),
	tab[i] = tab[i] - value);
	
	tab;
}

\\ Divide the WHOLE vector by given value.
divide_By_Mi(tab, value)  = 
{
	for(i = 1, length(tab),
	tab[i] = Mod(lift(tab[i]) / value, tab[i].mod);
	);
	
	tab;
}

\\ Push a value to the given vector, act's as if the
\\ vector was a stack.
vector_push(tab, value) = 
{
	for( i = 1, length(tab) - 1,
	tab[length(tab) - i + 1] =  tab[length(tab) - i]);
	tab[1] = value;
	
	tab;
}

convert_MRN_to_RNS(lifo, vector_RNS) = 
{
	lifo_end = 0;
	
	i = 2;

	while( i + 13 <= length(lifo),	
		if( lifo[i] == 17 &&
			lifo[i+2] == 13 &&
			lifo[i+4] == 11 &&
			lifo[i+6] == 7 &&
			lifo[i+8] == 5 &&
			lifo[i+10] == 3 &&
			lifo[i+12] == 2 ,
			lifo_end = i;
		);
	i = i + 2;
	);
	result = vector(length(vector_RNS)); 

	for(i = 1, length(result),
		result[i] = Mod(0, vector_RNS[i].mod);
	);

	
	j = 1;
	for(k = 1, lifo_end/2,
		\\ Add
		for(i = 1, length(result),
			result[i] = Mod(lift(result[i]) + lifo[j], result[i].mod);
			
		);
		j= j + 1;

		if(k != lifo_end/2,
			\\ Mul
			for(i = 1, length(result),
				result[i] = Mod(lift(result[i]) * lifo[j], result[i].mod);
				
			);
		);
		j= j + 1;
	);
	result;

}

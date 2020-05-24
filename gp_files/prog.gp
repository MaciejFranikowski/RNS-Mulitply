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
	
	
	lifo = convert_RNS_to_MRN(product_RNS);
	lifo_conversion = convert_MRN_to_RNS(lifo, product_RNS);
	
	
}

convert_RNS_to_MRN_INTMODS(vector_RNS) = 
{
	my(skipped_Mods = vector(18),
	lifo = vector(36),
	i = 1
	);
	
	\\ Main loop, runs until the given RNS vector contains nothing but 0's
	while(1 == 1,
	print("\nLifo" , lifo);
	print("\nVector", vector_RNS);
	\\ M[i] skipped? If == 0 (not skipped ->  continue algo)  else   (skipped -> increment i)
	print("\nHow many in  vector skipped: ", how_many_in_vector(skipped_Mods, vector_RNS[i].mod)," i: ", i);
	print("\nCurrent mod:", vector_RNS[i].mod);
	print("\nSkipped_Mods: ", skipped_Mods);
	if(how_many_in_vector(skipped_Mods, vector_RNS[i].mod) == 0,
	
	\\ DIFFERENCE BETWEEN CONVERSION ALGORYTMS
	\\ Push d[i] to Lifo
	lifo = vector_push(lifo, vector_RNS[i]);

	\\ is d[i] == 0? if yes, dont do anything, else subtract d[i] from vector_RNS[i]
	\\ The function calls can only pass arguments as values, so we have to assign the return
	\\ value of subtract_from_vector, otherwise nothing changes.
	if(lift(vector_RNS[i]) != 0, vector_RNS = subtract_from_vector(vector_RNS, lift(vector_RNS[i]), i));
	
	\\ Main exit condition, vector_RNS containing nothing but 0's
	if(how_many_in_vector(vector_RNS, 0) == 18, break;);
	print("Is vector equal: ", how_many_in_vector(vector_RNS, 0));
	
	
	\\ Add current Mod to skipped Mods
	 skipped_Mods[i] = vector_RNS[i].mod;
	
	
	\\ Besides adding it co skipped mods, zero it's value
	\\ Zeroing vector_RNS[i], because it's skipped and we use that info for exiting the func.
	\\ vector_RNS[i] = Mod(0, vector_RNS[i].mod);

	\\ Divide A (vector_RNS) by Mi, aka the mod of the current [i]
	vector_RNS = divide_By_Mi(vector_RNS, vector_RNS[i].mod);
	
	\\ DIFFERENCE BETWEEN CONVERSION ALGORYTMS
	\\ lifo = vector_push(lifo, vector_RNS[i].mod);


	);
	
	i = i + 1
	);
	printf("LIFO IN THE END BOIIII:" lifo);
	lifo;
}

convert_RNS_to_MRN(vector_RNS) = 
{
	my(skipped_Mods = vector(18),
	lifo = vector(36),
	i = 1
	);
	
	\\ Main loop, runs until the given RNS vector contains nothing but 0's
	while(1 == 1,
	print("\nLifo" , lifo);
	print("\nVector", vector_RNS);
	\\ M[i] skipped? If == 0 (not skipped ->  continue algo)  else   (skipped -> increment i)
	print("\nHow many in  vector skipped: ", how_many_in_vector(skipped_Mods, vector_RNS[i].mod)," i: ", i);
	print("\nCurrent mod:", vector_RNS[i].mod);
	print("\nSkipped_Mods: ", skipped_Mods);
	if(how_many_in_vector(skipped_Mods, vector_RNS[i].mod) == 0,
	
	\\ Push d[i] to Lifo, lift exctacts the value from intMod
	lifo = vector_push(lifo, lift(vector_RNS[i]));

	\\ is d[i] == 0? if yes, dont do anything, else subtract d[i] from vector_RNS[i]
	\\ The function calls can only pass arguments as values, so we have to assign the return
	\\ value of subtract_from_vector, otherwise nothing changes.
	if(lift(vector_RNS[i]) != 0, vector_RNS = subtract_from_vector(vector_RNS, lift(vector_RNS[i]), i));
	
	\\ Main exit condition, vector_RNS containing nothing but 0's
	if(how_many_in_vector(vector_RNS, 0) == 18, break;);
	print("Is vector equal: ", how_many_in_vector(vector_RNS, 0));
	
	
	\\ Add current Mod to skipped Mods
	skipped_Mods[i] = vector_RNS[i].mod;
	
	
	\\ Besides adding it co skipped mods, zero it's value
	\\ Zeroing vector_RNS[i], because it's skipped and we use that info for exiting the func.
	\\ vector_RNS[i] = Mod(0, vector_RNS[i].mod);

	\\ Divide A (vector_RNS) by Mi, aka the mod of the current [i]
	vector_RNS = divide_By_Mi(vector_RNS, vector_RNS[i].mod);

	lifo = vector_push(lifo, vector_RNS[i].mod);


	);
	
	i = i + 1
	);
	printf("LIFO IN THE END BOIIII:" lifo);
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

subtract_from_vector(tab, value, from) =
{	
	\\my(x = vector(length(tab)));
	\\ from to not create chaos on early position of vector
	print("Vector RNS before subtracting:", tab);
	for (i = from, length(tab),
	tab[i] = tab[i] - value);
	\\tab[i] = Mod(lift(tab[i]) - value, value));
	print("Vector RNS after subtracting:", tab);
	tab;
	
}

divide_By_Mi(tab, value)  = 
{
	
	\\print("dividing by: "value);

	for(i = 1, length(tab),
	print("Tab[",i,"] before change: "tab[i]);
	\\ If the tab[i] can't be divided by value, add to it the modulo of that value
	\\ DOESNT WORK? WHY, NOT NEEDED?
	\\while(Mod(tab[i], value) != 0,
	\\print("tab[i] during change: "tab[i]);
	\\tab[i] = tab[i] + tab[i].mod);
	
	\\ Finally divide the tab[i] by the value
	\\ APPARENTLY THIS IS ENOUGH???
	tab[i] = Mod(lift(tab[i]) / value, tab[i].mod);
	print("Tab[i] after change:" tab[i]);
	);
	tab;

}

vector_push(tab, value) = 
{
	for( i = 1, length(tab) - 1,
	tab[length(tab) - i + 1] =  tab[length(tab) - i]);
	tab[1] = value;
	tab;
}

convert_MRN_to_RNS(lifo, vector_RNS) = 
{
	print("\n\n\n", lifo);
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

	print("Lifo end: ",lifo_end);
	result = vector(length(vector_RNS)); 

	for(i = 1, length(result),
		result[i] = Mod(0, vector_RNS[i].mod);
	);
	
	print("result: ", result);

	
	j = 1;
	for(k = 1, lifo_end/2,
		print(lifo[j]);
		\\ Add
		for(i = 1, length(result),
			result[i] = Mod(lift(result[i]) + lifo[j], result[i].mod);
			
		);
		j= j + 1;
		print("\n Result after adding: ", result);

		print(lifo[j]);
		if(k != lifo_end/2,
			\\ Mul
			for(i = 1, length(result),
				result[i] = Mod(lift(result[i]) * lifo[j], result[i].mod);
				
			);
		);
		j= j + 1;
		print("\nResult after multiplying: ", result);
	);


}

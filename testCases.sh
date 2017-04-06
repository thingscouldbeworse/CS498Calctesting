#! /bin/bash


# FUNCTIONAL SPECIFICATION 1
	# Test 1: Call executable by name
	echo "Executing Test 1"
	#./Calculator.exe

# FUNCTIONAL SPECIFICATION 2
	# Test 2: Run executable, check for message
	echo "Executing Test 2"
	./Calculator.exe < inputs/input2.txt > outputs/output2.txt
	diff -q outputs/output2.txt expOuts/expOut2.txt

# FUNCTIONAL SPECIFICATION 3
	# Test 3: Evaluate correct postfix expression
	echo "Executing Test 3a"
	./Calculator.exe < inputs/input3a.txt > outputs/output3a.txt
	diff -q outputs/output3a.txt expOuts/expOut3a.txt

	echo "Executing Test 3b"
	./Calculator.exe < inputs/input3b.txt > outputs/output3b.txt
	diff -q outputs/output3b.txt expOuts/expOut3b.txt

	echo "Executing Test 3c"
	./Calculator.exe < inputs/input3c.txt > outputs/output3c.txt
	diff -q outputs/output3c.txt expOuts/expOut3c.txt

	echo "Executing Test 3d"
	./Calculator.exe < inputs/input3d.txt > outputs/output3d.txt
	diff -q outputs/output3d.txt expOuts/expOut3d.txt

	# Test 4: Attempt to evaluate infix expression
	echo "Executing Test 4"
	./Calculator.exe < inputs/input4.txt > outputs/output4.txt
	diff -q outputs/output4.txt expOuts/expOut4.txt

# FUNCTIONAL SPECIFICATION 4
	# Test 5: Enter number less than or equal to 20 characters
	echo "Executing Test 5"
	./Calculator.exe < inputs/input5.txt > outputs/output5.txt
	diff -q outputs/output5.txt expOuts/expOut5.txt

	# Test 6: Enter number greater than 20 characters
	echo "Executing Test 6"
	./Calculator.exe < inputs/input6.txt > outputs/output6.txt
	diff -q outputs/output6.txt expOuts/expOut6.txt

# FUNCTIONAL SPECIFICATION 5
	# Test 7: Type "=" with an empty stack
	echo "Executing Test 7"
	./Calculator.exe < inputs/input7.txt > outputs/output7.txt
	diff -q outputs/output7.txt expOuts/expOut7.txt

	# Test 8: Enter number then "="
	echo "Executing Test 8"
	./Calculator.exe < inputs/input8.txt > outputs/output8.txt
	diff -q outputs/output8.txt expOuts/expOut8.txt

	# Test 9: Enter calculation then "="
	echo "Executing Test 9"
	./Calculator.exe < inputs/input9.txt > outputs/output9.txt
	diff -q outputs/output9.txt expOuts/expOut9.txt

# FUNCTIONAL SPECIFICATION 6
	# Test 10: Try to divide by 0, expect an error message
	echo "Executing Test 10"
	./Calculator.exe < inputs/input10.txt > outputs/output10.txt	
	diff -q outputs/output10.txt expOuts/expOut10.txt

# Function 7 testing
	printf "1 2 = c = q\n" > ./inputs/7.infile 
	./Calculator.exe < ./inputs/7.infile > ./outputs/7.outfile
	# expected output
	printf "\t2.000000\n\t1.000000\n" > ./expOuts/7.outfile_correct
	cmp -s ./outputs/7.outfile ./expOuts/7.outfile_correct || printf "test 7 failed\n"

# Function 8 testing
	printf "1\t2 3\n + + = q\n" > ./inputs/8.infile
	./Calculator.exe < ./inputs/8.infile > ./outputs/8.outfile
	# expected output
	printf "\t6.000000\n" > ./expOuts/8.outfile_correct
	cmp -s ./outputs/8.outfile ./expOuts/8.outfile_correct || printf "test 8 failed\n"

# Function 9 testing
	printf "1 2 3 4 5 6 7 8 9 = = a q\n" > ./inputs/9.infile
	./Calculator.exe < ./inputs/9.infile > ./outputs/9.outfile
	# Expected output
	printf "\t9.000000\n\t9.000000\nunknown command a\n" > ./expOuts/9.outfile_correct
	cmp -s ./outputs/9.outfile ./expOuts/9.outfile_correct || printf "test 9 failed\n"

# Function 10 testing
# numbers 0 to 99 (exactly 100 numbers on the stack)
# Need to clean infile because these printfs append instead of overwrite
	printf "" > ./inputs/10.infile
	for VARIABLE in {0..99}
	do
		printf $VARIABLE >> ./inputs/10.infile
		printf " " >> ./inputs/10.infile
	done
# Should still be fine
	printf "=" >> ./inputs/10.infile
# Now one number too many
	printf " 100 q\n" >> ./inputs/10.infile
	./Calculator.exe < ./inputs/10.infile > ./outputs/10.outfile
# Expected output
	printf "\t99.000000\nerror: stack full\n" > ./expOuts/10.outfile_correct
	cmp -s ./outputs/10.outfile ./expOuts/10.outfile_correct || printf "test 10 failed\n"

# Function 11 testing
	printf "" > ./inputs/11.infile
# All letters except q, then q at the end
# c is included but will have a silent output
	for VARIABLE in {a..p} {r..z}
	do
		printf $VARIABLE >> ./inputs/11.infile
		printf " " >> ./inputs/11.infile
	done
	printf "q\n" >> ./inputs/11.infile
	./Calculator.exe < ./inputs/11.infile > ./outputs/11.outfile
# Expected output
	printf "" > ./expOuts/11.outfile_correct
# Can't have c in this list because c outputs silently
	for VARIABLE in {a..b} {d..p} {r..z}
	do
		printf "unknown command " >> ./expOuts/11.outfile_correct
		printf $VARIABLE >> ./expOuts/11.outfile_correct
		printf "\n" >> ./expOuts/11.outfile_correct
	done
	cmp -s ./outputs/11.outfile ./expOuts/11.outfile_correct || printf "test 11 failed\n"

#! /bin/bash

# Kirk Hardy, Justin Poe

# Function 7 testing
printf "1 2 = c = q\n" > 7.infile 
./Calculator.exe < 7.infile > 7.outfile
# expected output
printf "\t2.000000\n\t1.000000\n" > 7.outfile_correct
cmp -s 7.outfile 7.outfile_correct || printf "test 7 failed\n"

# Function 8 testing
printf "1\t2 3\n + + = q\n" > 8.infile
./Calculator.exe < 8.infile > 8.outfile
# expected output
printf "\t6.000000\n" > 8.outfile_correct
cmp -s 8.outfile 8.outfile_correct || printf "test 8 failed\n"

# Function 9 testing
printf "1 2 3 4 5 6 7 8 9 = = a q\n" > 9.infile
./Calculator.exe < 9.infile > 9.outfile
# Expected output
printf "\t9.000000\n\t9.000000\nunknown command a\n" > 9.outfile_correct
cmp -s 9.outfile 9.outfile_correct || printf "test 9 failed\n"

# Function 10 testing
# numbers 0 to 99 (exactly 100 numbers on the stack)
# Need to clean infile because these printfs append instead of overwrite
printf "" > 10.infile
for VARIABLE in {0..99}
do
	printf $VARIABLE >> 10.infile
	printf " " >> 10.infile
done
# Should still be fine
printf "=" >> 10.infile
# Now one number too many
printf " 100 q\n" >> 10.infile
./Calculator.exe < 10.infile > 10.outfile
# Expected output
printf "\t99.000000\nerror: stack full\n" > 10.outfile_correct
cmp -s 10.outfile 10.outfile_correct || printf "test 10 failed\n"

# Function 11 testing
printf "" > 11.infile
# All letters except q, then q at the end
# c is included but will have a silent output
for VARIABLE in {a..p} {r..z}
do
	printf $VARIABLE >> 11.infile
	printf " " >> 11.infile
done
printf "q\n" >> 11.infile
./Calculator.exe < 11.infile > 11.outfile
# Expected output
printf "" > 11.outfile_correct
# Can't have c in this list because c outputs silently
for VARIABLE in {a..b} {d..p} {r..z}
do
	printf "unknown command " >> 11.outfile_correct
	printf $VARIABLE >> 11.outfile_correct
	printf "\n" >> 11.outfile_correct
done
cmp -s 11.outfile 11.outfile_correct || printf "test 11 failed\n"

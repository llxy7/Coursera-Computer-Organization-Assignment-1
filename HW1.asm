# Assignment 1, problem 1 of the Coursera open course "Computer Organization"

# Author: Sida Lu

# Date: May 26, 2018

# based on the "MIPS Assembly Programming Simplified" series video by Quasar Distant on YouTube

.data

	STR: .asciiz " Alpha Bravo China Delta Echo Foxtrot Golf Hotel India Juliet Kilo Lima Mary November Oscar Paper Quebec Research Sierra Tango Uniform Victor Whisky X-ray Yankee Zulu "
	str: .asciiz " alpha bravo china delta echo foxtrot golf hotel india juliet kilo lima mary november oscar paper quebec research sierra tango uniform victor whisky x-ray yankee zulu "
	num: .asciiz "1First 2Second 3Third 4Fourth 5Fifth 6Sixth 7Seventh 8Eighth 9Ninth 0zero "
	enter: .asciiz "\n"
	space: .asciiz " "
	
.text
	
main:

	while:
		li $v0, 12
		syscall
		
		# store the character in $t0
		add $t0, $zero, $v0		
		beq $t0, '?', exit_main
		blt $t0, '0', print_ast
		ble $t0, '9', process_num
		blt $t0, 'A', print_ast
		ble $t0, 'Z', process_ALPHA
		blt $t0, 'a', print_ast
		ble $t0, 'z', process_alpha
		j print_ast
	
# Exit program
exit_main:
	li $v0, 10
	syscall

# print if input is a number
process_num:
	li $v0, 4
	la $a0, space
	syscall
	add $s0, $zero, $zero
	
	while_num:
		lb $s1, num($s0)
		beq $s1, $zero, exit_main
		beq $t0, $s1, print_num
		addi $s0, $s0, 1
		j while_num
		
	print_num:
		addi $s0, $s0, 1
		lb $a0, num($s0)
		beq $a0, ' ', exit_num
		li $v0, 11
		syscall
		j print_num
		
	exit_num:
		li $v0, 4
		la $a0, enter
		syscall
		j while

# print if input is an upper case letter
process_ALPHA:
	li $v0, 4
	la $a0, space
	syscall
	add $s0, $zero, $zero
	
	while_ALPHA:
		lb $s1, STR($s0)
		beq $s1, $zero, exit_main
		beq $s1, ' ', check_ALPHA
		addi $s0, $s0, 1
		j while_ALPHA
		
	check_ALPHA:
		addi $s0, $s0, 1
		lb $a0, STR($s0)
		beq $a0, $t0, print_ALPHA
		j while_ALPHA
		
	print_ALPHA:
		lb $a0, STR($s0)
		beq $a0, ' ', exit_ALPHA
		li $v0, 11
		syscall
		addi $s0, $s0, 1
		j print_ALPHA
		
	exit_ALPHA:
		li $v0, 4
		la $a0, enter
		syscall
		j while
		
# print if input is a lower case letter
process_alpha:
	li $v0, 4
	la $a0, space
	syscall
	add $s0, $zero, $zero
	
	while_alpha:
		lb $s1, str($s0)
		beq $s1, $zero, exit_main
		beq $s1, ' ', check_alpha
		addi $s0, $s0, 1

		j while_alpha
		
	check_alpha:
		addi $s0, $s0, 1
		lb $a0, str($s0)
		beq $a0, $t0, print_alpha
		j while_alpha
		
	print_alpha:
		lb $a0, str($s0)
		beq $a0, ' ', exit_alpha
		li $v0, 11
		syscall
		addi $s0, $s0, 1
		j print_alpha
		
	exit_alpha:
		li $v0, 4
		la $a0, enter
		syscall
		j while

# print for other cases
print_ast:
	li $v0, 4
	la $a0, space
	syscall
	
	li $v0, 11
	li $a0, '*'
	syscall
	
	li $v0, 4
	la $a0, enter
	syscall
	
	j while
	

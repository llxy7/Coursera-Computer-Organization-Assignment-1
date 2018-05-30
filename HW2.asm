# Assignment 1, problem 2 of the Coursera open course "Computer Organization"
# Author: Sida Lu
# Date: May 26, 2018
#
# based on the "MIPS Assembly Programming Simplified" series video by Quasar Distant on YouTube

.data

	str: .space 2048
	success: .asciiz "Success! Location: "
	fail: .asciiz "Fail!"
	enter: .asciiz "\n"

.text

main:
	
	li $v0, 8
	la $a0, str
	addi, $a1, $zero, 2047
	syscall
	
	while:
		li $v0, 12
		syscall
		
		add, $t0, $v0, $zero
		beq $t0, '?', exit_main
		
		li $v0, 4
		la $a0, enter
		syscall
		
		add $s0, $zero, $zero
		while_check:
			lb $a0, str($s0)
			beq $a0, $zero, print_fail
			beq $a0, $t0, print_success
			addi $s0, $s0, 1
			j while_check
		
		j while
		
# Exit program
exit_main:
	li $v0, 10
	syscall

# print information if the letter is not in the string
print_fail:
	la $a0, fail
	li $v0, 4
	syscall
	
	la $a0, enter
	li $v0, 4
	syscall
	
	j while
	
# print information if the letter is in the string
print_success:
	addi $s0, $s0, 1
	
	la $a0, success
	li $v0, 4
	syscall
	
	add $a0, $s0, $zero
	li $v0, 1
	syscall
	
	la $a0, enter
	li $v0, 4
	syscall
	
	j while
	
.data
a:	.word 	0
b:	.word	0
c:	.word	0
int1:	.word	0
int2:	.word	0
int3:	.word	0
name:	.asciiz	""
p0:	.asciiz "Please enter your name: "
p1:	.asciiz	"Please enter a digit between 1 and 100: "
p2:	.asciiz "Your results are: "
space:	.asciiz " "

	.text
main:	
	#Name prompt
	la	$a0, p0
	li	$v0, 4
	syscall
	
	#Read in string, save to name
	la	$a0, name
	li	$a1, 16
	li	$v0, 8
	syscall
	
	#Prompt for integer
	li	$v0, 4
	la	$a0, p1
	syscall
	
	#Read integer into int1
	la	$a0, a
	li	$v0, 5
	syscall
	add	$t0,$zero,$v0	#move answer in a register
	sw	$t0, int1	#store register into variable
	
	#Prompt for integer
	li	$v0, 4
	la	$a0, p1
	syscall
	
	#Read integer into int2
	la	$a0, b
	li	$v0, 5
	syscall
	add	$t1, $zero, $v0
	sw	$t1, int2
	
	#Prompt for integer
	li	$v0, 4
	la	$a0, p1
	syscall
	
	#Read integer into int3
	la	$a0, c
	li	$v0, 5
	syscall
	add	$t2, $zero, $v0
	sw	$t2, int3
	
	#Read Integer
	lw	$a0, b
	li	$v0, 1
	syscall
	
	#Read name
	la	$a0, name
	li	$v0, 4
	syscall
	
	#Output results
	la	$a0, p2
	li	$v0, 4
	syscall
	
	lw	$a0, int1
	li	$v0, 1
	syscall
	
	la	$a0, space
	li	$v0, 4
	syscall
	lw	$a0, int2
	li	$v0, 1
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
	lw	$a0, int3
	li	$v0, 1
	syscall
	
exit:
	li	$v0, 10
	syscall

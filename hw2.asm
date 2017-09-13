	.data
a:	.word 	0
b:	.word	0
c:	.word	0
ans1:	.word	0
ans2:	.word	0
ans3:	.word	0
name:	.asciiz	"\0"
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
	
	#Read integer into a
	la	$a0, a
	li	$v0, 5
	syscall
	add	$t0,$zero,$v0	#move answer in a register
	sw	$t0, a		#store register into variable
	
	#Prompt for integer
	li	$v0, 4
	la	$a0, p1
	syscall
	
	#Read integer into b
	la	$a0, b
	li	$v0, 5
	syscall
	add	$t1, $zero, $v0
	sw	$t1, b
	
	#Prompt for integer
	li	$v0, 4
	la	$a0, p1
	syscall
	
	#Read integer into c
	la	$a0, c
	li	$v0, 5
	syscall
	add	$t2, $zero, $v0
	sw	$t2, c
	
	#Math section
	#ans1 = (a + 2) + (b - 5) 
	lw	$t1, a
	add	$t1, $t1, 2	# a + 2
	lw	$t2, b
	addi	$t2, $t2, -5	# b - 5
	add	$t3, $t1, $t2	
	sw	$t3, ans1
	
	#ans2 = 5 * a - b + 10
	lw	$t1, a
	mul	$t1, $t1, 5	# 5 * a
	mflo	$t1		# Move multiplication answer to register
	lw	$t2, b
	sub	$t3, $t1, $t2	# (5*a) - b
	addi	$t3, $t3, 10	# +10
	sw	$t3, ans2
	
	#ans3 = a + b/2
	lw	$t1, a
	lw	$t2, b
	li	$t3, 2
	div	$t2, $t3	# b/2
	mflo	$s1		# move quotient to a saved value
	add	$s2, $t1, $s1	# a + (b/2)
	sw	$s2, ans3
	
	
	#Output name
	la	$a0, name
	li	$v0, 4
	syscall
	
	#Output results
	la	$a0, p2
	li	$v0, 4
	syscall
	
	lw	$a0, ans1
	li	$v0, 1
	syscall
	
	la	$a0, space
	li	$v0, 4
	syscall
	lw	$a0, ans2
	li	$v0, 1
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
	lw	$a0, ans3
	li	$v0, 1
	syscall
	
	#Terminate the program
exit:
	li	$v0, 10
	syscall

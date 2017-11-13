	.data
p1:	.asciiz "\nPlease choose from the following: "
p2:	.asciiz "Menu Options:\n"
c1:	.asciiz "1) Combinations\n"
comb1:	.asciiz "Please enter a n value: "
comb2:	.asciiz "Please enter a k value: "
comb3:	.asciiz "\nThe combination answer is: "
n:	.word 0
k:	.word 0
choice:	.word 0
combans:.word 0

	.text
	
	la	$a0, p2
	li	$v0, 4
	syscall
	
	la	$a0, c1
	li	$v0, 4
	syscall
	
	la	$a0, p1
	li	$v0, 4
	syscall
	
	li	$v0, 5
	syscall
	
	add	$t3, $t3, $v0
	beq	$t3, 1, combinations
	
combinations:
	# n!/(k!(n-k)!)
	# Need n!, k!, and (n-k)!
	# $s1 = n! 
	# #s2 = k!
	# $s3 = (n-k)!
	# $s4 = k! * (n-k)!
	lw	$t1, n
	lw	$t2, k
	
	la	$a0, comb1
	li	$v0, 4
	syscall
	
	li	$v0, 5
	syscall
	
	add	$t1, $zero, $v0
	
	la	$a0, comb2
	li	$v0, 4
	syscall
	
	li	$v0, 5
	syscall
	add	$t2, $t2, $v0
	
	# Compute n-k
	sub	$s3, $t1, $t2
	
	# Run factorial for n
	jal	factorial
	add	$s1, $s0, $zero
	
	# Run factorial for k
	add	$t1, $t2, $zero
	jal	factorial
	add	$s2, $s0, $zero
	
	# Run factorial for (n-k)!
	add	$t1, $s3, $zero
	jal	factorial
	add	$s3, $s0, $zero
	
	# Compute n! * (n-k)!
	mult	$s2, $s3
	mflo	$s4
	
	# Compute n! / (n! * (n-k)!)
	div	$s1, $s4
	mflo	$s0
	
	#Let's save our answer
	sw	$s0, combans
	
	#Display answer
	la	$a0, comb3
	li	$v0, 4
	syscall
	
	lw	$a0, combans
	li	$v0, 1
	syscall
	
	j	end
	
factorial:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	li	$s0, 1
	
	# t1 = n
	# t3 = 1, loop ends
	# t4 = n - 1
	# t5 = mult holder
	# s0 = result holder
fstart:
	beq	$t1, $t3, fend	# is n == 1?
	mult	$s0, $t1
	mflo	$s0
	subi	$t1, $t1, 1
	j	fstart
	
	
fend:
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra
	
end:	
	li	$v0, 10
	syscall

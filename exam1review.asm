	.data
	.align 4
a:	.word 5,6,7,8,9,10,11,12,13,14
b:	.word 4
c:	.word 0

	.text
	
main:	
	li	$t0, 0		#i = 0
	li	$t1, 10		#max loop
	la	$t2, a		#array
	
	
loop:	
	beq	$t0, $t1, exit
	lw	$t3, ($t2)
	addi	$t3, $t3, 5
	sw	$t3, ($t2)
	addi	$t2, $t2, 4
	addi	$t0, $t0, 1
	j	loop
	

exit:	li	$v0, 10
	syscall
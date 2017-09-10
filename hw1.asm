	.data
digit1:	.word 3
digit2:	.word 4
digit3:	.word 8
digit4:	.word 5
sum:	.word 0	#initialize to 0

	.text
	lw $t1, sum	#load our initial sum
	lw $t2, digit1	#load the first 2 digits
	lw $t3, digit2
	add $t1, $t2, $t3	#add first 2 digits, hold it in sum
	lw $t2, digit3		#add last 2 digits
	lw $t3, digit4
	add $t4, $t2, $t3	#store sum into another register
	add $t1, $t1, $t4	#add first sum and second sum, store in sum
	sw $t1, sum
	
	#Exit gracefully
	li $v0,10
	syscall
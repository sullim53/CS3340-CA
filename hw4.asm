	.data 
	.align 4
height:	.word 0
weight:	.word 0
bmi:	.double 0
comp1:	.double	18.5
comp2:	.double	25.0
comp3:	.double	30.0
name:	.asciiz ""
p1:	.asciiz "What is your name? "
p2:	.asciiz "Please enter your height in inches: "
p3:	.asciiz "Now enter your weight in pounds (round to a whole number): "
p4:	.asciiz ", your bmi is: "
p5:	.asciiz "\nThis is considered underweight. "
p6:	.asciiz "\nThis is normal weight."
p7:	.asciiz "\nThis is considered overweight"
p8:	.asciiz "\nThis is considered obese"

	.text
main:	
	##################
	#Ask for name

	la	$a0, p1
	li	$v0, 4
	syscall
	
	#store name into original address
	li	$a1, 12
	la	$a0, name
	li	$v0, 8
	syscall
	
	#################
	#Get height
	la	$a0, p2
	li	$v0, 4
	syscall
	
	#Prompt for height
	li	$v0, 5
	syscall
	sw	$v0, height
	
	################
	#Get weight
	la	$a0, p3
	li	$v0, 4
	syscall
	
	#Prompt for weight
	li	$v0, 5
	syscall
	sw	$v0, weight
	
	################
	# Calculate new weight for BMI calculation
	# weight = weight * 703;
	lw	$t0, weight
	li	$t1, 703
	mult	$t0, $t1
	mflo	$t2
	sw	$t2, weight
	
	#Calculate new height, height = height * height;
	lw	$t0, height
	mult	$t0, $t0
	mflo	$t1
	sw	$t1, height
	
	#Load weight and height into coprocessor
	lw	$t2, weight
	mtc1.d	$t2, $f0
	cvt.d.w	$f0, $f0	#cast word into double
	lw	$t3, height
	mtc1.d	$t3, $f14	#cast word into double
	cvt.d.w	$f14, $f14
	div.d	$f12, $f0, $f14
	#Print BMI
	la	$a0, name
	li	$v0, 4
	syscall
	la	$a0, p4
	li	$v0, 4
	syscall
	li	$v0, 3
	syscall
	
	#Is my BMI less than 18.5?
	l.d	$f4, comp1
	c.lt.d	$f12, $f4
	bc1t	under
	
	#Is BMI less than 25?
	l.d	$f4, comp2
	c.lt.d	$f12, $f4
	bc1t	normal
	
	#Is BMI less than 30?
	l.d	$f4, comp3
	c.lt.d	$f12, $f4
	bc1t	over
	
	#BMI is over 30
	la	$a0, p8
	li	$v0, 4
	syscall
	j	end
	
end:
	li	$v0, 10
	syscall
	
under:
	la	$a0, p5
	li	$v0, 4
	syscall
	j	end
	
normal:	
	la	$a0, p6
	li	$v0, 4
	syscall
	j	end

over:
	la	$a0, p7
	li	$v0, 4
	syscall
	j	end
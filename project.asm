                .data
prompt_eq:	.asciiz "Select an equation by entering the number below:\n"
#p2:       .asciiz "Menu Options:\n"
choice_1:	.asciiz    "1) Combinations without replacement\n"
choice_2:	.asciiz "2) Combinations with replacement\n"
choice_3:	.asciiz "3) Permutations without replacement\n"
choice_4:	.asciiz "4) Combinations with replacement\n"
choice_error:	.asciiz "You did not enter any of the given choices! Try again.\n\n"
choice_exit:	.asciiz "0) Exit\n"
choice_prompt:	.asciiz "\nEnter your choice: "

prompt_n:	.asciiz "Please enter a n value: "
propmt_k:	.asciiz "Please enter a k value: "
comb3:		.asciiz "\nThe combination answer is: "

input_n:	.word    0
input_k:	.word    0
choice:		.word    0
combans:	.word    0

                .text
	
menu:	la	$a0, prompt_eq
	li	$v0, 4
	syscall
	
	la	$a0, choice_1
	li	$v0, 4
	syscall
	
	la	$a0, choice_2
	li	$v0, 4
	syscall
	
	la	$a0, choice_3
	li	$v0, 4
	syscall
	
	la	$a0, choice_4
	li	$v0, 4
	syscall
	
	la	$a0, choice_exit
	li	$v0, 4
	syscall
	
	#Prompt for input
	la	$a0, choice_prompt
	li	$v0, 4
	syscall
	
	li	$v0, 5
	syscall
	
	add	$t3, $zero, $v0
	beq	$t3, 1, combination_wo_replacement_loop_numerator
	beq	$t3, 2, combination_w_replacement_loop
	beq	$t3, 3, permutation_wo_replacement_loop
	beq	$t3, 4, permutation_w_replacement_loop
	beq	$t3, 0, exit
	
	#If the user didn't choose anything listed.
	la	$a0, choice_error
	li	$v0, 4
	syscall
	
	j	menu
                
                #####if n = k output 1
                
                # load the values of n &k, we only have to do this once no matter what the equation is. will cut back on lines. 
                lw	$t1, input_n                                
                lw	$t2, input_k

permutation_w_replacement_loop:
                # Calculate the combination
                # Equation: (k + n - 1)!/(k!(n-1)!)
                # (k + n - 1)!/(k!(n-1)!) = {(k+n-1)*(k+n-2)*(k+n-3)*...*n}/k! since n >= k 
                # look for t so that  k - t = n
                # take (k + n - 1) reducing by 1 each time until (k + n - 1 - x) = (n - 1)
                # then divide everything by k!
                
                # let t4 = k + n - 1
                #let $t5 = n - 1
                beq	$t4, $t5, permutation_w_replacement_loop
                multu	$s0, $t4
                mflo	$s0
                subiu	$t4, $t4, 1
                j	permutation_w_replacement_loop

combination_w_replacement_loop: #need to find cap in 32 unsigned for n & k
                # Calculate the permutataion
                # Equation: n^k
                beq	$t2, 0, output_result
                multu	$t1, $t1
                subiu	$t2, $t2, 1
                j	combination_w_replacement_loop

permutation_wo_replacement_loop:     
                # Calculation the permutation loop
                # Equation: n!/(n-k)!
                # n!/(n-k)! = n*(n-1)*(n-2)*...*(k+1) since n >= k 
                
                beq	$t1, $t2, output_result    # if n = k then exit loop
                multu	$s0, $t1
                #multu $s1,        $t1          #since we are checking the t value prior to the calculation we can safely guarentee that the hi register doesnt overflow
                mflo	$s0                         
                #mfhi    $s1                         
                subiu	$t1, $t1, 1
                j	permutation_wo_replacement_loop

combination_wo_replacement_loop_numerator:             
                # Calculation the numerator of the combination loop
                # Equation: n!/(n-k)!
                # n!/(n-k)! = n*(n-1)*(n-2)*...*(k+1) since n >= k 
                
                beq	$t1, $t2, combination_wo_replacement_loop_divide        # if n = k then exit loop
                multu	$s0, $t1
                #multu $s1,        $t1          #since we are checking the t value prior to the calculation we can safely guarentee that the hi register doesnt overflow
                mflo	$s0                         
                #mfhi    $s1                         
                subi	$t1, $t1, 1
                j	combination_wo_replacement_loop_numerator

combination_wo_replacement_loop_divide:       
                # Calculation of the combination loop
                # Equation: n!/(k!(n-k)!)
                # repeat permutation loop to get numerator of equation; Then loop through a k factorial divide.
                
                beq	$t2, 0, output_result    # if n = k then exit loop
                divu	$s0, $t2          #refresh on division - floating points?
                #divu     $s1,        $t2          #since we are checking the t value prior to the calculation we can safely guarentee that the hi register doesnt overflow        
                subi	$t2, $t2, 1
                j	combination_wo_replacement_loop_divide

output_result:
	j	menu
		
exit:
	li	$v0, 10
	syscall

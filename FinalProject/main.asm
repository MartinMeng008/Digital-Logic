# =============================================================
# main PROCEDURE TEMPLATE # 4b
#
# Use with "proc_template4b.asm" as the template for other procedures
#
# Based on "Ex4b" of Lecture 9 (Procedures and Stacks) of COMP411 Spring 2018
#   (main is simpler than other procedures because it does not have to
#     clean up anything before exiting)
#
# Assumptions:
#
#   - main calls other procedures with no more than 4 arguments ($a0-$a3)
#   - any local variables needed are put into registers (not memory)
#   - no values are put in temporaries that must be preserved across a call from main
#       to another procedure
#
# =============================================================

.data 0x10010000                # Start of data memory
#
# declare global variables here
a_sqr:	.space 4
a:	.word 3

song:		.word	1,1,5,5,6,6,5,4,4,3,3,2,2,1,5,5,4,4,3,3,2,5,5,4,4,3,3,2,1,1,5,5,6,6,5,4,4,3,3,2,2,1
period:		.word 	0, 382219, 340530, 303370, 286344, 255102, 227273
score:		.word 	0
loc:		.word 	0, 5, 10, 15, 20, 25, 30
ini_loc:	.word 	0, 5, 10, 15, 20, 25, 30
note:		.word 	0



.text 0x00400000                # Start of instruction memory
.globl main

main:
    lui     $sp, 0x1001         # Initialize stack pointer to the 64th location above start of data
    ori     $sp, $sp, 0x0200    # top of the stack will be the word at address [0x100100fc - 0x100100ff]
                                #   because $sp is decremented first.

    addi    $fp, $sp, -4        # Set $fp to the start of main's stack frame



    # =============================================================
    # No need to create room for temporaries to be protected.
    # =============================================================




    # =============================================================
    # BODY OF main
    # ...
    # ...
    # ...
    # ... CODE FOR main HERE
    sw	$0, 0x0($0)	# store 0 in address 0 (score)
    
    add 	$10, $0, $0	# $10 <- i
    
    addi	$a0, $0, 100		# set $a0 = 100
    jal	pause
    
    Lfor:
    	sll 	$15, $10, 2	# $15 = i * 4
    	lw 	$15, song($15)	# $15 = song[i]
    	sw 	$15, note($0)	# note = song[i] = $15
    	
    	add	$a0, $15, $0	# $a0 = note
    	jal	movedown
    	
    	jal	get_key
    	add	$8, $v0, $0	# $8 <- old_key = get_key()
    	add	$9, $8, $0	# $9 <- tmp_key = old_key
    	
  	# ===========================================================
  	# While loop
  	Lwhile:
  		xor	$11, $15, $9		# $11 = ($15 != $9) = (note != temp_key)
  		beq 	$11, $0, Lendw		# jump out if $11 is 0
  		
  		#===========================================================
  		# If-else
  			
  			#bne	$8, $9, Lelse		# old_key != tmp_key => else statement
  				#=================Stuff1========================
  				addi	$a0, $0, 20		# set $a0 = 25
  				jal	pause
  				
  				#jal	pause_get_key		# pause for 1/4 second and get key
  				#beq	$v0, $15, Lendw		# correct key
  		
  				add	$a0, $15, $0		# $a0 = $15 = note
  				jal	draw
  		
  				
  				jal	get_key
  				add	$9, $v0, $0		# tmp_key = $9 = get_key()
  				
  				j	Lendif
  				#========================================================
  				
  			Lelse:
  			
  				#================Stuff2==================================
  				#sll	$16, $15, 2		# $16 = note*4
  				#lw	$a0, period($16)	# $a0 = period[note]
  				#jal	put_sound
  				
  				#addi	$a0, $0, 125		# set $a0 = 25
  				#jal	pause			# pause for 1/4 second
  				
  				#jal	sound_off
  				
  				#j	game_over
  				
  				#========================================================
  			
  			Lendif:
  			
  		
  		#===========================================================
  		
  		j Lwhile
  	Lendw:
  	sll	$16, $15, 2		# $16 = note*4
  	lw	$a0, period($16)	# $a0 = period[note]
  	jal	put_sound
  	
  	lw	$13, score($0)		# $13 = score
  	addi	$13, $13, 10		# score += 10
  	sw	$13, score($0)		# store to score
  	
  	addi	$a0, $0, 65535		# $a0 = 2'b 1111_1111_1111_1111
  	jal	put_leds		# lights up all led
  	
#key_loop:
#	addi	$25, $15, 6  		# $25 = note + 6
#	jal	get_key
#	bne	$25, $v0, key_loop	# if key != release_key => loop back	
  	
  	add	$a0, $15, $0		# $a0 = note
  	jal	go_back
  	
  	addi	$a0, $0, 50		# set $a0 = 25
  	jal	pause			# pause for 1/4 second
  	
  	add	$a0, $0, $0		# $a0 = 2'b 1111_1111_1111_1111
  	jal	put_leds		# lights down all led
  	jal	sound_off
  	
  	# ===========================================================  	
    	
    	
    	addi	$10, $10, 1	# i++
    	slti	$20, $10, 48	# $20 = (i < 48)
    	bne	$20, $0, Lfor	# $20 true -> loop back
    Lendfor:
        
          
    # END OF BODY OF main
    # =============================================================



exit_from_main:

    ###############################
    # END using infinite loop     #
    ###############################

                        # program may not reach here, but have it for safety
end:
    
    jal		get_accelY 	# result in v0
    slti	$1, $v0, 30	# $1 = (v0 < 30)
    bne		$1, $0, main	# vo < 30 => jump to main
    j   	end            # infinite loop "trap" because we don't have syscalls to exit


######## END OF MAIN #################################################################################



######################################### DRAW ###################################################
draw:
    addi    $sp, $sp, -4        # Make room on stack for saving $ra and $fp
    sw      $ra, 0($sp)         # Save $ra
    #sw      $fp, 0($sp)         # Save $fp

    #addi    $fp, $sp, 4         # Set $fp to the start of proc1's stack frame

                                # From now on:
                                #     0($fp) --> $ra's saved value
                                #    -4($fp) --> caller's $fp's saved value
                    

    # =============================================================
    # Save any $sx registers that proc1 will modify
                                # Save any of the $sx registers that proc1 modifies
    addi    $sp, $sp, -16       # e.g., $s0, $s1, $s2, $s3
    sw      $s0, 12($sp)        # Save $s0
    sw      $s1, 8($sp)         # Save $s1
    sw      $s2, 4($sp)         # Save $s2
    sw      $s3, 0($sp)         # Save $s3

                                # From now on:
                                #    -8($fp) --> $s0's saved value
                                #   -12($fp) --> $s1's saved value
                                #   -16($fp) --> $s2's saved value
                                #   -20($fp) --> $s3's saved value
    # =============================================================



    # =============================================================
    # No need to create room for temporaries to be protected
    # =============================================================



    # =============================================================
    # BODY OF draw
    sll		$14, $a0, 2	# $14 = $a0 * 4
    lw		$16, loc($14)	# $16 = loc[note]
    add		$17, $a0, $0	# $17 = $a0 = note
    
    add		$a0, $16, $0	# $a0 = $146= loc[note]
    addi	$a1, $0, 40	# $a1 = 40
    jal		divide_and_mod # $v0 = $a0/a1 = loc[note]/40, v1 = a0%a1 = loc[note]%40
    
    add		$a0, $0, $0	# a0 = 0
    add		$a2, $v0, $0	# a1 = v0 = a0/a1 = loc[note]/40
    add		$a1, $v1, $0	# a2= a0%a1 = loc[note]%40
    jal		putChar_atXY
    
    addi	$16, $16, 40	# loc[note] += 40
    sw		$16, loc($14)  # store back to loc[note]
    
    add		$a0, $16, $0	# $a0 = loc[note]
    add		$a1, $17, $0	# $a1 = note
    jal		checkvalid
    
    add		$a0, $16, $0	# $a0 = $146= loc[note]
    addi	$a1, $0, 40	# $a1 = 40
    jal		divide_and_mod # $v0 = $a0/a1 = loc[note]/40, v1 = a0%a1 = loc[note]%40
    
    add		$a0, $17, $0	# a0 = $17 = note
    add		$a2, $v0, $0	# a1 = v0 = a0/a1 = loc[note]/40
    add		$a1, $v1, $0	# a2= a0%a1 = loc[note]%40
    jal		putChar_atXY
    # put return values, if any, in $v0-$v1
    # END OF BODY OF movedown
    # =============================================================



    # =============================================================
    # Restore $sx registers
    lw  $s0,  12($sp)           # Restore $s0
    lw  $s1, 8($sp)           # Restore $s1
    lw  $s2, 4($sp)           # Restore $s2
    lw  $s3, 0($sp)           # Restore $s3
    addi	$sp, $sp, 16
    # =============================================================



    # =============================================================
    # Restore $fp, $ra, and shrink stack back to how we found it,
    #   and return to caller.

return_from_draw:
    #addi    $sp, $fp, 4     # Restore $sp
    lw      $ra, 0($sp)     # Restore $ra
    addi	$sp, $sp, 4
    #lw      $fp, -4($fp)    # Restore $fp
    jr      $ra             # Return from procedure

    # =============================================================

######################################### END OF DRAW ###################################################

######################################### MOVEDOWN ###################################################



movedown:
    addi    $sp, $sp, -4        # Make room on stack for saving $ra and $fp
    sw      $ra, 0($sp)         # Save $ra
    #sw      $fp, 0($sp)         # Save $fp

    #addi    $fp, $sp, 4         # Set $fp to the start of proc1's stack frame

                                # From now on:
                                #     0($fp) --> $ra's saved value
                                #    -4($fp) --> caller's $fp's saved value
                    

    # =============================================================
    # Save any $sx registers that proc1 will modify
                                # Save any of the $sx registers that proc1 modifies
    addi    $sp, $sp, -16       # e.g., $s0, $s1, $s2, $s3
    sw      $s0, 12($sp)        # Save $s0
    sw      $s1, 8($sp)         # Save $s1
    sw      $s2, 4($sp)         # Save $s2
    sw      $s3, 0($sp)         # Save $s3

                                # From now on:
                                #    -8($fp) --> $s0's saved value
                                #   -12($fp) --> $s1's saved value
                                #   -16($fp) --> $s2's saved value
                                #   -20($fp) --> $s3's saved value
    # =============================================================



    # =============================================================
    # No need to create room for temporaries to be protected
    # =============================================================



    # =============================================================
    # BODY OF movedown
    sll		$14, $a0, 2	# $14 = $a0 * 4
    lw		$16, loc($14)	# $16 = loc[note]
    add		$17, $a0, $0	# $17 = $a0 = note
    
    add		$a0, $16, $0	# $a0 = $146= loc[note]
    addi	$a1, $0, 40	# $a1 = 40
    jal		divide_and_mod # $v0 = $a0/a1 = loc[note]/40, v1 = a0%a1 = loc[note]%40
    
    add		$a0, $0, $0	# a0 = 0
    add		$a2, $v0, $0	# a1 = v0 = a0/a1 = loc[note]/40
    add		$a1, $v1, $0	# a2= a0%a1 = loc[note]%40
    jal		putChar_atXY
    
    addi	$16, $16, 40	# loc[note] += 40
    sw		$16, loc($14)  # store back to loc[note]
    
    add		$a0, $16, $0	# $a0 = $146= loc[note]
    addi	$a1, $0, 40	# $a1 = 40
    jal		divide_and_mod # $v0 = $a0/a1 = loc[note]/40, v1 = a0%a1 = loc[note]%40
    
    add		$a0, $17, $0	# a0 = $17 = note
    add		$a2, $v0, $0	# a1 = v0 = a0/a1 = loc[note]/40
    add		$a1, $v1, $0	# a2= a0%a1 = loc[note]%40
    jal		putChar_atXY
    # put return values, if any, in $v0-$v1
    # END OF BODY OF movedown
    # =============================================================



    # =============================================================
    # Restore $sx registers
    lw  $s0,  12($sp)           # Restore $s0
    lw  $s1, 8($sp)           # Restore $s1
    lw  $s2, 4($sp)           # Restore $s2
    lw  $s3, 0($sp)           # Restore $s3
    addi	$sp, $sp, 16
    # =============================================================



    # =============================================================
    # Restore $fp, $ra, and shrink stack back to how we found it,
    #   and return to caller.

return_from_movedown:
    #addi    $sp, $fp, 4     # Restore $sp
    lw      $ra, 0($sp)     # Restore $ra
    addi	$sp, $sp, 4
    #lw      $fp, -4($fp)    # Restore $fp
    jr      $ra             # Return from procedure

    # =============================================================

######################################### END OF MOVEDOWN ###################################################
    
######################################### CHECKVALID #####################################################          
checkvalid:
    addi    $sp, $sp, -4        # Make room on stack for saving $ra and $fp
    sw      $ra, 0($sp)         # Save $ra
    #sw      $fp, 0($sp)         # Save $fp

    #addi    $fp, $sp, 4         # Set $fp to the start of proc1's stack frame

                                # From now on:
                                #     0($fp) --> $ra's saved value
                                #    -4($fp) --> caller's $fp's saved value
                    

    # =============================================================
    # Save any $sx registers that proc1 will modify
                                # Save any of the $sx registers that proc1 modifies
    addi    $sp, $sp, -16       # e.g., $s0, $s1, $s2, $s3
    sw      $s0, 12($sp)        # Save $s0
    sw      $s1, 8($sp)         # Save $s1
    sw      $s2, 4($sp)         # Save $s2
    sw      $s3, 0($sp)         # Save $s3

                                # From now on:
                                #    -8($fp) --> $s0's saved value
                                #   -12($fp) --> $s1's saved value
                                #   -16($fp) --> $s2's saved value
                                #   -20($fp) --> $s3's saved value
    # =============================================================



    # =============================================================
    # No need to create room for temporaries to be protected
    # =============================================================



    # =============================================================
    # BODY OF checkvalid
    slti	$12, $a0, 1200		# $12 = (a0 < 1200) = loc < 1200
    bne		$12, $0, Lendif1   	# $12 == 1 => end of the if stmt
    
    addi	$a1, $0, 40		# a1 = 40 = num_cols
    jal		divide_and_mod 		# v1 = loc % 40
    
    beq		$v1, $0, Lelse1
    
    add		$a0, $a1, $0		# a0 = note
    jal		go_back
    
    j		game_over
    
    Lelse1:
    	add	$a0, $0, $0		# a0 = 0
    	jal	go_back
    
    Lendif1:
    # put return values, if any, in $v0-$v1
    # END OF BODY OF proc1
    # =============================================================



    # =============================================================
    # Restore $sx registers
    lw  $s0,  12($sp)           # Restore $s0
    lw  $s1, 8($sp)           # Restore $s1
    lw  $s2, 4($sp)           # Restore $s2
    lw  $s3, 0($sp)           # Restore $s3
    addi	$sp, $sp, 16
    # =============================================================



    # =============================================================
    # Restore $fp, $ra, and shrink stack back to how we found it,
    #   and return to caller.

return_from_checkvalid:
    #addi    $sp, $fp, 4     # Restore $sp
    lw      $ra, 0($sp)     # Restore $ra
    addi	$sp, $sp, 4
    #lw      $fp, -4($fp)    # Restore $fp
    jr      $ra             # Return from procedure

    # =============================================================
######################################### END OF CHECKVALID #####################################################       




################################# GO_BACK ######################################        
go_back:
    addi    $sp, $sp, -4        # Make room on stack for saving $ra and $fp
    sw      $ra, 0($sp)         # Save $ra
    #sw      $fp, 0($sp)         # Save $fp

    #addi    $fp, $sp, 4         # Set $fp to the start of proc1's stack frame

                                # From now on:
                                #     0($fp) --> $ra's saved value
                                #    -4($fp) --> caller's $fp's saved value
                    

    # =============================================================
    # Save any $sx registers that proc1 will modify
                                # Save any of the $sx registers that proc1 modifies
    addi    $sp, $sp, -16       # e.g., $s0, $s1, $s2, $s3
    sw      $s0, 12($sp)        # Save $s0
    sw      $s1, 8($sp)         # Save $s1
    sw      $s2, 4($sp)         # Save $s2
    sw      $s3, 0($sp)         # Save $s3

                                # From now on:
                                #    -8($fp) --> $s0's saved value
                                #   -12($fp) --> $s1's saved value
                                #   -16($fp) --> $s2's saved value
                                #   -20($fp) --> $s3's saved value
    # =============================================================



    # =============================================================
    # No need to create room for temporaries to be protected
    # =============================================================



    # =============================================================
    # BODY OF go_back
    sll		$14, $a0, 2	# $14 = $a0 * 4 = note*4
    lw		$16, loc($14)	# $16 = loc[note]
    add		$17, $a0, $0	# $17 = $a0 = note
    
    add		$a0, $16, $0	# $a0 = $146= loc[note]
    addi	$a1, $0, 40	# $a1 = 40
    jal		divide_and_mod # $v0 = $a0/a1 = loc[note]/40, v1 = a0%a1 = loc[note]%40
    
    add		$a0, $0, $0	# a0 = 0
    add		$a2, $v0, $0	# a1 = v0 = a0/a1 = loc[note]/40
    add		$a1, $v1, $0	# a2= a0%a1 = loc[note]%40
    jal		putChar_atXY
    
    lw		$12, ini_loc($14)	# $12 = ini_loc[note]
    add		$16, $12, $0		# loc[note] = ini_loc[note]
    sw		$16, loc($14)  		# store back to loc[note]
    
    add		$a0, $16, $0	# $a0 = $146= loc[note]
    addi	$a1, $0, 40	# $a1 = 40
    jal		divide_and_mod # $v0 = $a0/a1 = loc[note]/40, v1 = a0%a1 = loc[note]%40
    
    add		$a0, $17, $0	# a0 = $17 = note
    add		$a2, $v0, $0	# a1 = v0 = a0/a1 = loc[note]/40
    add		$a1, $v1, $0	# a2= a0%a1 = loc[note]%40
    jal		putChar_atXY
    
    
    # put return values, if any, in $v0-$v1
    # END OF BODY OF go_back
    # =============================================================



    # =============================================================
    # Restore $sx registers
    lw  $s0,  12($sp)           # Restore $s0
    lw  $s1, 8($sp)           # Restore $s1
    lw  $s2, 4($sp)           # Restore $s2
    lw  $s3, 0($sp)           # Restore $s3
    addi	$sp, $sp, 16
    # =============================================================



    # =============================================================
    # Restore $fp, $ra, and shrink stack back to how we found it,
    #   and return to caller.

return_from_go_back:
    #addi    $sp, $fp, 4     # Restore $sp
    lw      $ra, 0($sp)     # Restore $ra
    addi	$sp, $sp, 4
    #lw      $fp, -4($fp)    # Restore $fp
    jr      $ra             # Return from procedure

    # =============================================================
################################# END OF GO_BACK ######################################      




################################## GAME_OVER ########################################
game_over:
	jal	display_score
	
	j	end
################################## END OF GAME_OVER ########################################



################################### DIVIDE_AND_MOD #########################################
divide_and_mod:
    addi    $sp, $sp, -4        # Make room on stack for saving $ra and $fp
    sw      $ra, 0($sp)         # Save $ra
    #sw      $fp, 0($sp)         # Save $fp

    #addi    $fp, $sp, 4         # Set $fp to the start of proc1's stack frame

                                # From now on:
                                #     0($fp) --> $ra's saved value
                                #    -4($fp) --> caller's $fp's saved value
                    

    # =============================================================
    # Save any $sx registers that proc1 will modify
                                # Save any of the $sx registers that proc1 modifies
    addi    $sp, $sp, -16       # e.g., $s0, $s1, $s2, $s3
    sw      $s0, 12($sp)        # Save $s0
    sw      $s1, 8($sp)         # Save $s1
    sw      $s2, 4($sp)         # Save $s2
    sw      $s3, 0($sp)         # Save $s3

                                # From now on:
                                #    -8($fp) --> $s0's saved value
                                #   -12($fp) --> $s1's saved value
                                #   -16($fp) --> $s2's saved value
                                #   -20($fp) --> $s3's saved value
    # =============================================================



    # =============================================================
    # No need to create room for temporaries to be protected
    # =============================================================



    # =============================================================
    # BODY OF divide_and_mod
    li	$17, 0	# $17 = divide = 0
    Lwhile1:
    	slt	$18, $a1, $a0	# $18 = (a0 >= a1)
    	beq	$18, $0, Lendw1	# if (a0 < a1) => end of while loop
    	
    	sub	$a0, $a0, $a1	# a0 = a0 - a1
    	addi	$17, $17, 1	# divide = divide + 1
    	
    	j	Lwhile1
 
    Lendw1:
    	add	$v0, $17, $0	# v0 = divide
    	add	$v1, $a0, $0	# v1 = a0
    
    # put return values, if any, in $v0-$v1
    # END OF BODY OF divide_and_mod
    # =============================================================



    # =============================================================
    # Restore $sx registers
    lw  $s0,  12($sp)           # Restore $s0
    lw  $s1, 8($sp)           # Restore $s1
    lw  $s2, 4($sp)           # Restore $s2
    lw  $s3, 0($sp)           # Restore $s3
    addi	$sp, $sp, 16
    # =============================================================



    # =============================================================
    # Restore $fp, $ra, and shrink stack back to how we found it,
    #   and return to caller.

return_from_divide_and_mod:
    #addi    $sp, $fp, 4     # Restore $sp
    lw      $ra, 0($sp)     # Restore $ra
    addi	$sp, $sp, 4
    #lw      $fp, -4($fp)    # Restore $fp
    jr      $ra             # Return from procedure

    # =============================================================


end_of_divide_and_mod:
################################### END OF DIVIDE_AND_MOD #########################################



################################### DISPLAY_SCORE #######################################
display_score:
    addi    $sp, $sp, -4        # Make room on stack for saving $ra and $fp
    sw      $ra, 0($sp)         # Save $ra
    #sw      $fp, 0($sp)         # Save $fp

    #addi    $fp, $sp, 4         # Set $fp to the start of proc1's stack frame

                                # From now on:
                                #     0($fp) --> $ra's saved value
                                #    -4($fp) --> caller's $fp's saved value
                    

    # =============================================================
    # Save any $sx registers that proc1 will modify
                                # Save any of the $sx registers that proc1 modifies
    addi    $sp, $sp, -16       # e.g., $s0, $s1, $s2, $s3
    sw      $s0, 12($sp)        # Save $s0
    sw      $s1, 8($sp)         # Save $s1
    sw      $s2, 4($sp)         # Save $s2
    sw      $s3, 0($sp)         # Save $s3

                                # From now on:
                                #    -8($fp) --> $s0's saved value
                                #   -12($fp) --> $s1's saved value
                                #   -16($fp) --> $s2's saved value
                                #   -20($fp) --> $s3's saved value
    # =============================================================



    # =============================================================
    # No need to create room for temporaries to be protected
    # =============================================================



    # =============================================================
    # BODY OF display_score:
    lw	$24, score($0)	# $24 = score
    sw	$24, 0x0($0)	# store score in address 0
    
    # put return values, if any, in $v0-$v1
    # END OF BODY OF display_score:
    # =============================================================



# =============================================================
    # Restore $sx registers
    lw  $s0,  12($sp)           # Restore $s0
    lw  $s1, 8($sp)           # Restore $s1
    lw  $s2, 4($sp)           # Restore $s2
    lw  $s3, 0($sp)           # Restore $s3
    addi	$sp, $sp, 16
    # =============================================================



    # =============================================================
    # Restore $fp, $ra, and shrink stack back to how we found it,
    #   and return to caller.

return_from_display_score:
    #addi    $sp, $fp, 4     # Restore $sp
    lw      $ra, 0($sp)     # Restore $ra
    addi	$sp, $sp, 4
    #lw      $fp, -4($fp)    # Restore $fp
    jr      $ra             # Return from procedure

    # =============================================================


end_of_display_score:
################################### END OF DISPLAY_SCORE ## #########################################

.include "procs_board.asm"          # include file with helpful procedures


##
##
## Author: Hausner, David
## Last Modified: 02/15/15
##
## Short: Bit reverser (in MIPS Assembly)
## Description: This programs takes in an 8 bit binary
## integer and reverses the order of the bits.
##
## Register use:
##  $a0-a1  parameter for storing user input and calculations
##  $v0   stores user input
##  $t0-t3  temporary calculations
##  $s0   the variable n (user input)
##
#####################################################################
#####################################################################

reverse: 
      addi	$t0, $zero, 0		#sets t0 equal to 0
      addi	$t1, $zero, 7		#sets t1 equal to 7, a counter variable
      addi	$t2, $a0, 0		#sets t2 equal to the user's input

      cycle:  
      andi 	$t3, $t2, 0x1		#sets $t3 equal to the rightmost digit of the user's input
      add	$t0, $t0, $t3		#adds t3 to t0 and stores it in t0
      blez	$t1, done		 #if t1 < 0, go to "done"	
      sll	$t0, $t0, 1		#shifts t0's value to the left by 1 bit
      srl	$t2, $t2, 1		#shifts t2's value to the right by 1 bit
      addi 	$t1, $t1, -1		#decrements counter variable

      jal	cycle			#jump back up to the beginning of "cycle"
      
      done:
      andi	$t0, $t0, 0xff
      add	$a1, $t0, $zero		#stores the value of t0 in a1
      jal	back

main:
      la	$a0, welc		#print welcome message
      li	$v0, 4
      syscall

repeat:
      la	$a0, nreq	        #request value of n
      li	$v0, 4
      syscall

      li	$v0, 5		        #read value of n
      syscall
      move	$s0, $v0	        #save value of n in $s0

      move	$a0, $s0	    	#move value of n into $a0

      jal	reverse		# invoke reverse procedure
      back:
      move	$s0, $a1    	# save value returned by reverse

      la	$a0, ans       	# display answer (text)
      li	$v0, 4
      syscall

      move	$a0, $s0	      # move result into $a0
      li	$v0, 1		      # display answer (integer)
      syscall
	
      jal	repeat

      li	$v0, 10	      	# exit from the program
      syscall

      .data
welc: .asciiz	"Welcome to the amazing bit swapper!"
nreq: .asciiz	"\n\nEnter a number in the range 0-255:  "
ans:  .asciiz	"Flippy-Do:   "

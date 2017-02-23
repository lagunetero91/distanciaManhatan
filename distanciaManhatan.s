
	        .data
redData:	.word   0:4
greenData:      .word   0:4
prmpt1:	 .asciiz "Enter x-coordinate for red particle (0 to 10):"
prmpt2:	 .asciiz "Enter y-coordinate for red particle (0 to 10):"
prmpt3:	 .asciiz "Enter x-coordinate for green particle (0 to 10):"
prmpt4:	 .asciiz "Enter y-coordinate for green particle (0 to 10):"
prmpt5:	 .asciiz "cycle "
prmpt6:	 .asciiz "red particle (x,y,xVel,yVel): "
prmpt7:	 .asciiz "green particle (x,y,xVel,yVel): "
prmpt8:	 .asciiz "Collison: oops, end of simulation!\n"
space:   .asciiz " "
endl:	 .asciiz "\n"

# i     $s0
# cycle $s1 = 0
# dist  $s2

	.text

main:	li      $s1,0

	la      $s3,redData     #  redData[2] = 1 ;
	li      $s4,1
	sw      $s4,8($s3)
	sw      $s4,12($s3)     #  redData[3] = 1 ;
	la      $s3,greenData   #  greenData[2] = -1 ;
	li      $s4,-1
	sw      $s4,8($s3)
	sw      $s4,12($s3)     #  greenData[3] = -1 ;

	la      $a0,prmpt1      #  cout << prmpt1 ;
	li      $v0,4
	syscall
	la      $s3,redData
	li      $v0,5           #  cin >> redData[0] ;
	syscall
	sw      $v0,($s3)
	la      $a0,prmpt2      #  cout << prmpt2 ;
	li      $v0,4
	syscall
	li      $v0,5           #  cin >> redData[1] ;
	syscall
	sw      $v0,4($s3)
	la      $a0,prmpt3      #  cout << prmpt3 ;
	li      $v0,4
	syscall
	la      $s3,greenData   #  cin >> greenData[0] ;
	li      $v0,5
	syscall
	sw      $v0,($s3)
	la      $a0,prmpt4      #  cout << prmpt4 ;
	li      $v0,4
	syscall
	li      $v0,5           #  cin >> greenData[1] ;
	syscall
	sw      $v0,4($s3)

loop:	                        #  do {
	la      $a0,prmpt5      #    cout << "cycle " << cycle << endl ;
	li      $v0,4
	syscall
	move    $a0,$s1
	li      $v0,1
	syscall
	la      $a0,endl
	li      $v0,4
	syscall
	la      $a0,prmpt6      #    cout << "red particle (x,y,xVel,yVel): "
	li      $v0,4
	syscall
	la      $s3, redData
	lw      $a0,($s3)       #       << redData[0]
	li      $v0,1
	syscall
	la      $a0,space       #       << " "
	li      $v0,4
	syscall
	lw      $a0,4($s3)      #       << redData[1]
	li      $v0,1
	syscall
	la      $a0,space       #       << " "
	li      $v0,4
	syscall
	lw      $a0,8($s3)      #       << redData[2]
	li      $v0,1
	syscall
	la      $a0,space       #       << " "
	li      $v0,4
	syscall
	lw      $a0,12($s3)     #       << redData[3]
	li      $v0,1
	syscall
	la      $a0,endl        #       << endl ;
	li      $v0,4
	syscall
	la      $a0,prmpt7      #    cout << "green particle (x,y,xVel,yVel): "
	li      $v0,4
	syscall
	la      $s3, greenData
	lw      $a0,($s3)       #       << greenData[0]
	li      $v0,1
	syscall
	la      $a0,space       #       << " "
	li      $v0,4
	syscall
	lw      $a0,4($s3)      #       << greenData[1]
	li      $v0,1
	syscall
	la      $a0,space       #       << " "
	li      $v0,4
	syscall
	lw      $a0,8($s3)      #       << greenData[2]
	li      $v0,1
	syscall
	la      $a0,space       #       << " "
	li      $v0,4
	syscall
	lw      $a0,12($s3)     #       << greenData[3]
	li      $v0,1
	syscall
	la      $a0,endl        #       << endl ;
	li      $v0,4
	syscall
	la      $a0,endl        #       << endl ;
	li      $v0,4
	syscall

	la      $a0,redData     #    updatePoint(redData) ;
	jal     updatePoint
	la      $a0,greenData   #    updatePoint(greenData) ;
	jal     updatePoint
	
	la      $s3,redData     #    dist = findDistance(redData[0],
	lw      $a0,($s3)       #       redData[1], greenData[0],
	lw      $a1,4($s3)      #       greenData[1]) ;
	la      $s4,greenData
	lw      $a2,($s4)
	lw      $a3,4($s4)
	jal     findDistance
	move    $s2,$v0
	add     $s1,$s1,1       #    cycle++ ;
	ble     $s2,2,exit      #  } while ((dist > 2) && (cycle < 10)) ;
	blt     $s1,10,loop
exit:
	bgt     $s2,2,end       #  if (dist <= 2) {
	la      $a0,prmpt8      #    cout << prmpt8 ;
	li      $v0,4
	syscall
	la      $a0,prmpt6      #    cout << "red particle (x,y,xVel,yVel): "
	li      $v0,4
	syscall
	la      $s3, redData
	lw      $a0,($s3)       #       << redData[0]
	li      $v0,1
	syscall
	la      $a0,space       #       << " "
	li      $v0,4
	syscall
	lw      $a0,4($s3)      #       << redData[1]
	li      $v0,1
	syscall
	la      $a0,space       #       << " "
	li      $v0,4
	syscall
	lw      $a0,8($s3)      #       << redData[2]
	li      $v0,1
	syscall
	la      $a0,space       #       << " "
	li      $v0,4
	syscall
	lw      $a0,12($s3)     #       << redData[3]
	li      $v0,1
	syscall
	la      $a0,endl        #       << endl ;
	li      $v0,4
	syscall
	la      $a0,prmpt7      #    cout << "green particle (x,y,xVel,yVel): "
	li      $v0,4
	syscall
	la      $s3, greenData
	lw      $a0,($s3)       #       << greenData[0]
	li      $v0,1
	syscall
	la      $a0,space       #       << " "
	li      $v0,4
	syscall
	lw      $a0,4($s3)      #       << greenData[1]
	li      $v0,1
	syscall
	la      $a0,space       #       << " "
	li      $v0,4
	syscall
	lw      $a0,8($s3)      #       << greenData[2]
	li      $v0,1
	syscall
	la      $a0,space       #       << " "
	li      $v0,4
	syscall
	lw      $a0,12($s3)     #       << greenData[3]
	li      $v0,1
	syscall
	la      $a0,endl        #       << endl ;
	li      $v0,4
	syscall
	la      $a0,endl        #       << endl ;
	li      $v0,4
	syscall
end:	li      $v0,10          #  }
	syscall                 #}
	
	
updatePoint:
			subu $sp,$sp,4 	#store $ra
			sw $ra,0($sp)
			li $t0,0 		#Distance
			add $t1,$a0,$0	#Copy $a0 (addres from data point)
			li $s7,1		#Auxiliar variable to 1
			li $s6,2		#auxiliar variable to 2
			lw $t2,0($t1)	#Arg0
			lw $t3,4($t1)	#arg1
			lw $t4,8($t1)	#arg2
			lw $t5,12($t1)	#arg3
			
			#now start findDistance calls
			
			#case (arg[0],arg[1],0,-1)
			add $a0,$t2,$0	
			add $a1,$t3,$0
			li $a2,0
			li $a3,-1
			jal findDistance
			add $t0,$v0,$0			
			bge $t0,$s7, continue	#if distance >= 1 condition fail
			bgez $t4, continue		#if arg[2] >= 0 condition fail
			neg $t4,$t4				#arg[2] = -arg[2]
			sw $t4,8($t1)			#store in memory
			
			#case (arg[0],arg[1],10,-1)
continue:	li $a2,10
			li $a3,-1
			jal findDistance
			add $t0,$v0,$0
			bge $t0,$s7, continue2	#if distance >= 1 condition fail
			blez $t4,continue2		#if arg[2] <= 0 condition fail
			neg $t4,$t4				#arg[2] = -arg[2]
			sw $t4,8($t1)			#store in memory
			
			#case (arg[0],arg[1],-1,0)
continue2:	li $a2,-1
			li $a3,0
			jal findDistance
			add $t0,$v0,$0
			bge $t0,$s7, continue3 	#if distance >= 1 condition fail
			bgez $t5,continue3		#if arg[3] >=0 condition fail
			neg $t5,$t5				#arg[3] = -arg[3]
			sw $t5,12($t1)			#store in memory
			
			#case (arg[0],arg[1],-1,10)
continue3:	li $a2,-1
			li $a3,10
			jal findDistance
			add $t0,$v0,$0
			bge $t0,$s7, continue4	#if distance >= 1 condition fail
			blez $t5,continue4		#if arg[3] <=0 condition fail
			neg $t5,$t5				#arg[3] = -arg[3]
			sw $t5,12($t1)			#store in memory
			
continue4:	add $t2,$t2,$t4			#arg[0] = arg[0] + arg[2]
			sw $t2,0($t1)
			add $t3,$t3,$t5			#arg[1] = arg[1] + arg[3]
			sw $t3,4($t1)
			
			lw $ra,0($sp)
			addu $sp,$sp,4
			jr $ra
	

	
#Find Manhattan distance	
	
findDistance:
			li $t6,0			#distX
			li $t7,0			#distY
			li $v0,0
			sub $t6,$a0,$a2		#distX = arg0-arg2
			bgez $t6, no1		#if distX >= 0 jump
			neg $t6,$t6			#else distX = -distX
			
no1:		sub $t7,$a1,$a3		#distY = arg1 - arg3
			bgez $t7,no2		#if distY >= 0 jump
			neg $t7,$t7			#else distY = -distY
			
no2:		blt $a0,$0,firstIf	#if arg0 < 0 firstCondition TRUE
			blt $a2,$0,firstIf	#if arg2 < 0 secondCondition TRUE
			
			blt $a1,$0,secondIf	#if arg1 < 0 firstCondition TRUE
			blt $a3,$0,secondIf	#if arg3 < 0 secondCondition TRUE
			
			j else				#else
			
firstIf:	add $v0,$t7,$0		#return distY
			jr $ra
secondIf:	add $v0,$t6,$0		#return distX
			jr $ra
else:		add $v0,$t6,$t7		#return distX+distY
			jr $ra
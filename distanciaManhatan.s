				.data
values:	.asciiz "Enter values: \n"
arg0:	.asciiz "arg[0]= "
arg1:	.asciiz "arg[1]= "
arg2:	.asciiz "arg[2]= "
arg3:	.asciiz "arg[3]= "

arg:			.space 16	#Arguments memory position
	
	
	
				.text
				
main:			li $s7,2		#Auxiliar variable to 1
				li $t5,0		#Auxiliar variable to charge from memory
				
				# Ask for console data and store it in memory 
				la $a0,values
				li $v0,4
				syscall
				la $a0,arg0		#arg0
				li $v0,4
				syscall
				li $v0,5
				syscall
				sw $v0,arg($t5)
				addi $t5,$t5,4
				la $a0,arg1		#arg1
				li $v0,4
				syscall
				li $v0,5
				syscall
				sw $v0,arg($t5)
				addi $t5,$t5,4
				la $a0,arg2		#arg2
				li $v0,4
				syscall
				li $v0,5
				syscall
				sw $v0,arg($t5)
				addi $t5,$t5,4
				la $a0,arg3		#arg3
				li $v0,4
				syscall
				li $v0,5
				syscall
				sw $v0,arg($t5)
				
				#Load arguments
				li $t5,0
				
				lw $s0,arg($t5) 	#arg[0]
				addi $t5,$t5,4
				lw $s1,arg($t5)		#arg[1]
				addi $t5,$t5,4
				lw $s2,arg($t5)		#arg[2]
				addi $t5,$t5,4
				lw $s3,arg($t5)		#arg[3]
				
				li $t6, 0			#This register have Distance value calculate in FindDistance
				li $s4,0			#Arg3 in FindDistance 0
				li $s5,-1			#Arg4 in FindDistance -1
				
				jal findDistance	#Go to findDistance code
				
				add $a0,$t6,$0
				li $v0,1
				syscall
				
				bgtz $t6,no
				bgez $s2,no
				#arg[2] =-arg[2]
				neg $s2,$s2
				
no:				li $t6, 0		#distance
				li $s4,10		#Arg3 in FindDistance 10
				li $s5,-1		#Arg4 in FindDistance -1
				jal findDistance
				
				add $a0,$t6,$0
				li $v0,1
				syscall
				
				bgtz $t6,no1
				blez $s2,no1
				#arg[2] =-arg[2]
				neg $s2,$s2
				
no1:			li $t6, 0		#distance
				li $s4,-1		#Arg3 in FindDistance -1
				li $s5,0		#Arg4 in FindDistance 0
				jal findDistance
				
				add $a0,$t6,$0
				li $v0,1
				syscall
				
				bgtz $t6,no2
				bgez $s3,no2
				#arg[3] =-arg[3]
				neg $s3,$s3
				
no2:			li $t6, 0		#distance
				li $s4,-1		#Arg3 in FindDistance -1
				li $s5,10		#Arg4 in FindDistance 10
				jal findDistance
				
				add $a0,$t6,$0
				li $v0,1
				syscall
				
				bgtz $t6,no3
				blez $s3,no3
				neg $s3,$s3
				
no3:			add $s0,$s0,$s2
				add $s1,$s1,$s3
				li $t5,0
				sw $s0, arg($t5)
				addi $t5,$t5,4
				sw $s2, arg($t5)
				
				li	$v0, 10		# system call code for exit = 10
				syscall			# call operating sys

				
	##########################			
	#####	FindDistance #####	m,.l
	##########################		

# find Manhattan distance between two particles, or between
# a particle and a wall
# (arg0,arg1) are the (x,y) coordinates for first particle/wall
# (arg2,arg3) are the (x,y) coordinates for second particle/wall
	
findDistance: 	li $t0,0		 	#distX
				li $t1,0 			#distY
				sub $t0,$s0,$s4		#distX=arg0-arg2
				bgez $t0,distXbez	#if(distX<0)
				neg $t0,$t0			#distX = -distX
distXbez:		sub $t1,$s1,$s5		#distY = arg1-arg3
				bgez $t1,distYbez	#if(distY<0)
				neg $t1,$t1			#distY = -distY
				
distYbez:		blt $s0,$0,yes
				blt $s4,$0,yes
				
				blt $s1,$0, secondYes
				blt $s5,$0, secondYes
				
				j else
				
yes:			add $t6,$t6,$t1		#return distY
				jr $ra
secondYes:		add $t6,$t6,$t0		#return distX
				jr $ra				
else:			add $t6,$t0,$t1		#return distX + distY
				jr $ra
				
fin: 			
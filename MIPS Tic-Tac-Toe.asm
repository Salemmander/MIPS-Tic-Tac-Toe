

.data

intro: .asciiz "Welcome to Tic Tac Toe.\n"
rule1: .asciiz "For input the player will enter the number of the desired square they wish to play in.\n"
rule2: .asciiz "The squares are numbered 1-9 from top left to bottom right.\n"
rule3: .asciiz "If that square has already been played in you will be prompted to re-enter your move.\n"
rule4: .asciiz "In this version of Tic Tac Toe, 0 represents an empty square, 1 represents an 'X', and 2 represents a 'O'.\n"

size:	.word 3
.eqv	DATA_SIZE 4

board:	.word line1, line2, line3
line1:	.word 0, 0, 0
line2:	.word 0, 0, 0
line3:	.word 0, 0, 0



space: .asciiz " "
newline: .asciiz "\n"

promptUser: .asciiz "Enter desired square to play in:\n"
outOfBound: .asciiz "Number entered is not within the bounds of the board please try again.\n"
notEmpty: .asciiz "The square you entered is full please try again.\n"
ComputerPrompt: .asciiz "The computer is playing.\n"
GameDraw: .asciiz "This game ended in a draw.\n"
PlayerWon: .asciiz "YOU WON!\n"
ComputerWon: .asciiz "you lost :(\n"

.text

main:
	jal printInstructions
	jal printBoard
	li $t7, 1 #counts turns to determine if a game is a draw
	Play_Game:
		UserPlays:
			jal userPlay
			jal VerifyUser
			bnez $t6, OutOfBound
			jal updateBoardPlayer
			jal printBoard
			jal CheckWin
		addi $t7, $t7, 1
		bge $t7, 10, Draw
			
		la $a0, ComputerPrompt
		li $v0, 4
		syscall
			
		ComputerPlays:
			jal computerPlay
			jal updateBoardComputer
			jal printBoard
			jal CheckWin
		addi $t7, $t7, 1
		bge $t7, 10, Draw
		j Play_Game
	j exit

printInstructions:
	la $a0, intro
 	li $v0, 4
	syscall

	la $a0, rule1
	li $v0, 4
	syscall

	la $a0, rule2
	li $v0, 4
	syscall

	la $a0, rule3
	li $v0, 4
	syscall

	la $a0, rule4
	li $v0, 4
	syscall
	
	jr $ra
	
printBoard:
	addi $t1, $zero, 0
	la $t2, board		

	
	lw $t1, 0($t2)
	lw $t3, 0($t1)

	move $a0, $t3
	li $v0, 1
	syscall


	la $a0, space
	li $v0, 4
	syscall


	lw $t3, 4($t1)
	move $a0, $t3
	li $v0, 1
	syscall


	la $a0, space
	li $v0, 4
	syscall


	lw $t3, 8($t1)
	move $a0, $t3
	li $v0, 1
	syscall



	la $a0, newline
	li $v0, 4
	syscall


	lw $t1, 4($t2)
	lw $t3, 0($t1)

	move $a0, $t3
	li $v0, 1
	syscall


	la $a0, space
	li $v0, 4
	syscall

	
	lw $t1, 4($t2)
	lw $t3, 4($t1)

	move $a0, $t3
	li $v0, 1
	syscall

	
	la $a0, space
	li $v0, 4
	syscall

	
	lw $t1, 4($t2)
	lw $t3, 8($t1)

	move $a0, $t3
	li $v0, 1
	syscall

	
	la $a0, newline
	li $v0, 4
	syscall

	
	lw $t1, 8($t2)
	lw $t3, 0($t1)

	move $a0, $t3
	li $v0, 1
	syscall


	la $a0, space
	li $v0, 4
	syscall

	
	lw $t3, 4($t1)
	move $a0, $t3
	li $v0, 1
	syscall

	
	la $a0, space
	li $v0, 4
	syscall


	lw $t3, 8($t1)
	move $a0, $t3
	li $v0, 1
	syscall

	
	la $a0, newline
	li $v0, 4
	syscall
	

	la $a0, newline
	li $v0, 4
	syscall
	
	jr $ra
	
userPlay:

	
	la $a0, promptUser
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $a1, $v0
	
	jr $ra
			
VerifyUser:
	li $t5, 10 #used to check if valid square
	sge $t6, $a1, $t5
	jr $ra

OutOfBound:
	la $a0, outOfBound
	li $v0, 4
	syscall
	j UserPlays

updateBoardPlayer:
	li $t4, 1 #what will be entered on the board for the user
	li $t0, 1 #used to check value of input
	la $t1, board
	
	beq $a1, $t0, Square1
	addi $t0,$t0, 1
	beq $a1, $t0, Square2
	addi $t0,$t0, 1
	beq $a1, $t0, Square3
	addi $t0,$t0, 1
	beq $a1, $t0, Square4
	addi $t0,$t0, 1
	beq $a1, $t0, Square5
	addi $t0,$t0, 1
	beq $a1, $t0, Square6
	addi $t0,$t0, 1
	beq $a1, $t0, Square7
	addi $t0,$t0, 1
	beq $a1, $t0, Square8
	addi $t0,$t0, 1
	beq $a1, $t0, Square9
	
	Square1:
		lw $t2, 0($t1)
		lw $t5, 0($t2)
		bnez $t5, squarePlayerFull
		sw $t4, 0($t2)
		jr $ra
	Square2:
		lw $t2, 0($t1)
		lw $t5, 4($t2)
		bnez $t5, squarePlayerFull
		sw $t4, 4($t2)
		jr $ra
	Square3:
		lw $t2, 0($t1)
		lw $t5, 8($t2)
		bnez $t5, squarePlayerFull
		sw $t4, 8($t2)
		jr $ra
	Square4:
		lw $t2, 4($t1)
		lw $t5, 0($t2)
		bnez $t5, squarePlayerFull
		sw $t4, 0($t2)
		jr $ra
	Square5:
		lw $t2, 4($t1)
		lw $t5, 4($t2)
		bnez $t5, squarePlayerFull
		sw $t4, 4($t2)
		jr $ra
	Square6:
		lw $t2, 4($t1)
		lw $t5, 8($t2)
		bnez $t5, squarePlayerFull
		sw $t4, 8($t2)
		jr $ra
	Square7:
		lw $t2, 8($t1)
		lw $t5, 0($t2)
		bnez $t5, squarePlayerFull
		sw $t4, 0($t2)
		jr $ra
	Square8:
		lw $t2, 8($t1)
		lw $t5, 4($t2)
		bnez $t5, squarePlayerFull
		sw $t4, 4($t2)
		jr $ra
	Square9:
		lw $t2, 8($t1)
		lw $t5, 8($t2)
		bnez $t5, squarePlayerFull
		sw $t4, 8($t2)
		jr $ra
	
squarePlayerFull:
	la $a0, notEmpty
	li $v0, 4
	syscall
	j UserPlays
	
	

computerPlay:
	
	li $v0, 42  # 42 is system call code to generate random int
	li $a1, 10 # $a1 is where you set the upper bound
	syscall     # your generated number will be at $a0
	move $a1, $a0
	jr $ra

updateBoardComputer:
	li $t4, 2 #what will be entered on the board for the computer
	li $t0, 1 #used to check value of input
	la $t1, board
	
	beq $a1, $t0, CSquare1
	addi $t0,$t0, 1
	beq $a1, $t0, CSquare2
	addi $t0,$t0, 1
	beq $a1, $t0, CSquare3
	addi $t0,$t0, 1
	beq $a1, $t0, CSquare4
	addi $t0,$t0, 1
	beq $a1, $t0, CSquare5
	addi $t0,$t0, 1
	beq $a1, $t0, CSquare6
	addi $t0,$t0, 1
	beq $a1, $t0, CSquare7
	addi $t0,$t0, 1
	beq $a1, $t0, CSquare8
	addi $t0,$t0, 1
	beq $a1, $t0, CSquare9
	
	CSquare1:
		lw $t2, 0($t1)
		lw $t5, 0($t2)
		bnez $t5, ComputerPlays
		sw $t4, 0($t2)
		jr $ra
	CSquare2:
		lw $t2, 0($t1)
		lw $t5, 4($t2)
		bnez $t5, ComputerPlays
		sw $t4, 4($t2)
		jr $ra
	CSquare3:
		lw $t2, 0($t1)
		lw $t5, 8($t2)
		bnez $t5, ComputerPlays
		sw $t4, 8($t2)
		jr $ra
	CSquare4:
		lw $t2, 4($t1)
		lw $t5, 0($t2)
		bnez $t5, ComputerPlays
		sw $t4, 0($t2)
		jr $ra
	CSquare5:
		lw $t2, 4($t1)
		lw $t5, 4($t2)
		bnez $t5, ComputerPlays
		sw $t4, 4($t2)
		jr $ra
	CSquare6:
		lw $t2, 4($t1)
		lw $t5, 8($t2)
		bnez $t5, ComputerPlays
		sw $t4, 8($t2)
		jr $ra
	CSquare7:
		lw $t2, 8($t1)
		lw $t5, 0($t2)
		bnez $t5, ComputerPlays
		sw $t4, 0($t2)
		jr $ra
	CSquare8:
		lw $t2, 8($t1)
		lw $t5, 4($t2)
		bnez $t5, ComputerPlays
		sw $t4, 4($t2)
		jr $ra
	CSquare9:
		lw $t2, 8($t1)
		lw $t5, 8($t2)
		bnez $t5, ComputerPlays
		sw $t4, 8($t2)
		jr $ra
	
CheckWin:
	li $t0, 1
	la $t1, board
	j WinRow1
	
WinRow1:
	lw $t2, 0($t1)
	lw $t3, 0($t2)
	lw $t4, 4($t2)
	lw $t5, 8($t2)
	seq $s1, $t3, $t0
	seq $s2, $t4, $t0
	seq $s3, $t5, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, PlayerWin
	addi $t0, $t0, 1
	seq $s1, $t3, $t0
	seq $s2, $t4, $t0
	seq $s3, $t5, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, ComputerWin
	addi $t0, $t0, -1
	
WinRow2:
	lw $t2, 4($t1)
	lw $t3, 0($t2)
	lw $t4, 4($t2)
	lw $t5, 8($t2)
	seq $s1, $t3, $t0
	seq $s2, $t4, $t0
	seq $s3, $t5, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, PlayerWin
	addi $t0, $t0, 1
	seq $s1, $t3, $t0
	seq $s2, $t4, $t0
	seq $s3, $t5, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, ComputerWin
	addi $t0, $t0, -1

	
WinRow3:
	lw $t2, 8($t1)
	lw $t3, 0($t2)
	lw $t4, 4($t2)
	lw $t5, 8($t2)
	seq $s1, $t3, $t0
	seq $s2, $t4, $t0
	seq $s3, $t5, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, PlayerWin
	addi $t0, $t0, 1
	seq $s1, $t3, $t0
	seq $s2, $t4, $t0
	seq $s3, $t5, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, ComputerWin
	addi $t0, $t0, -1

	
WinColumn1:
	lw $t2, 0($t1)
	lw $t3, 4($t1)
	lw $t4, 8($t1)
	
	lw $t5, 0($t2)
	lw $t6, 0($t3)
	lw $a1, 0($t4)
	seq $s1, $t5, $t0
	seq $s2, $t6, $t0
	seq $s3, $a1, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, PlayerWin
	addi $t0, $t0, 1
	seq $s1, $t5, $t0
	seq $s2, $t6, $t0
	seq $s3, $a1, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, ComputerWin
	addi $t0, $t0, -1
	
WinColumn2:
	lw $t5, 4($t2)
	lw $t6, 4($t3)
	lw $a1, 4($t4)
	seq $s1, $t5, $t0
	seq $s2, $t6, $t0
	seq $s3, $a1, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, PlayerWin
	addi $t0, $t0, 1
	seq $s1, $t5, $t0
	seq $s2, $t6, $t0
	seq $s3, $a1, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, ComputerWin
	addi $t0, $t0, -1
	
WinColumn3:
	lw $t5, 8($t2)
	lw $t6, 8($t3)
	lw $a1, 8($t4)
	seq $s1, $t5, $t0
	seq $s2, $t6, $t0
	seq $s3, $a1, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, PlayerWin
	addi $t0, $t0, 1
	seq $s1, $t5, $t0
	seq $s2, $t6, $t0
	seq $s3, $a1, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, ComputerWin
	addi $t0, $t0, -1
	
WinDiag1:
	lw $t5, 0($t2)
	lw $t6, 4($t3)
	lw $a1, 8($t4)
	seq $s1, $t5, $t0
	seq $s2, $t6, $t0
	seq $s3, $a1, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, PlayerWin
	addi $t0, $t0, 1
	seq $s1, $t5, $t0
	seq $s2, $t6, $t0
	seq $s3, $a1, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, ComputerWin
	addi $t0, $t0, -1
	
WinDiag2:
	lw $t5, 8($t2)
	lw $t6, 4($t3)
	lw $a1, 0($t4)
	seq $s1, $t5, $t0
	seq $s2, $t6, $t0
	seq $s3, $a1, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, PlayerWin
	addi $t0, $t0, 1
	seq $s1, $t5, $t0
	seq $s2, $t6, $t0
	seq $s3, $a1, $t0
	and $s4, $s1, $s2
	and $s4, $s4, $s3
	bnez $s4, ComputerWin
	addi $t0, $t0, -1
	
	jr $ra
PlayerWin:
	la $a0, PlayerWon
	li $v0, 4
	syscall
	j exit

ComputerWin:
	la $a0, ComputerWon
	li $v0, 4
	syscall
	j exit

Draw:
	la $a0, GameDraw
	li $v0, 4
	syscall
	j exit
	
	
	
exit:

.data									### Data Section
        enterFNum:      .asciiz "\nFirst number: "			# Label Of Type Asks For The First Operand (asciiz is a data type that stores a                                                                    string in memory with a null terminator)
        enterOperator:  .asciiz "Operator( +,-,/,* ):"			# Label Asks For Entering The Operator
        enterSNum:      .asciiz "\nSecond number: "			# Label Asks For The Second Operand
        invOperator:    .asciiz "\nInvalid Operator,Try again.\n"       # Label Tells There Is An Invalid Operator
        result:         .asciiz "\nResult: "				# Label For Showing The Result
        againOrNot:     .asciiz "\nWant to calculate again it again?(y, n):"# Label For showing a message
        yesNoQ:         .asciiz "\n(y,n) pls."				# Label For giving 2 option (y for yes and n for no)
        anotherNumber:  .asciiz "\ndo it with another number?(y,n):"

.text						                        ### Text Section
.globl main								# Means that the symbol 'main' should be visible to the linker because other                                                                               object files can use it.

main:									# Beginning of Main Function
        #ask the user to enter the first num
        li $v0, 4							# load 4 to register $v0 [$v0 with code 4 means fire output]
        la $a0, enterFNum						# Load Address (Load the label string 'enterFNum' into register $a0 which is the                                                                   argument of $v0, 4 function)
        syscall
        #####################################

        #accept the float input from the user
        li $v0, 6							# load 6 to register $v0 [$v0 with code 6 get float input value]
        syscall
        mov.s $f1, $f0							# mov.s Moves Content Of Register $f0 (Which takes the float input by default)                                                                     to Register $f1
        #####################################

        #ask the user to enter the operator
        li $v0, 4							# load 4 to register $v0 [$v0 with code 4 means fire output]
        la $a0, enterOperator						# Load Address (Load the label string 'enterOperator' into register $a0 which is                                                                   the argument of $v0, 4 function)
        syscall
        #####################################
        #accept char input from the user
        li $v0, 12						        # load 12 to register $v0 [$v0 with code 12 get Charcater input value]
        syscall
        add $a1, $v0, $0						# Add Value of Register $0 to value of $c0 and put the addition into register $a1
        #####################################
        j acceptSec
        
acceptSec:

        #ask the user to enter the second num
        li $v0, 4							# load 4 to register $v0 [$v0 with code 4 means fire output]
        la $a0, enterSNum						# Load Address (Load the label string 'enterSNum' into register $a0 which is the                                                                   argument of $v0, 4 function)
        syscall
        #accept the float input from the user				
        addi $v0, $0, 6							# load 6 to register $v0 [$v0 with code 6 get float input value]
        syscall
        mov.s $f2, $f0  						# mov.s Moves Content Of Register $f0 (Whick takes the float input by default)                                                                     to Register $f2
        #####################################

        #checks for the + operator
        li $9, 0x2b						        # load the value of character + to constant register $9
        beq $a1, $9, addIt						# If value in register $9 == value in register $a1 (which hold the operator)                                                                       then call function addIt
        #####################################

        #checks for the - operator
        li $9, 0x2d						        # load the value of character - to constant register $9
        beq $a1, $9, subIt						# If value in register $9 == value in register $a1 (which hold the operator)                                                                       then call function subIt
        #####################################

        #checks for the * operator
        li $9, 0x2a						        # load the value of character * to constant register $9
        beq $a1, $9, mulIt						# If value in register $9 == value in register $a1 (which hold the operator)                                                                       then call function multIt
        #####################################

        #checks for the / operator
        li $9, 0x2f						        # load the value of character / to constant register $9
        beq $a1, $9, divIt						# If value in register $9 == value in register $a1 (which hold the operator)                                                                       then call function divIt
        #####################################

        #the program will reach this point if the operator isn't valid
        li $v0, 4							# Add Immediate With Overflow (Adds constant 4 to register $0 and save to                                                                          register $v0 [$v0 with code 4 means fire output])
        la $a0, invOperator						# Load Address (Load the string label 'invOperator' into register $a0 which is                                                                     the argument of $v0, 4 function)
        syscall
        #####################################

        j main								# Jump again to the main

calcMore:
        #print result
        li $v0, 4							# Add Immediate constant 4 to register $v0                                                                          register $v0 [$v0 with code 4 means fire output])
        la $a0, result							# Load Address (Load the string label 'result' into register $a0 which is the                                                                      argument of $v0, 4 function)
        syscall        
        li $v0, 2							# Load Immediate 
        syscall
        mov.s $f1, $f12
        #ask if want again or not
        li $v0, 4							# Add Immediate With Overflow (Adds constant 4 to register $0 and save to                                                                          register $v0, [$v0 with code 4 means fire output])
        la $a0, anotherNumber						# Load Address (Load the string label 'result' into register $a0 which is the                                                                      argument of $v0, 4 function)
        syscall
        j yesNoFun
        #######################

yesNoFun:
        #read input char form the user								
        li $v0, 12						        # Add Immediate With Overflow (Adds constant 12 to register $0 and save to                                                                         register $v0, [$v0 with code 4 means get char input])
        syscall
        add $a2, $v0, $0						# Add content of register $0 to content of register $v0 and save to register $a1                                                                   (Addint y or n character to $a2)
        
        #######################
        #check the command entered by user (y)						
        li $9, 0x79					                #  load Charcater y into register $9
        beq $a2, $9, acceptSec						# If value of register $a2 (which holds the character) == value of register $9                                                                     then run the main function.
        #####################################

        #check the command entered by user (n)
        li $9, 0x6e						        # load Charcater n into register $9
        beq $a2, $9, printAnswer						# If value of register $a1 (which holds the character) == value of register $9                                                                     then run the exitApp function.
        #####################################

        #if the user hits some other char
        li $v0, 4							# load 4 to register $v0 [$v0 with code 4 means fire output]
        la $a0, yesNoQ							# Load Address (Load the string label 'yesNoQ' into register $a0 which is the                                                                      argument of $v0, 4 function)
        syscall
        j yesNoFun

addIt:
        #add and store in f12
        add.s $f12, $f1, $f2						# add.s Adds the floating value of register $f2 to the floating value of                                                                           register $f1 and save it into $f12
        j calcMore
        ####################

subIt:
        #subtract and store in f12									
        sub.s $f12, $f1, $f2						# sub.s Subtracts the floating value of register $f2 from the floating value of                                                                    register $f1 and save it into $f12
        
        #########################

        j calcMore							

mulIt:
        #multiply and store in f12
        mul.s $f12, $f1, $f2						# mul.s Multiplys the value of register $f2 at the value of register $f1 and                                                                       save result to $f12
        
        #########################

        j calcMore							# Jump to the printAnswer function

divIt:
        #divide and store in f12					# div.s Divides the value of register $f1 on the value of register $f2 and save                                                                    result to $f12
        div.s $f12, $f1, $f2
        
        #######################

        j calcMore							# Jump to the printAnswer function

printAnswer:
        #print result
        addi $v0, $0, 4							# Add Immediate With Overflow (Adds constant 4 to register $0 and save to                                                                          register $v0 [$v0 with code 4 means fire output])
        la $a0, result							# Load Address (Load the string label 'result' into register $a0 which is the                                                                      argument of $v0, 4 function)
        syscall        
        li $v0, 2							# Load Immediate 
        syscall
        #######################

        j anotherCalc							# Jump to the anotherCalc function


anotherCalc:
        #ask if want again or not
        li $v0, 4							# Add Immediate With Overflow (Adds constant 4 to register $0 and save to                                                                          register $v0, [$v0 with code 4 means fire output])
        la $a0, againOrNot						# Load Address (Load the string label 'result' into register $a0 which is the                                                                      argument of $v0, 4 function)
        syscall
        #######################

        #read input char form the user								
        li $v0, 12						        # Add Immediate With Overflow (Adds constant 12 to register $0 and save to                                                                         register $v0, [$v0 with code 4 means get char input])
        syscall
        add $a1, $v0, $0						# Add content of register $0 to content of register $v0 and save to register $a1                                                                   (Addint y or n character to $a1)
        #######################

        #check the command entered by user (y)						
        li $9, 0x79					                #  load Charcater y into register $9
        beq $a1, $9, main						# If value of register $a1 (which holds the character) == value of register $9                                                                     then run the main function.
        #####################################

        #check the command entered by user (n)
        li $9, 0x6e						        # load Charcater n into register $9
        beq $a1, $9, exitApp						# If value of register $a1 (which holds the character) == value of register $9                                                                     then run the exitApp function.
        #####################################

        #if the user hits some other char
        li $v0, 4							# load 4 to register $v0 [$v0 with code 4 means fire output]
        la $a0, yesNoQ							# Load Address (Load the string label 'yesNoQ' into register $a0 which is the                                                                      argument of $v0, 4 function)
        syscall
        j anotherCalc							# Jump to anotherCalc function
        #####################################

exitApp:
        #Exit the application
        li $v0, 10						        #Load ($v0, 10 means end of the program)
        syscall
        #####################################
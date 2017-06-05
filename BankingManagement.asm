 TITLE Banking Managemwnt System

INCLUDE Irvine32.inc

.data

msgwelcome byte "                         Welcome To Banking System ",0
msgask byte "Press 1 for New User or press 2 for Existing customer or press 3 to exit",0
err1 byte "Wrong input please enter correct input",0
msg3 byte "Enter user",0
msg4 byte "Enter Password",0
erruser byte "Incorrect Details",0
user1 byte 20 dup (?)
amount1 byte 20 dup (?)
amountsize1 dword ?
filehandle dword ?
money2 byte 20 dup (?)
amountsize2 dword ?
count dword ?
moneyfile byte "moneyfile.txt",0
temp dword ?
amount2 byte 20 dup (?)
amount dword ?
customer byte"Customer:   ",0
amount12 byte "amount:    ",0
usersize1 dword ?
passsize1 dword ?
msg51 byte "Press 1 for Deposit. Press 2 for Withdrawal. Press 3 for showing money. Press 4 to show details and Quit",0
pass1 byte 20 dup (?)
msg22 byte "Amount Deposited",0
msg23 byte "Amount Withdrawed",0
err22 byte "Not enough money",0
userfile byte "user.txt",0
passfile byte "password.txt",0
msg10 byte "Choose any transaction",0
user2 byte 20 dup (?)
msg15 byte "Enter Starting Amount",0
pass2 byte 20 dup (?)
usersize2 dword ?
passsize2 dword ?
msg12 byte "User Created",0
msgwithdrawal byte "Enter Withdrawal Amount",0
msgdeposit byte "Enter Deposit Amount",0


.code

main PROC

mov eax,cyan+(black*16)
call settextcolor

mov edx,offset msgwelcome
call writestring
call crlf
call crlf


l0:

call crlf
call crlf

mov edx,offset msgask
call writestring
call crlf
call crlf

call readdec

cmp eax,2

je l1

cmp eax,1

je l14

cmp eax,3

je l60

call crlf
call crlf

mov edx,offset err1
call writestring
call crlf
call crlf

jmp l0

l60:
exit

l1:
mov count,1
call crlf
call crlf

mov edx,offset msg3
call writestring
call crlf
call crlf

mov edx,offset user1
mov ecx,sizeof user1
call readstring
call crlf
call crlf

mov edx,offset msg4
call writestring
call crlf
call crlf

mov edx,offset pass1
mov ecx,sizeof pass1
call readstring

mov edx,offset userfile
call openinputfile

mov edx,offset user2
mov ecx,lengthof user2
call readfromfile

mov edx,offset passfile
call openinputfile

mov edx,offset pass2
mov ecx,lengthof pass2
call readfromfile

mov edx,offset user1
mov ecx,lengthof user1
mov esi,0

l2:

cmp user1[esi],0

je l3

inc esi

loop l2

l3:

mov eax,lengthof user1
sub eax,ecx
mov usersize1,eax

mov edx,offset user2
mov ecx,lengthof user2
mov esi,0

l4:

cmp user2[esi],0

je l5

inc esi

loop l4

l5:

mov eax,lengthof user2
sub eax,ecx
mov usersize2,eax

mov edx,offset pass1
mov ecx,lengthof pass1
mov esi,0

l6:

cmp pass1[esi],0

je l7

inc esi

loop l6

l7:

mov eax,lengthof pass1
sub eax,ecx
mov passsize1,eax

mov edx,offset pass2
mov ecx,lengthof pass2
mov esi,0

l8:

cmp pass2[esi],0

je l9

inc esi

loop l8

l9:

mov eax,lengthof pass2
sub eax,ecx
mov passsize2,eax


mov ecx,usersize1
cmp ecx,usersize2

jne l12

mov esi,0

l10:

mov al,user1[esi]
cmp al,user2[esi]

jne l12

inc esi

loop l10


mov ecx,passsize1
cmp ecx,passsize2

jne l12

mov esi,0

l13:

mov al,pass1[esi]
cmp al,pass2[esi]

jne l12

inc esi

loop l13


jmp l16

l12:

call crlf
call crlf

mov edx,offset erruser
call writestring
call crlf
call crlf

jmp l0


l14:

call crlf
call crlf

mov edx,offset msg3
call writestring
call crlf
call crlf

mov edx,offset user1
mov ecx,sizeof user1
call readstring
call crlf
call crlf

mov edx,offset msg4
call writestring
call crlf
call crlf

mov edx,offset pass1
mov ecx,sizeof pass1
call readstring
call crlf
call crlf

mov edx, OFFSET userfile
call CreateOutputFile

mov edx,offset user1
mov ecx,lengthof user1
call writetofile


mov edx, OFFSET passfile
call CreateOutputFile

mov edx,offset pass1
mov ecx,lengthof pass1
call writetofile


mov edx,offset msg12
call writestring
call crlf
call crlf


mov edx,offset msg15
call writestring
call crlf
call crlf


mov edx,offset amount1
mov ecx,sizeof amount1
call readstring


jmp l89


l16:

mov edx,offset moneyfile
call openinputfile

mov filehandle,eax

mov edx,offset amount1
mov ecx,lengthof amount1

call readfromfile

mov eax,filehandle
call closefile

l89:

mov esi,0
mov ecx,lengthof amount1

l25:

mov al,amount1[esi]
cmp al,0

je l26

inc esi

loop l25

l26:

mov eax,lengthof amount1

sub eax,ecx

mov amountsize1,eax

mov eax,0
mov esi,0

mov ecx,amountsize1

l31:

movzx ebx,amount1[esi]

sub ebx,'0'

mov edx,10

mul edx

add eax,ebx

inc esi

loop l31

mov amount,eax

mov edx,offset msg10
call writestring
call crlf
call crlf

l52:

mov edx,offset msg51
call writestring
call crlf
call crlf

call readdec

cmp eax,1
je l53

cmp eax,2
je l54

cmp eax,3
je l55

cmp eax,4
je l56


l53:

mov edx,offset msgdeposit
call writestring
call crlf
call crlf

call readdec

add amount,eax

jmp l52


l57:
mov edx,offset err22
call writestring
call crlf
call crlf

jmp l52

l54:

mov edx,offset msgwithdrawal

call writestring
call crlf
call crlf

call readdec

cmp eax,amount
jnbe l57

sub amount,eax

mov edx,offset msg23

call writestring


call crlf
call crlf
jmp l52


l55:

mov eax,amount
call writedec
call crlf
call crlf

jmp l52


l56:
mov edx,offset customer
call writestring
mov edx,offset user1
call writestring
call crlf

mov edx,offset amount12
call writestring
mov eax,amount
call writedec
call crlf


mov esi,0
mov eax,amount

l71:

mov edx,0
mov ebx,10
div ebx

add edx,0
mov temp,edx

mov dl,byte ptr temp
add dl,'0'
mov amount1[esi],dl

cmp eax,0

je l72

inc esi


loop l71

l72:
	

mov esi,0
mov ecx,lengthof amount1

l73:

mov al,amount1[esi]
cmp al,0

je l74

inc esi

loop l73

l74:

mov eax,lengthof amount1
sub eax,ecx
mov amountsize1,eax


mov esi,0
mov ecx,amountsize1


mov edx,amountsize1
sub edx,1


l76:


mov al,amount1[esi]

mov amount2[edx],al


inc esi

dec edx

loop l76



mov edx,offset moneyfile
call createoutputfile
mov filehandle,eax

mov edx,offset amount2
mov ecx,lengthof amount2

call writetofile
call closefile


exit
main ENDP
END main

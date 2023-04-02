.model small
.stack 0100h
.data

enteredNumber dw 0
OutputNumber dw 0
digitCount dw 0
temp1 dw 0
sum dw 0
score_file1 db 'high1.txt$',0
score_file2 db 'high2.txt$',0
score_file3 db 'high3.txt$',0
score_file4 db 'high4.txt$',0
score_file5 db 'high5.txt$',0
namefile_1 db 'name1.txt',0
namefile_2 db 'name2.txt',0
namefile_3 db 'name3.txt',0
namefile_4 db 'name4.txt',0
namefile_5 db 'name5.txt',0
filehandler1 dw ?
filehandler2 dw ?
filehandler3 dw ?
filehandler4 dw ?
filehandler5 dw ?
filehandler_name1 dw ?
filehandler_name2 dw ?
filehandler_name3 dw ?
filehandler_name4 dw ?
filehandler_name5 dw ?
score_str1 db '04$'
score_str2 db '04$'
score_str3 db '04$'
score_str4 db '04$'
score_str5 db '04$'
name_str1 db  10 dup ('$')
name_str2 db  10 dup ('$')
name_str3 db 10 dup ('$')
name_str4 db 10 dup ('$')
name_str5 db  10 dup ('$')
temp2 db 0
temp11 db 0
highscore_1 db 0
highscore_2 db 0
highscore_3 db 0
highscore_4 db 0
highscore_5 db 0
new_score db 18
rem1 db 0

temp db 0

answer_str db '00$',0
digitCount1 db 0



str1 db '1$'
SEJ DB 10,13,10,13,' $'
;-------------------------------------------------------------------------------------
str2 db 'Ball Breaker Game$'
strr3 db 'Enter your name$'
string_new_game db 'NEW GAME$'
strr_instructions db 'INSTRUCTIONS$'
strr_high_score db 'HIGH SCORE$'
strr_exit db 'EXIT$'
strr_resume db 'RESUME$'
strr_instrcutions_for_game1 db 'Their are total of three levels$'
strr_instrcutions_for_game2 db 'Use Arrow keys to$'
 strr_instrcutions_for_game7 db ' move the paddle around$'
strr_instrcutions_for_game3 db 'Hit the ball with paddle$'
strr_instrcutions_for_game4 db 'Or you lose.     good luck!!!!$'
strr_instrcutions_for_game5 db '. .$'
strr_instrcutions_for_game6 db ' U$'
strr_instrcutions_for_game8 db 'PADDLE->$'
strr_instrcutions_for_game9 db 'BALL->$'
sttr_pointing_arrow db '<--$'
strr_winscreen_str db 'YOU HAVE COMPLETED THE GAME$'
strr_winscreen_str1 db 'CONGRAGULATIONS$'
strr_winscreen_str2 db 'MADE BY:-   BAB ~_~ & SADDY "--"$'
strr_winscreen_str3 db 'WITH MEHNAT ;)$'
strr_winscreen_str4 db 'DO U WISH TO CONTINUE?$'
strr_winscreen_str5 db 'Press enter to continue$'
strr_winscreen_str6 db 'Press N to quit $'
sttr_choice_walah1 db '(1)        (2)       (3)$'
sttr_choice_walah db '(1)        (2)       (3)$'
strr_diffi db 'LEVEL      LEVEL     LEVEL$'
one db '1)$'
two db '2)$'
three db '3)$'
four db '4)$'
five db '5)$'
;-------------------------------------------------------------------------------------
MR7 DB 10,13,'  ******$'
str3 db 'INPUT YOUR NAME:$'
 fname db 'saad.txt',0
 fhandle dw ?
 msg db 'Enter Name: $'
buffer db 100 dup('$')

pepe db 0
second_page_up_down_variable db 1
var byte "nabeel$"
var2 byte 0
friendly dw 0



Ball_x_saad word 70
Ball_y_saad word 47
Ball_x_instruction word 10
Ball_y_instruction word 50




;------------------------

rect_x word     0
rect_y word     0
rectwidth word  0
rectheight word 0
rectcolour byte 0

Paddle_x word  50
Paddle_y word 169
Paddle_x_half word 0

Ball_x word 10
Ball_y word 50

bool_BallV word 0
bool_BallH word 0

Box_x word     40, 140, 240, 40, 240, 40, 140, 240
Box_y word     20,  40,  20, 40,  40, 80,  80,  80
Bool_Box word   1,   1,   1,  1,   1,  1,   1,   1
Bool_BoxExist word 1

BoxF_x word     240;
BoxF_y word      60;

BoxS_x word     140;
BoxS_y word      100;
Bool_BoxS word 1;

Level_Selector word 1

CurrentLives word 3

ScoreName Byte "Score: $"
LevelName Byte "Level: $"
NameStr Byte "Name: $"
ScoreCounter Byte 0
rem byte 0

.code
mov ax, @data
mov ds, ax




Start:

;video mode (graphic) 
mov ah, 0h
mov al, 13h    ;320x200
int 10h

mov CurrentLives, 3
mov ScoreCounter, 0
mov bool_boxs,1
call BoxCreator


call page1
MMenu:
call page2
mov ah, 0h
mov al, 13h    ;320x200
int 10h

Start1:
call BoxCreator

ResumeGame:
;video mode (graphic) 
mov ah, 0h
mov al, 13h    ;320x200
int 10h
mov Ball_x, 10
mov Ball_y, 50
mov bool_BallV, 0
mov bool_BallH, 0

gameLoop:

	call DrawScreen

	mov AH, 0Ch		;Clear Buffer
	int 21h
	call delay

	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0

	mov ah, 1
	int 16h
	mov bx,ax
	jz gameLoop



	cmp bh,4Bh
	je moveLeft
	cmp bh,4Dh
	je moveRight
	cmp bl,13
	je MMenu  ; loop until Exit is pressed
	cmp bl, 8
	je MMenu

jmp gameLoop




;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

jmp exit
;--------------------------------------------------------------------------------

;video mode (graphic) 
mov ah, 0h
mov al, 13h    ;320x200
int 10h

	mov rectcolour, 0
	mov rectwidth, 299
	mov rectheight, 180

	mov rect_x, 11
	mov rect_y, 0
	call DrawRectangle

DrawScreen PROC


	call CheckBox

	call DrawBallBlack
	call BallMovement
	call BallWallCollision
	call BallBoxCollision
	.IF Level_Selector == 1
	call BallPaddleCollision
	call DrawPaddle
	.ENDIF
	.IF Level_Selector == 2 || Level_Selector == 3
	call BallPaddleCollision2
	call DrawPaddle2
	.ENDIF
	.IF Level_Selector == 3
	call BallBoxFCollision
	call DrawBoxF
	.ENDIF
	.IF Level_Selector == 3 && Bool_BoxS == 1
	call DrawBoxS
	call BallBoxSCollision
	.ENDIF
	call DrawBall
	call DrawBox
	call DrawBorder

	ret
DrawScreen ENDP

;--------------------------------------------------------------------------------

moveLeft:
	call DrawPaddleBlack
	.IF Paddle_x > 10
	sub Paddle_x, 10
	.ENDIF

jmp gameLoop

;--------------------------------------------------------------------------------

moveRight:
	call DrawPaddleBlack
	.IF Level_Selector == 1
		.IF Paddle_x <= 250
		add Paddle_x, 10
		.ENDIF
	.ELSEIF Level_Selector == 2 || Level_Selector == 3
		.IF Paddle_x <= 260
		add Paddle_x, 10
		.ENDIF
	.ENDIF

jmp gameLoop

;--------------------------------------------------------------------------------

DrawBall PROC

	mov rectcolour, 4h
	mov rectwidth, 6
	mov rectheight, 6

	mov si, Ball_x
	mov rect_x, si
	mov si, Ball_y
	mov rect_y, si
	call DrawRectangle

	sub rectwidth, 2
	add rectheight, 2
	add rect_x, 1
	sub rect_y, 1
	call DrawRectangle

	add rectwidth, 4
	sub rectheight, 4
	sub rect_x, 2
	add rect_y, 2
	call DrawRectangle


	ret
DrawBall ENDP

DrawBallBlack PROC

	mov rectcolour, 0
	mov rectwidth, 6
	mov rectheight, 6

	mov si, Ball_x
	mov rect_x, si
	mov si, Ball_y
	mov rect_y, si
	call DrawRectangle

	sub rectwidth, 2
	add rectheight, 2
	add rect_x, 1
	sub rect_y, 1
	call DrawRectangle

	add rectwidth, 4
	sub rectheight, 4
	sub rect_x, 2
	add rect_y, 2
	call DrawRectangle


	ret
DrawBallBlack ENDP

BallMovement PROC

	.IF bool_BallV == 0
	add Ball_y, 5
	.ENDIF

	.IF bool_BallV == 1
	sub Ball_y, 5
	.ENDIF

	.IF bool_BallH == 0
		
				
	add Ball_x, 5
	.ENDIF

	.IF bool_BallH == 1
	sub Ball_x, 5
	.ENDIF

	ret 
BallMovement ENDP

;--------------------------------------------------------------------------------

BallWallCollision PROC

	.IF Ball_x <= 10
	mov bool_BallH, 0
	.ENDIF

	.IF Ball_y <= 10
	mov bool_BallV, 0
	.ENDIF

	.IF Ball_x >= 300
	mov bool_BallH, 1
	.ENDIF

	.IF Ball_y >= 190
	mov bool_BallV, 1
	dec CurrentLives
		.IF CurrentLives == 1 || CurrentLives == 2
		jmp ResumeGame
		.ENDIF
		.IF CurrentLives == 0
		jmp start
		.ENDIF
	.ENDIF

	ret
BallWallCollision ENDP

;--------------------------------------------------------------------------------

BallPaddleCollision PROC

push cx

	mov ax,Paddle_x
	sub ax, 5
	mov bx, Paddle_y
	sub bx, 10
	
	
	.IF (Ball_x >= ax)
	add ax, 55
	mov paddle_x_half,ax
	sub paddle_x_half,25
	mov cx,paddle_x_half
		.IF Ball_x <= ax && ball_x >= cx
			.IF Ball_y >= bx
			add bx, 10
				.IF Ball_y <= bx
				mov bool_BallV, 1
				mov bool_BallH, 0
				.ENDIF
			.ENDIF
		.ENDIF

		.IF ball_x<=ax && ball_x<=cx
			.IF Ball_y >= bx
			add bx, 10
				.IF Ball_y <= bx
				mov bool_BallV, 1
				mov bool_BallH, 1
				.ENDIF
			.ENDIF
		.ENDIF
	.ENDIF

	pop cx
	ret
BallPaddleCollision ENDP

BallPaddleCollision2 PROC

push cx

	mov ax,Paddle_x
	sub ax, 5
	mov bx, Paddle_y
	sub bx, 10
	
	
	.IF (Ball_x >= ax)
	add ax, 45
	mov paddle_x_half,ax
	sub paddle_x_half,20
	mov cx,paddle_x_half
		.IF Ball_x <= ax && ball_x >= cx
			.IF Ball_y >= bx
			add bx, 10
				.IF Ball_y <= bx
				mov bool_BallV, 1
				mov bool_BallH, 0
				.ENDIF
			.ENDIF
		.ENDIF

		.IF ball_x<=ax && ball_x<=cx
			.IF Ball_y >= bx
			add bx, 10
				.IF Ball_y <= bx
				mov bool_BallV, 1
				mov bool_BallH, 1
				.ENDIF
			.ENDIF
		.ENDIF
	.ENDIF

	pop cx
	ret
BallPaddleCollision2 ENDP

;--------------------------------------------------------------------------------

BallBoxCollision PROC

	mov si, offset Box_x
	mov di, offset Box_y
	mov cx, lengthof Box_x
	mov bx, 0

	CollisionLoop:
	push si
	mov si, bx
	.IF Bool_Box[si] == 0
	pop si
	.ENDIF

	.IF Bool_Box[si] == 1 || Bool_Box[si] == 2 || Bool_Box[si] == 3
	pop si
	mov ax, [si]
	sub ax, 5
	mov dx, [si]
	add dx, 50
		.IF Ball_x >= ax
			.IF Ball_x <= dx
			mov ax, [di]
			sub ax, 11
				.IF Ball_y >= ax
				add ax, 2
					.IF Ball_y <= ax
					push si
					mov si, bx
					sub Bool_Box[si], 1
					pop si
					mov bool_BallV, 1
						call DrawBoxBlack
					.ENDIF
				.ENDIF
			mov ax, [di]
			add ax, 9
				.If Ball_y >= ax
				add ax, 2
					.IF	Ball_Y <= ax
					push si
					mov si, bx
					sub Bool_Box[si], 1
					pop si
					mov bool_BallV, 0
						call DrawBoxBlack
					.ENDIF
				.ENDIF
			.ENDIF
		.ENDIF

	mov ax, [di]
	sub ax, 5
	mov dx, [di]
	add dx, 10
		.IF Ball_y >= ax
			.IF Ball_y <= dx
			mov ax, [si]
			sub ax, 5
				.IF Ball_x >= ax
				add ax, 2
					.IF Ball_x <= ax
					push si
					mov si, bx
					sub Bool_Box[si], 1
					pop si
					mov bool_BallH, 1
						call DrawBoxBlack
					.ENDIF
				.ENDIF
			mov ax, [si]
			add ax, 55
				.If Ball_x >= ax
				add ax, 2
					.IF	Ball_x <= ax
					push si
					mov si, bx
					sub Bool_Box[si], 1
					pop si
					mov bool_BallH, 0
						call DrawBoxBlack
					.ENDIF
				.ENDIF
			.ENDIF
		.ENDIF
	.ENDIF



	add si, 2
	add di, 2
	add bx, 2

	dec cx
	cmp cx, 0
	jne CollisionLoop


	mov si, offset Box_x
	mov di, offset Box_y
	mov cx, lengthof Box_x
	mov bx, 0

	ret
BallBoxCollision ENDP

BallBoxFCollision PROC

	mov si, offset BoxF_x
	mov di, offset BoxF_y
	mov cx, lengthof BoxF_x

	CollisionLoopF:
	mov ax, [si]
	sub ax, 5
	mov dx, [si]
	add dx, 50
	.IF Ball_x >= ax
		.IF Ball_x <= dx
		mov ax, [di]
		sub ax, 11
			.IF Ball_y >= ax
			add ax, 2
				.IF Ball_y <= ax
				mov bool_BallV, 1
				.ENDIF
			.ENDIF
		mov ax, [di]
		add ax, 9
			.If Ball_y >= ax
			add ax, 2
				.IF	Ball_Y <= ax
				mov bool_BallV, 0
				.ENDIF
			.ENDIF
		.ENDIF
	.ENDIF

	mov ax, [di]
	sub ax, 5
	mov dx, [di]
	add dx, 10
	.IF Ball_y >= ax
		.IF Ball_y <= dx
		mov ax, [si]
		sub ax, 5
			.IF Ball_x >= ax
			add ax, 2
				.IF Ball_x <= ax
				mov bool_BallH, 1
				.ENDIF
			.ENDIF
		mov ax, [si]
		add ax, 55
			.If Ball_x >= ax
			add ax, 2
				.IF	Ball_x <= ax
				mov bool_BallH, 0
				.ENDIF
			.ENDIF
		.ENDIF
	.ENDIF



	add si, 2
	add di, 2

	dec cx
	cmp cx, 0
	jne CollisionLoopF


	mov si, offset BoxF_x
	mov di, offset BoxF_y
	mov cx, lengthof BoxF_x
	mov bx, 0

	ret
BallBoxFCollision ENDP

BallBoxSCollision PROC

	mov si, offset BoxS_x
	mov di, offset BoxS_y
	mov cx, lengthof BoxS_x

	CollisionLoopS:
	mov ax, [si]
	sub ax, 5
	mov dx, [si]
	add dx, 50
	.IF Ball_x >= ax
		.IF Ball_x <= dx
		mov ax, [di]
		sub ax, 11
			.IF Ball_y >= ax
			add ax, 2
				.IF Ball_y <= ax
				mov bool_BallV, 1
				mov Bool_BoxS, 0
				call DrawBoxBlack
				call BoxSpecial
				.ENDIF
			.ENDIF
		mov ax, [di]
		add ax, 9
			.If Ball_y >= ax
			add ax, 2
				.IF	Ball_Y <= ax
				mov bool_BallV, 0
				mov Bool_BoxS, 0
				call DrawBoxBlack
				call BoxSpecial
				.ENDIF
			.ENDIF
		.ENDIF
	.ENDIF

	mov ax, [di]
	sub ax, 5
	mov dx, [di]
	add dx, 10
	.IF Ball_y >= ax
		.IF Ball_y <= dx
		mov ax, [si]
		sub ax, 5
			.IF Ball_x >= ax
			add ax, 2
				.IF Ball_x <= ax
				mov bool_BallH, 1
				mov Bool_BoxS, 0
				call DrawBoxBlack
				call BoxSpecial
				.ENDIF
			.ENDIF
		mov ax, [si]
		add ax, 55
			.If Ball_x >= ax
			add ax, 2
				.IF	Ball_x <= ax
				mov bool_BallH, 0
				mov Bool_BoxS, 0
				call DrawBoxBlack
				call BoxSpecial
				.ENDIF
			.ENDIF
		.ENDIF
	.ENDIF



	add si, 2
	add di, 2

	dec cx
	cmp cx, 0
	;jne CollisionLoopS


	mov si, offset BoxS_x
	mov di, offset BoxS_y
	mov cx, lengthof BoxS_x
	mov bx, 0

	ret
BallBoxSCollision ENDP

;--------------------------------------------------------------------------------

CheckBox PROC
push ax
push bx
push cx
push dx
push bp
push si
push di

	mov cx, lengthof Bool_Box
	mov si, offset Bool_Box

	mov Bool_BoxExist, 0

	loopCB:

	mov ax, [si]
	.IF	ax == 1 || ax == 2 || ax == 3

	mov Bool_BoxExist, 1

	.ENDIF

	add si, 2

	loop loopCB


	.IF Bool_BoxExist == 0
		.IF Level_Selector == 1
		mov Level_Selector, 2
		jmp Start1
		.ELSEIF Level_Selector == 2
		mov Level_Selector, 3
		jmp Start1
		.ELSEIF Level_Selector == 3
		call winscreen
		jmp start
		.ENDIF
	.ENDIF

pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
	ret
CheckBox ENDP

BoxCreator PROC

	mov cx, lengthof Bool_Box
	mov si, offset Bool_Box

	mov Bool_BoxExist, 1

	loopBC:

	.IF Level_Selector == 1
	mov ax, 1
	.ELSEIF Level_Selector == 2
	mov ax, 2
	.ELSEIF Level_Selector == 3
	mov ax, 3
	.ENDIF
	mov [si], ax

	add si, 2

	loop loopBC

	ret
BoxCreator ENDP

;--------------------------------------------------------------------------------


DrawBox PROC

	mov rectwidth,  50
	mov rectheight,  10

	mov si, offset Box_x
	mov di, offset Box_y
	mov cx, lengthof Box_x

	mov bx, 0

	DrawLoop:

	mov ax, [si]
	mov rect_x, ax
	mov ax, [di]
	mov rect_y, ax
	push si
		
		mov si, bx
		.IF Bool_Box[si] == 1
		mov rectcolour,  9
		call DrawRectangle
		.ELSEIF Bool_Box[si] == 2
		mov rectcolour,  13
		call DrawRectangle
		.ELSEIF Bool_Box[si] == 3
		mov rectcolour,  4
		call DrawRectangle
		.ENDIF
	pop si

	add si, 2
	add di, 2
	add bx, 2

	loop DrawLoop

	ret
DrawBox ENDP

DrawBoxF PROC

	mov rectwidth,  50
	mov rectheight,  10

	mov si, offset BoxF_x
	mov di, offset BoxF_y
	mov cx, lengthof BoxF_x

	mov bx, 0

	DrawLoopF:

	mov ax, [si]
	mov rect_x, ax
	mov ax, [di]
	mov rect_y, ax
	push si
		
		mov si, bx
		mov rectcolour,  15
		call DrawRectangle
	pop si

	add si, 2
	add di, 2
	add bx, 2

	loop DrawLoopF

	ret
DrawBoxF ENDP

DrawBoxS PROC

	mov rectwidth,  50
	mov rectheight,  10

	mov ax, BoxS_x
	mov rect_x, ax
	mov ax, BoxS_y
	mov rect_y, ax
		mov rectcolour,  10
		call DrawRectangle


	ret
DrawBoxS ENDP

DrawBoxBlack PROC
	mov rectcolour, 0
	mov rectwidth, 50
	mov rectheight, 10

	push ax
	mov ax,[si]
	mov rect_x, ax
	mov ax, [di]
	mov rect_y, ax
	pop ax
	call DrawRectangle
	call SOUND
	.IF Level_Selector == 1
	add ScoreCounter, 1
	.ELSEIF Level_Selector == 2
	add ScoreCounter, 2
	.ELSEIF Level_Selector == 3
	add ScoreCounter, 3
	.ENDIF
	ret
DrawBoxBlack ENDP

;--------------------------------------------------------------------------------

BoxSpecial PROC
push si
push di

	mov si, 5

	BSLoop:
		mov cx, 0

		mov di, 0
		mov ah, 0
		int 1ah

		mov ax, dx
		mov dx, 0
		mov bx, lengthof Bool_Box
		div bx
		mov cl, dl

		.IF cx == 0
		jmp skpBS
		.ENDIF

		AddLoop:
		add di, 2
		loop AddLoop

		skpBS:
		.IF	Bool_Box[di] == 1 || Bool_Box[di] == 2 || Bool_Box[di] == 3
		dec si
		mov Bool_Box[di], 0
		mov ax, offset Box_x
		add ax, di
		;add ax, di
		mov bx, offset Box_y
		add bx, di
		;add bx, di

		push si
		push di

		mov si, ax
		mov di, bx

		call DrawBoxBlack

		pop di
		pop si

		call CheckBox

		.ENDIF
		
		.IF si == 0
		jmp BSEXIT
		.ENDIF

	jmp BSLoop


	BSEXIT:
pop di
pop si
	ret
BoxSpecial ENDP

;--------------------------------------------------------------------------------

DrawPaddle PROC
	mov rectcolour, 15
	mov rectwidth, 50
	mov rectheight, 10

	mov si, Paddle_x
	mov rect_x, si
	mov si, Paddle_y
	mov rect_y, si
	call DrawRectangle

	ret
DrawPaddle ENDP

DrawPaddle2 PROC
	mov rectcolour, 15
	mov rectwidth, 40
	mov rectheight, 10

	mov si, Paddle_x
	mov rect_x, si
	mov si, Paddle_y
	mov rect_y, si
	call DrawRectangle

	ret
DrawPaddle2 ENDP

DrawPaddleBlack PROC
	mov rectcolour, 0
	mov rectwidth, 50
	mov rectheight, 10

	mov si, Paddle_x
	mov rect_x, si
	mov si, Paddle_y
	mov rect_y, si
	call DrawRectangle

	ret
DrawPaddleBlack ENDP

;--------------------------------------------------------------------------------

DrawBorder PROC

	mov rectcolour, 14

	mov rectwidth, 300
	mov rectheight, 5
	mov rect_x, 10
	mov rect_y, 185
	call DrawRectangle

	mov rectwidth, 1
	mov rectheight, 180
	mov rect_x, 10
	mov rect_y, 10
	call DrawRectangle

	mov rectwidth, 1
	mov rectheight, 180
	mov rect_x, 310
	mov rect_y, 10
	call DrawRectangle

	mov rectwidth, 300
	mov rectheight, 1
	mov rect_x, 10
	mov rect_y, 10
	call DrawRectangle

	call DrawHeart
	call DrawBorderStrings

	ret
DrawBorder ENDP
;--------------------------------------------------------------------------------

DrawRectangle PROC
	push cx

	mov Al, rectcolour
	mov CX, rect_x
	dec cx
	add CX, rectwidth	
	mov DX, rect_y
	add DX, rectheight
	looprectvertical:
		looprecthorizontal:
			mov ah, 0Ch
			int 10h
			sub CX, 1
			cmp CX, rect_x
		jge looprectvertical
		add CX, rectwidth
		sub DX, 1
		cmp DX, rect_y
	jge looprecthorizontal


	pop cx
	ret	
DrawRectangle ENDP

;--------------------------------------------------------------------------------

SOUND PROC
push ax
push bx
push cx
push dx
push bp
push si
push di

        mov al, 182         ; Prepare the speaker for the
        out 43h, al         ;  note
        mov ax, 4560        ; Frequency number (in decimal)
                                ;  for middle C
        out 42h, al         ; Output low byte
        mov al, ah          ; Output high byte
        out 42h, al 
        in al, 61h         ; Turn on note (get value from
                                ;  port 61h)
        or al, 00000011b   ; Set bits 1 and 0
        out 61h, al         ; Send new value.
        mov bx, 25          ; Pause for duration of note.
pause1:
        mov cx, 2500
pause2:
        dec cx
        jne pause2
        dec bx
        jne pause1
        in  al, 61h         ; Turn off note (get value from
                                ;  port 61h).
        and al, 11111100b   ; Reset bits 1 and 0.
        out 61h, al         ; Send new value.

pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
		ret
SOUND ENDP

;--------------------------------------------------------------------------------

DrawHeart PROC


.IF CurrentLives == 3 || CurrentLives == 2 || CurrentLives == 1
	MOV AH,02H
	MOV BX, 0
	MOV DH, 2;Row Number
	MOV DL, 0;Column Number
	INT 10H

	mov al, 3    ;ASCII code of Character 
	mov bx,0
	mov bl, 1100b
	mov cx, 1     ;repetition count
	mov ah,09h
	int 10h
.ENDIF
	;////////////////////

.IF CurrentLives == 3 || CurrentLives == 2
	MOV AH,02H
	MOV BX,0
	MOV DH, 3;Row Number
	MOV DL, 0;Column Number
	INT 10H

	mov al, 3    ;ASCII code of Character 
	mov bx,0
	mov bl, 1100b
	mov cx, 1     ;repetition count
	mov ah,09h
	int 10h
.ENDIF

	;////////////////////

.IF CurrentLives == 3
	MOV AH,02H
	MOV BX,0
	MOV DH, 4;Row Number
	MOV DL, 0;Column Number
	INT 10H

	mov al, 3    ;ASCII code of Character 
	mov bx,0
	mov bl, 1100b
	mov cx, 1     ;repetition count
	mov ah,09h
	int 10h
.ENDIF

	ret
DrawHeart ENDP

;--------------------------------------------------------------------------------

DrawBorderStrings PROC
push ax
push bx
push cx
push dx
push bp
push si
push di

	MOV AH,02H
	MOV BX,0
	MOV DH, 0;Row Number
	MOV DL, 22;Column Number
	INT 10H

	lea dx, str2
	mov ah,09h
	int 21h

	mov ah, 2
MOV BX,0
mov dh, 0   ;row
mov dl, 27     ;column
int 10h

	mov al,'B'    ;ASCII code of Character 
mov bx,0
mov bl,1101b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 0   ;row
mov dl, 28     ;column
int 10h

mov al,'R'    ;ASCII code of Character 
mov bx,0
mov bl,1011b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 0   ;row
mov dl, 29     ;column
int 10h

mov al,'E'    ;ASCII code of Character 
mov bx,0
mov bl,1010b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 0  ;row
mov dl, 30     ;column
int 10h

mov al,'A'    ;ASCII code of Character 
mov bx,0
mov bl,1100b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 0   ;row
mov dl, 31     ;column
int 10h

mov al,'K'    ;ASCII code of Character 
mov bx,0
mov bl,1101b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 0   ;row
mov dl, 32    ;column
int 10h

mov al,'E'    ;ASCII code of Character 
mov bx,0
mov bl,1010b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 0   ;row
mov dl, 33     ;column
int 10h

mov al,'R'    ;ASCII code of Character 
mov bx,0
mov bl,0001b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

	
	MOV AH,02H
	MOV BX,0
	MOV DH, 0;Row Number
	MOV DL, 2;Column Number
	INT 10H

	lea dx, NameStr
	mov ah,09h
	int 21h

	MOV AH,02H
	MOV BX,0
	MOV DH, 0;Row Number
	MOV DL, 8;Column Number
	INT 10H

	lea dx, Buffer
	mov ah,09h
	int 21h
	
	MOV AH,02H
	MOV BX,0
	MOV DH, 24;Row Number
	 MOV DL, 2;Column Number
	INT 10H

	lea dx, ScoreName
	mov ah,09h
	int 21h

	MOV AH,02H
	MOV BX,0
	MOV DH, 24;Row Number
	 MOV DL, 31;Column Number
	INT 10H

	lea dx, LevelName
	mov ah,09h
	int 21h

	MOV AH,02H
	MOV BX,0
	MOV DH, 24;Row Number
	MOV DL, 38;Column Number
	INT 10H

	mov bl, 12
	.IF Level_Selector == 1
	mov dl, '1'
	.ELSEIF Level_Selector == 2
	mov dl, '2'
	.ELSEIF Level_Selector == 3
	mov dl, '3'
	.ENDIF
	Mov ah, 2
	int 21h


;setting cursor position
mov ah, 2
mov dh, 24    ;row
mov dl, 10 ;column
int 10h


mov ax,0
mov al, ScoreCounter
mov bl,10
div bl
mov rem,ah

mov dl,al
add dl,48
mov ah,02h
int 21h

;setting cursor position
mov ah, 2
mov dh, 24     ;row
mov dl, 11 ;column
int 10h

mov dl,rem
add dl,48
mov ah,2
int 21h

pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
	ret
DrawBorderStrings ENDP

;--------------------------------------------------------------------------------

delay proc
	push ax
	push bx
	push cx
	push dx

	mov cx,11000
	mydelay:
	.IF Level_Selector == 1
	mov bx, 15     ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.
	.ENDIF
	.IF Level_Selector == 2
	mov bx, 10     ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.
	.ENDIF
	.IF Level_Selector == 3
	mov bx, 5     ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.
	.ENDIF
	mydelay1:
	dec bx
	jnz mydelay1
	loop mydelay


	pop dx
	pop cx
	pop bx
	pop ax

	ret
delay ENDP

;--------------------------------------------------------------------------------

zz proc;---------------------------------------------------------------------------------------
	mov ah, 0
mov al, 13h    ;320x200
int 10h
call boarder



mov AH, 0Ch		;Clear Buffer
	int 21h
	MOV AH,02H
 MOV BX,0
 MOV DH, 4;Row Number
 MOV DL, 7;Column Number
INT 10H

	lea dx,sttr_choice_walah1
	mov ah,09h
	int 21h

	mov AH, 0Ch		;Clear Buffer
	int 21h
	MOV AH,02H
 MOV BX,0
 MOV DH, 12;Row Number
 MOV DL, 6;Column Number
INT 10H

	lea dx,strr_diffi
	mov ah,09h
	int 21h
	
	mov AH, 0Ch		;Clear Buffer
	int 21h

	MOV AH,02H
	 MOV BX,0
 MOV DH, 14;Row Number
 MOV DL, 7;Column Number
INT 10H

	lea dx,sttr_choice_walah
	mov ah,09h
	int 21h

		mov AH, 0Ch		;Clear Buffer
	int 21h


	mov rectcolour, 1
	mov rectwidth, 40
	mov rectheight, 26

	mov rect_x, 48
	mov rect_y, 46
	call DrawRectangle

	mov rectcolour,13
	mov rect_x,136
	call DrawRectangle

	mov rectcolour,4
	mov rect_x,217
	call DrawRectangle
again_and_again:

	
	mov AH, 0Ch		;Clear Buffer
	int 21h
	call delay
	mov ah, 1
	int 16h
	mov bx,ax
	jz again_and_again
	.if bl=='1'
	mov Level_Selector,1 

	.endif
	.if bl=='2'
		mov Level_Selector,2
	.endif
	.if bl=='3'
		mov Level_Selector,3
	.endif

	.if bl == 13
	jmp MMenu
	.endif

	.if bl == 8
	jmp MMenu
	.endif

	jmp start1
	
call boarder
ret
zz endp





instruction_screen proc;------------------------------------------
	mov ah, 0
mov al, 13h    ;320x200
int 10h

call boarder
mov ah, 6
mov al, 0
mov bh, 12     ;color
mov ch, 10    ;top row of window
mov cl, 17    ;left most column of window
mov dh, 10     ;Bottom row of window
mov dl, 26  ;Right most column of window
int 10h

MOV AH,02H
 MOV BX,0
 MOV DH, 2;Row Number
 MOV DL, 3;Column Number
INT 10H

	lea dx,strr_instrcutions_for_game1
	mov ah,09h
	int 21h

	MOV AH,02H
 MOV BX,0
 MOV DH, 4;Row Number
 MOV DL, 5;Column Number
INT 10H

	lea dx,strr_instrcutions_for_game2
	mov ah,09h
	int 21h


		MOV AH,02H
 MOV BX,0
 MOV DH, 6;Row Number
 MOV DL, 4;Column Number
INT 10H

	lea dx,strr_instrcutions_for_game7
	mov ah,09h
	int 21h


	MOV AH,02H
 MOV BX,0
 MOV DH, 9;Row Number
 MOV DL, 9;Column Number
INT 10H

	lea dx,strr_instrcutions_for_game8
	mov ah,09h
	int 21h

		MOV AH,02H
 MOV BX,0
 MOV DH, 14;Row Number
 MOV DL, 3;Column Number
INT 10H

	lea dx,strr_instrcutions_for_game3
	mov ah,09h
	int 21h

		MOV AH,02H
 MOV BX,0
 MOV DH, 16;Row Number
 MOV DL, 3;Column Number
INT 10H

	lea dx,strr_instrcutions_for_game4
	mov ah,09h
	int 21h

		MOV AH,02H
 MOV BX,0
 MOV DH, 18;Row Number
 MOV DL, 28;Column Number
INT 10H

	lea dx,strr_instrcutions_for_game5
	mov ah,09h
	int 21h

		MOV AH,02H
 MOV BX,0
 MOV DH, 20;Row Number
 MOV DL, 28;Column Number
INT 10H

	lea dx,strr_instrcutions_for_game6
	mov ah,09h
	int 21h

	call drawball_first_page

			MOV AH,02H
 MOV BX,0
 MOV DH, 19;Row Number
 MOV DL, 12;Column Number
INT 10H

	lea dx,strr_instrcutions_for_game9
	mov ah,09h
	int 21h
mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0
	toppy:
		mov AH, 0Ch		;Clear Buffer
	int 21h
	;call delay
	mov ah, 1
	int 16h
	mov bx,ax
	jz toppy
	jnz qwer ; loop until Exit is pressed


	qwer:


	
ret
instruction_screen endp;-----------------------------------------------


boarder proc;----------------------------------------------------------------------------

mov rectcolour, 14
	mov rectwidth, 320
	mov rectheight, 200
	mov rect_x, 0
	mov rect_y, 0
	call DrawRectangle

	;320x200
	mov rectcolour, 0
	mov rectwidth, 292
	mov rectheight, 178
	mov rect_x, 14
	mov rect_y, 10
	call DrawRectangle
	ret
	boarder endp

draw_second_page proc


    mov rectcolour, 14
	mov rectwidth, 68
	mov rectheight, 11

	mov rect_x, 126
	mov rect_y, 46
	call DrawRectangle

    mov rectcolour, 0
	mov rectwidth, 66
	mov rectheight, 9

	mov rect_x, 127
	mov rect_y, 47
	call DrawRectangle
	;--------------------------------------------------------
	mov rectcolour, 14
	mov rectwidth, 52
	mov rectheight, 11
	mov rect_x, 134
	mov rect_y, 70
	call DrawRectangle

	mov rectcolour, 0
	mov rectwidth, 50
	mov rectheight, 9
	mov rect_x, 135
	mov rect_y, 71
	call DrawRectangle
	;-------------------------
	mov rectcolour, 14
	mov rectwidth, 84
	mov rectheight, 11
	mov rect_x, 118
	mov rect_y, 94
	call DrawRectangle

	mov rectcolour, 0
	mov rectwidth, 82
	mov rectheight, 9
	mov rect_x, 119
	mov rect_y, 95
	call DrawRectangle
	;-------------------------
	
	;-------------------------
	mov rectcolour, 14
	mov rectwidth, 100
	mov rectheight, 12
	mov rect_x, 110
	mov rect_y, 117
	call DrawRectangle

	mov rectcolour, 0
	mov rectwidth, 98
	mov rectheight, 10
	mov rect_x, 111
	mov rect_y, 118
	call DrawRectangle	
;---------------------------------------------
	mov rectcolour, 14
	mov rectwidth, 36
	mov rectheight, 11
	mov rect_x, 142
	mov rect_y, 142
	call DrawRectangle

	mov rectcolour, 0
	mov rectwidth, 34
	mov rectheight, 9
	mov rect_x, 143
	mov rect_y, 143
	call DrawRectangle

	MOV AH,02H
 MOV BX,0
 MOV DH, 6;Row Number
 MOV DL, 16;Column Number
INT 10H
	lea dx,string_new_game
	mov ah,09h
	int 21h
	

;--------------------------------------------
MOV AH,02H
 MOV BX,0
 MOV DH, 6;Row Number
 MOV DL, 10 ;Column Number;                      over here are the numbers   biefwbefboewfboew
INT 10H
	lea dx,one
	mov ah,09h
	int 21h

MOV AH,02H
 MOV BX,0
 MOV DH, 9;Row Number
 MOV DL, 10 ;Column Number;                    
INT 10H
	lea dx,two
	mov ah,09h
	int 21h

	MOV AH,02H
 MOV BX,0
 MOV DH, 12;Row Number
 MOV DL, 10 ;Column Number;                    
INT 10H
	lea dx,three
	mov ah,09h
	int 21h

	MOV AH,02H
 MOV BX,0
 MOV DH, 15;Row Number
 MOV DL, 10 ;Column Number;                    
INT 10H
	lea dx,four
	mov ah,09h
	int 21h

	MOV AH,02H
 MOV BX,0
 MOV DH, 18;Row Number
 MOV DL, 10 ;Column Number;                    
INT 10H
	lea dx,five
	mov ah,09h
	int 21h
;---------------------------------------------
MOV AH,02H
 MOV BX,0
 MOV DH, 9;Row Number
 MOV DL, 17 ;Column Number
INT 10H
	lea dx,strr_resume 
	mov ah,09h
	int 21h

;------------------------------------------
MOV AH,02H
 MOV BX,0
 MOV DH, 12 ;Row Number
 MOV DL, 15;Column Number
INT 10H
	lea dx,strr_high_score 
	mov ah,09h
	int 21h
;---------------------------------------------------


MOV AH,02H
 MOV BX,0
 MOV DH, 15 ;Row Number
 MOV DL, 14;Column Number
INT 10H

	lea dx,strr_instructions
	mov ah,09h
	int 21h
;------------------------------------------------------

MOV AH,02H
 MOV BX,0
 MOV DH, 18 ;Row Number
 MOV DL, 18 ;Column Number
INT 10H
	lea dx,strr_exit
	mov ah,09h
	int 21h
ret 

draw_second_page endp


DrawBall_first_page PROC

push ball_y_instruction
push ball_x_instruction

mov ball_y_instruction,150
mov ball_x_instruction,150
	mov rectcolour, 4h
	mov rectwidth, 6
	mov rectheight, 6

	mov si, Ball_x_instruction
	mov rect_x, si
	mov si, Ball_y_instruction
	mov rect_y, si
	call DrawRectangle

	sub rectwidth, 2
	add rectheight, 2
	add rect_x, 1
	sub rect_y, 1
	call DrawRectangle

	add rectwidth, 4
	sub rectheight, 4
	sub rect_x, 2
	add rect_y, 2
	call DrawRectangle

	pop ball_x_instruction
	pop ball_y_instruction
	ret
DrawBall_first_page ENDP


DrawBall_saad PROC

	;mov rectcolour, 4h
	mov rectwidth, 6
	mov rectheight, 6

	mov si, Ball_x_saad
	mov rect_x, si
	mov si, Ball_y_saad
	mov rect_y, si
	call DrawRectangle

	sub rectwidth, 2
	add rectheight, 2
	add rect_x, 1
	sub rect_y, 1
	call DrawRectangle

	add rectwidth, 4
	sub rectheight, 4
	sub rect_x, 2
	add rect_y, 2
	call DrawRectangle


	ret
DrawBall_saad ENDP

page1 proc
call boarder

;////////////////////////////////////////////	

mov ah, 6
mov al, 0
mov bh, 4    ;color red
mov ch, 10    ;top row of window
mov cl, 21 ;left most column of window
mov dh, 12     ;Bottom row of window
mov dl, 31  ;Right most column of window
int 10h

mov ah, 6
mov al, 0
mov bh, 1     ;color blue
mov ch, 10    ;top row of window
mov cl, 8   ;left most column of window
mov dh, 12     ;Bottom row of window
mov dl, 18  ;Right most column of window
int 10h

mov ah, 6
mov al, 0
mov bh, 4    ;color red
mov ch, 18    ;top row of window
mov cl, 8 ;left most column of window
mov dh, 20     ;Bottom row of window
mov dl, 18  ;Right most column of window
int 10h

mov ah, 6
mov al, 0
mov bh, 1     ;color blue
mov ch, 18    ;top row of window
mov cl, 21   ;left most column of window
mov dh, 20     ;Bottom row of window
mov dl, 31  ;Right most column of window
int 10h

mov ah, 6
mov al, 0
mov bh, 2    ;color green
mov ch, 14  ;top row of window
mov cl, 14   ;left most column of window
mov dh, 16    ;Bottom row of window
mov dl, 25  ;Right most column of window
int 10h
;//////////////////////////////////////////////
mov si, offset var
mov ah, 2
mov dh, 10     
mov dl, 10     
int 10h
mov cx, 6
int 10h

 MOV BX,0
 MOV DH, 4 ;Row Number
 MOV DL, 5 ;Column Number
INT 10H
	lea dx,str2
	mov ah,09h
	int 21h

mov ah, 2
MOV BX,0
mov dh, 4   ;row
mov dl, 10    ;column
int 10h

	mov al,'B'    ;ASCII code of Character 
mov bx,0
mov bl,1101b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 4   ;row
mov dl, 11    ;column
int 10h

mov al,'R'    ;ASCII code of Character 
mov bx,0
mov bl,1011b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 4   ;row
mov dl,  12    ;column
int 10h

mov al,'E'    ;ASCII code of Character 
mov bx,0
mov bl,1010b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 4  ;row
mov dl, 13     ;column
int 10h

mov al,'A'    ;ASCII code of Character 
mov bx,0
mov bl,1100b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 4   ;row
mov dl, 14    ;column
int 10h

mov al,'K'    ;ASCII code of Character 
mov bx,0
mov bl,1101b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 4   ;row
mov dl, 15    ;column
int 10h

mov al,'E'    ;ASCII code of Character 
mov bx,0
mov bl,1010b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 4   ;row
mov dl, 16     ;column
int 10h

mov al,'R'    ;ASCII code of Character 
mov bx,0
mov bl,0001b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

;-----------------------------------------------------------------------



MOV AH,02H
 MOV BX,0
 MOV DH, 5 ;Row Number
 MOV DL, 5 ;Column Number
INT 10H
	lea dx,msg
	mov ah,09h
	int 21h
	mov si,0
	mov cx,0
	again:
	mov ah,01h
	int 21h
	cmp al,13
	je exit_norepeat
	int 10h
	mov buffer[si],al
	inc si
	inc cx
	jmp again
	exit_norepeat:
mov ah,40h
	mov dx,offset fname
	mov al,2
	mov ah,3dh
	int 21h
	mov cx,10
	mov bx,ax
	mov dx,offset buffer
	mov ah,40h
	int 21h
	;///////////////////////////////////////
	ret
page1 endp

page2 proc

poopy:
		
mov al, 13h    ;320x200
int 10h
	
	call boarder
     mov ah, 6
call draw_second_page

mov rectcolour,4h
	call drawball_saad
loppy1:
mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0
		mov AH, 0Ch		;Clear Buffer
	int 21h
	call delay

	mov ah, 1
	int 16h
	mov bx,ax

	mov friendly,bx
	jz loppy1
	cmp bl,13
	je exit1  ; loop until Exit is pressed
	cmp bH, 48h
	je moveup
	cmp bl,'1'
	je exit1
	cmp bl,'2'
	
	je 	friendly_tag

	cmp bl,'3'
		
	je	friendly_tag

	cmp bl,'4'
	
	je 	friendly_tag

	cmp bl,'5'
	
	je friendly_tag


	cmp bH, 50h
	je movedown

	jmp loppy1
	moveup:
		mov rectcolour,0
	call drawball_saad
	push ax
	mov al,second_page_up_down_variable
	sub al,1
	mov second_page_up_down_variable,al

	
	.if al==0
	mov second_page_up_down_variable,5
	.endif
	


	.if second_page_up_down_variable==1
	mov rectcolour,4h
	mov ball_x_saad,70
	mov ball_y_saad,47
	call drawball_saad

	.endif

	.if second_page_up_down_variable==2
	mov rectcolour,4h
		mov ball_x_saad,70
	mov ball_y_saad,71
	call drawball_saad

	.endif
	.if second_page_up_down_variable==3
	mov rectcolour,4h
	mov ball_x_saad,70
	mov ball_y_saad,95
	call drawball_saad

	.endif
	.if second_page_up_down_variable==4
	mov rectcolour,4h
		mov ball_x_saad,70
	mov ball_y_saad,120
	call drawball_saad

	.endif
	.if second_page_up_down_variable==5
	mov rectcolour,4h
	mov ball_x_saad,70
	mov ball_y_saad,143
	call drawball_saad

	.endif
	pop ax
	jmp loppy1


	movedown:
	mov rectcolour,0
	call drawball_saad
	push ax
	mov al,second_page_up_down_variable
	add al,1
	mov second_page_up_down_variable,al

	
	.if al==6
	mov second_page_up_down_variable,1
	.endif
	pop ax
	

	


	.if second_page_up_down_variable==1
	mov rectcolour,4h
	mov ball_x_saad,70
	mov ball_y_saad,47
	call drawball_saad

	.endif

	.if second_page_up_down_variable==2
	mov rectcolour,4h
		mov ball_x_saad,70
	mov ball_y_saad,71
	call drawball_saad

	.endif
	.if second_page_up_down_variable==3
	mov rectcolour,4h
	mov ball_x_saad,70
	mov ball_y_saad,95
	call drawball_saad

	.endif
	.if second_page_up_down_variable==4
	mov rectcolour,4h
		mov ball_x_saad,70
	mov ball_y_saad,120
	call drawball_saad

	.endif
	.if second_page_up_down_variable==5
	mov rectcolour,4h
	mov ball_x_saad,70
	mov ball_y_saad,143
	call drawball_saad

	.endif


	jmp loppy1
	exit1:
	


	.if second_page_up_down_variable == 1
	
	call zz

	.endif

	.if second_page_up_down_variable == 2
	; call highscore_screen
	jmp ResumeGame
	.endif

	.if second_page_up_down_variable == 3
	;call instructions_screen
	call highscorescreen
	jmp poopy
	.endif

	.if second_page_up_down_variable == 4 
	call instruction_screen
	jmp poopy
	.endif
	
	.if second_page_up_down_variable == 5
	jmp exit
	.endif

	jmp exit2

	friendly_tag:

	.if bl== '1' || bl== '2' || bl== '3' || bl == '4' || bl=='5'

	.if bl== '1'
		call zz
	.endif
	
	.if bl== '2' 
		jmp ResumeGame
	.endif

	.if bl== '3'
	;	call pause_screen
	;call highscore
	jmp poopy
	.endif

	.if bl== '4'
		call instruction_screen
	jmp poopy
	.endif

	.if bl== '5'
	jmp exit2
	.endif

	.endif
	exit2:
ret
page2 endp
;//////////////////////

winscreen proc

	mov ah, 0
mov al, 13h    ;320x200
int 10h

call boarder



MOV AH,02H
 MOV BX,0
 MOV DH, 2;Row Number
 MOV DL, 7;Column Number
INT 10H

	lea dx,strr_winscreen_str
	mov ah,09h
	int 21h

	loppypart2:
mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0
		mov AH, 0Ch		;Clear Buffer
	int 21h

	
mov ah, 2
MOV BX,0
mov dh, 4  ;row
mov dl, 16     ;column
int 10h

mov al,'B'    ;ASCII code of Character 
mov bx,0
mov bl,1101b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 4   ;row
mov dl, 17     ;column
int 10h

mov al,'R'    ;ASCII code of Character 
mov bx,0
mov bl,1011b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 4   ;row
mov dl, 18     ;column
int 10h

mov al,'E'    ;ASCII code of Character 
mov bx,0
mov bl,1010b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 4  ;row
mov dl, 19     ;column
int 10h

mov al,'A'    ;ASCII code of Character 
mov bx,0
mov bl,1100b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 4   ;row
mov dl, 20     ;column
int 10h

mov al,'K'    ;ASCII code of Character 
mov bx,0
mov bl,1101b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 4   ;row
mov dl, 21    ;column
int 10h

mov al,'E'    ;ASCII code of Character 
mov bx,0
mov bl,1010b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 4   ;row
mov dl, 22     ;column
int 10h

mov al,'R'    ;ASCII code of Character 
mov bx,0
mov bl,0001b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h

mov ah, 2
MOV BX,0
mov dh, 4  ;row
mov dl, 23     ;column
int 10h

mov al,'S'    ;ASCII code of Character 
mov bx,0
mov bl,1111b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h


MOV AH,02H
 MOV BX,0
 MOV DH, 18;Row Number
 MOV DL, 4;Column Number
INT 10H

	lea dx,strr_winscreen_str2
	mov ah,09h
	int 21h

	
MOV AH,02H
 MOV BX,0
 MOV DH, 21;Row Number
 MOV DL, 12;Column Number
INT 10H

	lea dx,strr_winscreen_str3
	mov ah,09h
	int 21h

			mov ah, 2
MOV BX,0
mov dh, 21  ;row
mov dl, 25     ;column
int 10h

mov al,')'    ;ASCII code of Character 
mov bx,0
mov bl,1100b   ;Green color
mov cx,1     ;repetition count
mov ah,09h
int 10h



	
MOV AH,02H
 MOV BX,0
 MOV DH, 9;Row Number
 MOV DL, 8;Column Number
INT 10H

	lea dx,strr_winscreen_str4
	mov ah,09h
	int 21h

		
MOV AH,02H
 MOV BX,0
 MOV DH, 11;Row Number
 MOV DL, 8;Column Number
INT 10H

	lea dx,strr_winscreen_str5
	mov ah,09h
	int 21h

		
MOV AH,02H
 MOV BX,0
 MOV DH, 13;Row Number
 MOV DL, 8;Column Number
INT 10H

	lea dx,strr_winscreen_str6
	mov ah,09h
	int 21h
	loppypart01:
mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0
		mov AH, 0Ch		;Clear Buffer



	int 21h
	
	call delay

	mov ah, 0
	int 16h
	mov bx,ax
	cmp bl,'n'
	je exit
	cmp bl,0Dh
	je page2
	jz loppypart2
ret
winscreen endp

highscorescreen proc

call boarder
;/////////////



mov ah,3dh
lea dx,score_file1
mov al,2  ;open a file
int 21h
mov filehandler1,ax

mov cx,0
mov dx, 0
mov ah,42h
mov al,0; 0 beginning of file, 2 end of file
int 21h

mov ah, 3FH
mov cx, 2
mov dx, offset score_str1
mov bx, Filehandler1   ;reading
int 21h

mov ah, 3Eh
mov bx, filehandler1
int 21h

Mov dx, offset score_str1
Mov ah, 9
Int 21h


 mov si,offset score_str1
 mov cx,lengthof score_str1
 dec cx

 mov ax,0
 mov al,[si]
 sub al,48
 mov temp11,al
 mov al,0
mov bl,10

 add al,[si+1]
 sub al,48
 mov temp2,al
 mov al,0
 mov al,temp11
 mul bl
 add al,temp2


; mov highscore_1,al
 mov temp2,al


 mov bl,10
 div bl
 


 mov temp2,0
 mov temp11,0

;////////////////////////////////////////////////////////////////////////////

mov ah,3dh
lea dx,score_file2
mov al,2  ;open a file
int 21h
mov filehandler2,ax

mov cx,0
mov dx, 0
mov ah,42h
mov al,0; 0 beginning of file, 2 end of file
int 21h

mov ah, 3FH
mov cx, 2
mov dx, offset score_str2
mov bx, Filehandler2   ;reading
int 21h

mov ah, 3Eh
mov bx, filehandler2
int 21h

Mov dx, offset score_str2
Mov ah, 9
Int 21h

mov temp,0

 mov si,offset score_str2
 mov cx,lengthof score_str2
 dec cx

 mov ax,0
 mov al,[si]
 sub al,48
 mov temp11,al
 mov al,0
mov bl,10

 add al,[si+1]
 sub al,48
 mov temp2,al
 mov al,0
 mov al,temp11
 mul bl
 add al,temp2


; mov highscore_2,al
 mov temp2,al


 mov bl,10
 div bl
 


 mov temp2,0
 mov temp11,0
;///////////////////////////////////////////////////////////////////////////
mov ah,3dh
lea dx,score_file3
mov al,2  ;open a file
int 21h
mov filehandler3,ax

mov cx,0
mov dx, 0
mov ah,42h
mov al,0; 0 beginning of file, 2 end of file
int 21h

mov ah, 3FH
mov cx, 2
mov dx, offset score_str3
mov bx, Filehandler3   ;reading
int 21h

mov ah, 3Eh
mov bx, filehandler3
int 21h

Mov dx, offset score_str3
Mov ah, 9
Int 21h

mov temp,0

 mov si,offset score_str3
 mov cx,lengthof score_str3
 dec cx

 mov ax,0
 mov al,[si]
 sub al,48
 mov temp11,al
 mov al,0
mov bl,10

 add al,[si+1]
 sub al,48
 mov temp2,al
 mov al,0
 mov al,temp11
 mul bl
 add al,temp2


; mov highscore_3,al
 mov temp2,al


 mov bl,10
 div bl
 


 mov temp2,0
 mov temp11,0

;////////////////////////////////////////////////////////////////////////////
mov ah,3dh
lea dx,score_file4
mov al,2  ;open a file
int 21h
mov filehandler4,ax

mov cx,0
mov dx, 0
mov ah,42h
mov al,0; 0 beginning of file, 2 end of file
int 21h

mov ah, 3FH
mov cx, 2
mov dx, offset score_str4
mov bx, Filehandler4  ;reading
int 21h

mov ah, 3Eh
mov bx, filehandler4
int 21h

Mov dx, offset score_str4
Mov ah, 9
Int 21h

mov temp,0

 mov si,offset score_str4
 mov cx,lengthof score_str4
 dec cx

 mov ax,0
 mov al,[si]
 sub al,48
 mov temp11,al
 mov al,0
mov bl,10

 add al,[si+1]
 sub al,48
 mov temp2,al
 mov al,0
 mov al,temp11
 mul bl
 add al,temp2


; mov highscore_4,al
 mov temp2,al


 mov bl,10
 div bl
 

 
 mov temp2,0
 mov temp11,0
;////////////////////////////////////////////////////////////////////////////
mov ah,3dh
lea dx,score_file5
mov al,2  ;open a file
int 21h
mov filehandler5,ax

mov cx,0
mov dx, 0
mov ah,42h
mov al,0; 0 beginning of file, 2 end of file
int 21h

mov ah, 3FH
mov cx, 2
mov dx, offset score_str5
mov bx, Filehandler5   ;reading
int 21h

mov ah, 3Eh
mov bx, filehandler5
int 21h

Mov dx, offset score_str5
Mov ah, 9
Int 21h
mov temp,0
 mov si,offset score_str5
 mov cx,lengthof score_str5
 dec cx

 mov ax,0
 mov al,[si]
 sub al,48
 mov temp11,al
 mov al,0
mov bl,10

 add al,[si+1]
 sub al,48
 mov temp2,al
 mov al,0
 mov al,temp11
 mul bl
 add al,temp2


; mov highscore_5,al
 mov temp2,al


 mov bl,10
 div bl
 

 mov temp2,0
 mov temp11,0

;////////////////////////////////////////////////////////////////////////////
mov si,offset answer_str

mov ax,0
mov al,new_score
mov bl,10
div bl
mov rem1,ah
mov dl,al
add dl,48
mov [si],dl


mov dl,rem1
add dl,48
mov [si+1],dl

mov al,scorecounter

 .if al > highscore_1

 mov highscore_1,al

 
mov ah,3dh
lea dx,score_file1
mov al,1  ;open a file
int 21h
mov filehandler1,ax
mov cx,2
	mov bx,filehandler1
	mov dx,offset answer_str
	mov ah,40h
	int 21h
jmp final_conclusion
.endif

 .if al > highscore_2

 mov highscore_2,al

 
mov ah,3dh
lea dx,score_file2
mov al,1  ;open a file
int 21h
mov filehandler2,ax
mov cx,2
	mov bx,filehandler2
	mov dx,offset score_str3
	mov ah,40h
	int 21h
jmp final_conclusion
 .endif

.if al > highscore_3

 mov highscore_3,al

jmp final_conclusion
 .endif

.if al > highscore_4

 mov highscore_4,al

jmp final_conclusion
 .endif

.if al > highscore_5


 mov highscore_5,al
 
jmp final_conclusion

 .endif 
;jmp not_high_score

final_conclusion:


mov ah, 2
mov dh, 20    ;row
mov dl, 10 ;column
int 10h

mov ah,3dh
lea dx,namefile_1
mov al,2  ;open a file
int 21h
mov filehandler_name1,ax

mov cx,0
mov dx, 0
mov ah,42h
mov al,0; 0 beginning of file, 2 end of file
int 21h

mov ah, 3FH
mov cx, 2
mov dx, offset name_str1
mov bx, filehandler_name1   ;reading
int 21h

mov ah, 3Eh
mov bx, filehandler_name1
int 21h

Mov dx, offset name_str1
Mov ah, 9
Int 21h


 mov si,offset name_str1
 mov cx,lengthof name_str1
 dec cx

 mov ax,0
 mov al,[si]
 sub al,48
 mov temp11,al
 mov al,0
mov bl,10

 add al,[si+1]
 sub al,48
 mov temp2,al
 mov al,0
 mov al,temp11
 mul bl
 add al,temp2


; mov highscore_1,al
 mov temp2,al


 mov bl,10
 div bl
 

 stopIt:
 mov temp2,0
 mov temp11,0

;////////////////////////////////////////////////////////////////////////////

mov ah,3dh
lea dx,namefile_2
mov al,2  ;open a file
int 21h
mov filehandler_name2,ax

mov cx,0
mov dx, 0
mov ah,42h
mov al,0; 0 beginning of file, 2 end of file
int 21h

mov ah, 3FH
mov cx, 2
mov dx, offset name_str2
mov bx, filehandler_name2   ;reading
int 21h

mov ah, 3Eh
mov bx, filehandler_name2
int 21h

Mov dx, offset name_str2
Mov ah, 9
Int 21h

mov temp,0

 mov si,offset name_str2
 mov cx,lengthof name_str2
 dec cx

 mov ax,0
 mov al,[si]
 sub al,48
 mov temp11,al
 mov al,0
mov bl,10

 add al,[si+1]
 sub al,48
 mov temp2,al
 mov al,0
 mov al,temp11
 mul bl
 add al,temp2


; mov highscore_2,al
 mov temp2,al


 mov bl,10
 div bl
 


 mov temp2,0
 mov temp11,0
;///////////////////////////////////////////////////////////////////////////
mov ah,3dh
lea dx,namefile_3
mov al,2  ;open a file
int 21h
mov filehandler_name3,ax

mov cx,0
mov dx, 0
mov ah,42h
mov al,0; 0 beginning of file, 2 end of file
int 21h

mov ah, 3FH
mov cx, 2
mov dx, offset name_str3
mov bx, filehandler_name3   ;reading
int 21h

mov ah, 3Eh
mov bx, filehandler_name3
int 21h

Mov dx, offset name_str3
Mov ah, 9
Int 21h

mov temp,0

 mov si,offset name_str3
 mov cx,lengthof name_str3
 dec cx

 mov ax,0
 mov al,[si]
 sub al,48
 mov temp11,al
 mov al,0
mov bl,10

 add al,[si+1]
 sub al,48
 mov temp2,al
 mov al,0
 mov al,temp11
 mul bl
 add al,temp2


; mov highscore_3,al
 mov temp2,al


 mov bl,10
 div bl
 


 mov temp2,0
 mov temp11,0
 stopIt2:
;////////////////////////////////////////////////////////////////////////////
mov ah,3dh
lea dx,namefile_4
mov al,2  ;open a file
int 21h
mov filehandler_name4,ax

mov cx,0
mov dx, 0
mov ah,42h
mov al,0; 0 beginning of file, 2 end of file
int 21h

mov ah, 3FH
mov cx, 2
mov dx, offset name_str4
mov bx, filehandler_name4  ;reading
int 21h

mov ah, 3Eh
mov bx, filehandler_name4
int 21h

Mov dx, offset name_str4
Mov ah, 9
Int 21h

mov temp,0

 mov si,offset name_str4
 mov cx,lengthof name_str4
 dec cx

 mov ax,0
 mov al,[si]
 sub al,48
 mov temp11,al
 mov al,0
mov bl,10

 add al,[si+1]
 sub al,48
 mov temp2,al
 mov al,0
 mov al,temp11
 mul bl
 add al,temp2


; mov highscore_4,al
 mov temp2,al


 mov bl,10
 div bl
 

 
 mov temp2,0
 mov temp11,0
;////////////////////////////////////////////////////////////////////////////
mov ah,3dh
lea dx,namefile_5
mov al,2  ;open a file
int 21h
mov filehandler_name5,ax

mov cx,0
mov dx, 0
mov ah,42h
mov al,0; 0 beginning of file, 2 end of file
int 21h

mov ah, 3FH
mov cx, 2
mov dx, offset name_str5
mov bx, filehandler_name5   ;reading
int 21h

mov ah, 3Eh
mov bx, filehandler_name5
int 21h

Mov dx, offset name_str5
Mov ah, 9
Int 21h
mov temp,0
 mov si,offset name_str5
 mov cx,lengthof name_str5
 dec cx

 mov ax,0
 mov al,[si]
 sub al,48
 mov temp11,al
 mov al,0
mov bl,10

 add al,[si+1]
 sub al,48
 mov temp2,al
 mov al,0
 mov al,temp11
 mul bl
 add al,temp2


; mov highscore_5,al
 mov temp2,al


 mov bl,10
 div bl
 

 mov temp2,0
 mov temp11,0

;////////////////////////////////////////////////////////////////////////////
mov si,offset buffer

mov ax,0
mov al,new_score
mov bl,10
div bl
mov rem1,ah
mov dl,al
add dl,48
mov [si],dl


mov dl,rem1
add dl,48
mov [si+1],dl

mov al,new_score

 .if al > highscore_1

 mov highscore_1,al

 
mov ah,3dh
lea dx,namefile_1
mov al,1  ;open a file
int 21h
mov filehandler_name1,ax
mov cx,2
	mov bx,filehandler_name1
	mov dx,offset answer_str
	mov ah,40h
	int 21h
jmp final_conclusion1
.endif

 .if al > highscore_2

 mov highscore_2,al

 
mov ah,3dh
lea dx,namefile_2
mov al,1  ;open a file
int 21h
mov filehandler_name2,ax
mov cx,2
	mov bx,filehandler_name2
	mov dx,offset name_str3
	mov ah,40h
	int 21h
jmp final_conclusion1
 .endif

.if al > highscore_3

 mov highscore_3,al

jmp final_conclusion1
 .endif

.if al > highscore_4

 mov highscore_4,al

jmp final_conclusion1
 .endif

.if al > highscore_5


 mov highscore_5,al
 
jmp final_conclusion1

 .endif 
;jmp not_high_score

final_conclusion1:



mov AH, 0Ch		;Clear Buffer
	int 21h
	MOV AH,02H
 loppypart4:

	mov ah, 00h
	int 16h
	mov bx,ax
	cmp bl,'n'
	je nii
	cmp bl,0Dh
	je nii
	jz loppypart4

	nii:
ret
highscorescreen endp
comment @
pause_screen proc


call boarder


MOV BX,0
 MOV DH, 12;Row Number
 MOV DL, 6;Column Number
INT 10H

	lea dx,strr_resume
	mov ah,09h
	int 21h
	call delay
	
mov AH, 0Ch		;Clear Buffer
	int 21h
	MOV AH,02H
	 loppypart3:

	mov ah, 00h
	int 16h
	mov bx,ax
	cmp bl,'n'
	je exit
	cmp bl,0Dh
	je ni
	jz loppypart3




ni:
ret
pause_screen endp
@

;//////////////////////

exit:
mov ah, 4ch
int 21h
end


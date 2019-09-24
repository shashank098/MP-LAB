.model small
.data
msg1 DB 0AH,0DH, "Enter Alpha character $"
res DB 02 DUP(0)

.code
        mov ax,@data
        mov ds,ax
        lea dx,msg1
        call Disp
        mov ah,01h
        INT 21h
        mov bl,al
        mov cl,04h
        shr al,cl
        cmp cl,0ah
        JB digit
        add al,07h

digit: add al,30h
        mov res,al
        and bl,0Fh
        cmp bl,0Ah
        JC digit1
        add bl,07h

digit1: add bl,30h
        mov res+1,bl
        mov ah,00h
        mov al,03h
        INT 10h

        mov bh,00h
        mov ah,02h
        mov dh,0ch
        mov dl,28h
        INT 10h
        mov res+2,'$'
        lea dx,res

        call Disp
        mov ah,4ch
        INT 21h

Disp    Proc near
        mov ah,09h
        INT 21h
        RET

    Disp ENDP
END

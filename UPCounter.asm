.model small
.data
msg1 db 0dh, 0ah, "1 to 100$"

.code
mov ax,@data
mov ds,ax
lea dx,msg1
mov ah,09h
int 21h
mov cl,00h
mov ah,00h
mov al,03h
int 10h

back: mov bh,00h
      mov dh,00h
      mov dl,00h
      mov ah,02
      int 10h

      mov al,cl
      add al,00h
      aam
      add ax,3030h

      mov ch,al
      mov dl,ah
      mov ah,02h
      int 21h

      mov dl,ch
      mov ah,02h
      int 21h

      call delay
      inc cl
      xor ax,ax
      cmp cl,100d
      jne back
      je last
delay proc near
      push ax
     push bx
      push cx
      mov ax,0fffh
again2: mov cx,0fffh
again1: mov bx,0fffh
again:  nop
        dec bx
        jnz again
        dec cx
        jnz again1
        dec ax
        jnz again2
        pop cx
        pop bx
        pop ax
        ret
delay endp
last: mov ah,4ch
      int 21h
end

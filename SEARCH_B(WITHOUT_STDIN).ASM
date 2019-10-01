; PROGRAM :: ASSEMBLY LANGUAGE PROGRAM TO SEARCH A KEY ELEMENT IN A LIST
;            OF 'n' NUMBER USING THE BINARY SEARCH ALGORITHM

.MODEL SMALL                   ; small is a memory model

                            ; MACRO TO DISPLAY THE MESSAGE....



DISPLAY MACRO MSG               
        LEA DX,MSG          ;load effective address in  DX
        MOV AH,09H           ; 09H is a function under INT 21H to display a set of words
        INT 21H;
ENDM


.DATA

LIST DB 0H, 3H, 4H, 5H,7H, 8H
NUMBER EQU ($-LIST)                     ;#define NUMBER 6

;NUMBER DB 6

KEY DB 9H
MSG1 DB 0DH, 0AH, "ELEMENT FOUND IN LIST ... $"
MSG2 DB 0DH, 0AH, "SEARCH FAILED !! ELEMENT NOT FOUND IN LIST.. $"


.CODE
START : MOV AX, @DATA
        MOV DS, AX                  

        MOV CH, NUMBER-1                ;HIGH VALUE...
        MOV CL, 00H                     ;LOW VALUE
AGAIN : MOV SI, OFFSET LIST
        XOR AX, AX
        CMP CL, CH
        JE NEXT                         ;  jump if CL=CH
        JNC FAILED                      ;  jump if not carry 
NEXT:   MOV AL, CL
        ADD AL, CH
        SHR AL, 01H             ; DIVIDE BY 2
        MOV BL, AL
        XOR AH, AH              ;CLEAR AH
        MOV BP, AX
        MOV AL, DS:[BP][SI]
        CMP AL, KEY                       ;COMPARE KEY AND A[i]
        JE SUCCESS                        ;IF EQUAL, DISPLAY SUCCESS MESSAGE
        JC INCLOW                           ; jump if carry 
        MOV CH, BL                        ;IF KEY&gT;A[I] SHIFT HIGH
        DEC CH                              ; decrement CH by 1
        JMP AGAIN

INCLOW: MOV CL, BL                        ;IF KEY&lT;A[i] SHIFT LOW
        INC CL                              ; increment CL by 1
        JMP AGAIN

SUCCESS:mov al,key
        add al,30h

        mov dl,al
        mov ah,02h
        int 21h

        DISPLAY MSG1
        JMP FINAL
FAILED: mov al,key
        add al,30h
        mov dl,al
        mov ah,02h
        int 21h

        DISPLAY MSG2            ; JOB OVER TERMINATE....
FINAL : mov ah,01h
        int 21h
        
        MOV AH,4CH              ; exit function   
        INT 21H
END START

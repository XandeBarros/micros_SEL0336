SW0     EQU P2.0               ; Define a constante SW0 como o pino P2.0 (botão 0)
SW1     EQU P2.1               ; Define a constante SW1 como o pino P2.1 (botão 1)
DISP    EQU P1.0               ; Define a constante DISP como o pino P1.0 (display de 7 segmentos)

ORG     0000h                  ; Define o início do programa

JMP     MAIN                   ; Salta para o rótulo MAIN (início do programa)

MAIN:
    MOV     DISP, #0FFH        ; Desliga o display
    MOV     DPTR, #DISPLAY     ; Inicializa o registrador DPTR com o endereço do array DISPLAY
    CALL    WAIT_SW            ;

WAIT_SW:
    JNB     SW0, INTER_SW0     ;
    JNB     SW1, INTER_SW1     ;
    SJMP    WAIT_SW            ;
    RET                        ;

CHECK_UPDATE:
    JNB     SW0, SET_250MS
    JNB     SW1, SET_1000MS    ;
    RET

SET_250MS:
    MOV     7FH, #5            ; Se SW0 estiver selecionada, carrega o valor 5
    RET 

SET_1000MS:
    MOV     7FH, #20            ; Se SW0 estiver selecionada, carrega o valor 5
    RET 

VERIFY_SW0:
    JB      SW0, INTER_SW0     ;
    CALL    SET_250MS          ; Se SW0 estiver selecionada, carrega o valor 5
    RET                        ;

VERIFY_SW1:
    JB      SW1, INTER_SW1     ;
    CALL    SET_1000MS         ; Se SW1 estiver selecionado, carrega o valor 20
    RET                        ;

INTER_SW0:
    CALL    SET_250MS          ;
    CALL    LOOP               ;
    CALL    WAIT_SW            ;

INTER_SW1:
    CALL    SET_1000MS         ;
    CALL    LOOP               ;
    CALL    WAIT_SW            ;

LOOP:
    MOV     A, R1              ;
    MOVC    A, @A+DPTR         ;
    MOV     DISP, A            ;
    CALL    CHECK_UPDATE       ;
    CALL    DELAY              ;
    INC     R1                 ;
    CJNE    R1, #10, LOOP      ;
    MOV     R1, #0             ;
    RET

DELAY:
    MOV     R4, 7FH            ; Inicializa R4 com o valor 7FH
DELAY_AGAIN:
    MOV     R3, #100           ; Inicializa R3 com o valor 100
HERE:
    MOV     R2, #250           ; Inicializa R2 com o valor 250
    DJNZ    R2, $              ; Decrementa R2 e salta de volta se não for zero
    DJNZ    R3, HERE           ; Decrementa R3 e salta de volta se não for zero
    DJNZ    R4, DELAY_AGAIN    ; Decrementa R4 e salta de volta se não for zero
    RET                        ; Retorna ao ponto de chamada

; Definição do array DISPLAY com os valores para cada dígito de 0 a 9
DISPLAY:
    db     C0h                 ; 0
    db     F9h                 ; 1
    db     A4h                 ; 2
    db     B0h                 ; 3
    db     99h                 ; 4
    db     92h                 ; 5
    db     82h                 ; 6
    db     F8h                 ; 7
    db     80h                 ; 8
    db     90h                 ; 9

FINAL:                         ; Fim do código

END                            ; Endereço de término do código

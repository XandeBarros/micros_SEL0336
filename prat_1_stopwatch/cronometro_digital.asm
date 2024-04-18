SW0     EQU P2.0               ; Define a constante SW0 como o pino P2.0 (botão 0)
SW1     EQU P2.1               ; Define a constante SW1 como o pino P2.1 (botão 1)
DISP    EQU P1.0               ; Define a constante DISP como o pino P1.0 (display de 7 segmentos)

ORG     0000h                  ; Define o início do programa

JMP     MAIN                   ; Salta para o rótulo MAIN (início do programa)

MAIN:
    MOV     DISP, #0FFH        ; Desliga o display
    MOV     DPTR, #DISPLAY     ; Inicializa o registrador DPTR com o endereço do array DISPLAY

WAIT_SW0:
    JB      SW0, WAIT_SW1      ; Verifica se o botão SW0 está pressionado, se não, salta para WAIT_SW1
    MOV     7FH, #5            ; Se SW0 estiver selecionada, carrega o valor 5
    JMP     INTER_SW0          ; Salta para a sub-rotina INTER_SW0

WAIT_SW1:
    JB      SW1, WAIT_SW0      ; Verifica se o botão SW1 está pressionado, se não, salta para WAIT_SW0
    MOV     7FH, #20           ; Se SW1 estiver selecionado, carrega o valor 20
    JMP     INTER_SW1          ; Salta para a sub-rotina INTER_SW1

VERIFY_SW0:
    JB      SW0, INTER_SW0     ;
    MOV     7FH, #5            ; Se SW0 estiver selecionada, carrega o valor 5
    RET                        ;

VERIFY_SW1:
    JB      SW1, INTER_SW1     ;
    MOV     7FH, #20           ; Se SW1 estiver selecionado, carrega o valor 20
    RET                        ;

INTER_SW0:
    MOV     A, R1              ; Move o valor de R1 para o acumulador A
    MOVC    A, @A+DPTR         ; Move o próximo valor do array DISPLAY para A
    MOV     DISP, A            ; Move o valor de A para o pino DISP
    CALL    VERIFY_SW1         ; Se SW1 estiver pressionado, volta a interrupção SW1
    CALL    DELAY              ; Chama a sub-rotina de delay
    INC     R1                 ; Incrementa o valor de R1
    CJNE    R1, #10, INTER_SW0 ; Compara R1 com 10, se for diferente, salta para INTER_SW0
    MOV     R1, #0             ; Se R1 for igual a 10, reinicia R1
    SJMP    WAIT_SW0           ; Salta para WAIT_SW0 para aguardar o próximo pressionamento de SW0

INTER_SW1:
    MOV     A, R1              ; Move o valor de R1 para o acumulador A
    MOVC    A, @A+DPTR         ; Move o próximo valor do array DISPLAY para A
    MOV     DISP, A            ; Move o valor de A para o pino DISP
    CALL    VERIFY_SW0         ; Se SW0 estiver pressionado, volta a interrupção SW0
    CALL    DELAY              ; Chama a sub-rotina de delay
    INC     R1                 ; Incrementa o valor de R1
    CJNE    R1, #10, INTER_SW1 ; Compara R1 com 10, se for diferente, salta para INTER_SW1
    MOV     R1, #0             ; Se R1 for igual a 10, reinicia R1
    SJMP    WAIT_SW1           ; Salta para WAIT_SW1 para aguardar o próximo pressionamento de SW1

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

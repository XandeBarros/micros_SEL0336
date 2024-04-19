; Definição dos pinos dos switches e do display de 7 segmentos
SW0     EQU P2.0               ; Define a constante SW0 como o pino P2.0 (botão 0)
SW1     EQU P2.1               ; Define a constante SW1 como o pino P2.1 (botão 1)
DISP    EQU P1.0               ; Define a constante DISP como o pino P1.0 (display de 7 segmentos)

ORG     0000h                  ; Define o início do programa

JMP     MAIN                   ; Salta para o rótulo MAIN (início do programa)

MAIN:
    MOV     DISP, #0FFH        ; Desliga o display
    MOV     DPTR, #DISPLAY     ; Inicializa o registrador DPTR com o endereço do array DISPLAY
    CALL    WAIT_SW            ; Chama a sub-rotina WAIT_SW para aguardar um botão ser pressionado

WAIT_SW:                       ; Sub-rotina para aguardar um botão ser pressionado
    JNB     SW0, INTER_SW0     ; Se SW0 estiver pressionado, salta para INTER_SW0
    JNB     SW1, INTER_SW1     ; Se SW1 estiver pressionado, salta para INTER_SW1
    SJMP    WAIT_SW            ; Se nenhum botão estiver pressionado, continua aguardando

CHECK_UPDATE:                  ; Sub-rotina para verificar se um botão foi pressionado durante o loop e redefinir o tempo de atualização
    JNB     SW0, SET_250MS     ; Se SW0 estiver pressionado, configura o tempo de atualização para 250ms
    JNB     SW1, SET_1000MS    ; Se SW1 estiver pressionado, configura o tempo de atualização para 1000ms
    CALL    FINAL              ; Condição de parada do sistema

SET_250MS:                     ; Sub-rotina para definir o tempo de atualização como 250ms
    MOV     7FH, #5            ; Configura o valor na posição de memória 7FH para 5 
    RET                        ; Retorna ao ponto de chamada

SET_1000MS:                    ; Sub-rotina para definir o tempo de atualização como 1s
    MOV     7FH, #20           ; Configura o valor na posição de memória 7FH para 20 
    RET                        ; Retorna ao ponto de chamada

INTER_SW0:                     ; Interrupção para o caso de SW0 ser pressionado
    CALL    SET_250MS          ; Configura o tempo de atualização para 250ms
    CALL    LOOP               ; Chama a sub-rotina LOOP para exibir os valores do array DISPLAY
    CALL    WAIT_SW            ; Aguarda a próxima pressão de um botão

INTER_SW1:                     ; Interrupção para o caso de SW1 ser pressionado
    CALL    SET_1000MS         ; Configura o tempo de atualização para 1000ms
    CALL    LOOP               ; Chama a sub-rotina LOOP para exibir os valores do array DISPLAY
    CALL    WAIT_SW            ; Aguarda a próxima pressão de um botão

LOOP:                          ; Sub-rotina para exibir os valores do array DISPLAY
    MOV     A, R1              ; Move o valor de R1 para o acumulador A
    MOVC    A, @A+DPTR         ; Move o próximo valor do array DISPLAY para A
    MOV     DISP, A            ; Exibe o valor de A no display
    CALL    CHECK_UPDATE       ; Chama a sub-rotina para verificar e atualizar o tempo de atualização
    CALL    DELAY              ; Chama a sub-rotina DELAY para criar um atraso
    INC     R1                 ; Incrementa o valor de R1
    CJNE    R1, #10, LOOP      ; Se R1 não for igual a 10, salta de volta para LOOP
    MOV     R1, #0             ; Reinicia o contador R1
    RET                        ; Retorna ao ponto de chamada

DELAY:                         ; Sub-rotina para criar um atraso
    MOV     R4, 7FH            ; Inicializa o registrador R4 com o valor 7FH
DELAY_AGAIN:
    MOV     R3, #100           ; Inicializa o registrador R3 com o valor 100
HERE:
    MOV     R2, #250           ; Inicializa o registrador R2 com o valor 250
    DJNZ    R2, $              ; Decrementa R2 e salta de volta se não for zero
    DJNZ    R3, HERE           ; Decrementa R3 e salta de volta se não for zero
    DJNZ    R4, DELAY_AGAIN    ; Decrementa R4 e salta de volta se não for zero
    RET                        ; Retorna ao ponto de chamada

DISPLAY:                       ; Define os valores do Display de 7 segmentos
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

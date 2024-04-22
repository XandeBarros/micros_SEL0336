## Resumo das Rotinas

| Rotina          | Descrição                                                                                      |
|-----------------|------------------------------------------------------------------------------------------------|
| MAIN            | Inicializa o display e chama a rotina WAIT_SW.                                                  |
| WAIT_SW         | Aguarda os botões serem pressionados.                                                          |
| CHECK_UPDATE    | Verifica se o botão SW0 ou SW1 foi pressionado e atualiza o valor de 7FH de acordo.            |
| SET_250MS       | Define o valor de 7FH como 5 para um atraso de 250 ms.                                          |
| SET_1000MS      | Define o valor de 7FH como 20 para um atraso de 1000 ms.                                        |
| VERIFY_SW0      | Verifica se o botão SW0 foi pressionado e atualiza o valor de 7FH.                              |
| VERIFY_SW1      | Verifica se o botão SW1 foi pressionado e atualiza o valor de 7FH.                              |
| INTER_SW0       | Executa a rotina SET_250MS, realiza um loop e espera os botões serem pressionados novamente.   |
| INTER_SW1       | Executa a rotina SET_1000MS, realiza um loop e espera os botões serem pressionados novamente.  |
| LOOP            | Move o valor de DPTR para o registrador A, atualiza o display, chama a rotina CHECK_UPDATE, executa um atraso e incrementa R1. |
| DELAY           | Realiza um atraso usando contadores.                                                            |
| DISPLAY         | Define os valores para cada dígito de 0 a 9 para o display de sete segmentos.                   |
| FINAL           | Fim do código.                                                                                |

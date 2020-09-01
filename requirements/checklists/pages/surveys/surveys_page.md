# Surveys Page

> ## Regras
1. Chamar o método de Listar Enquetes ao carregar a tela
2. Exibir loading ao receber evento de isLoading do presenter como true
3. Esconder loading ao receber evento de isLoading do presenter como false ou null
4. Exibir mensagem de erro e esconder a lista ao receber evento de surveysData com erro
5. Esconder mensagem de erro e exibir a lista ao receber evento de surveysData com dados
6. Mostrar a data e pergunta da enquete baseado no modelo
7. Mostrar em vermelho as enquetes não respondidas e em verde as respondidas pelo usuário
8. Ir para a tela de resultado da enquete ao clicar em alguma enquete
# Local Load Surveys

> ## Caso de sucesso
1. Sistema solicita os dados das enquetes do Cache
2. Sistema valida os dados recebidos do Cache
3. Sistema entrega os dados das enquetes

> ## Exceção - Cache vazio
1. Sistema retorna uma lista vazia

> ## Exceção - Dados inválidos no cache
1. Sistema limpa os dados do cache
2. Sistema retorna uma lista vazia
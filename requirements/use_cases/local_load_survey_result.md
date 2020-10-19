# Local Load Survey Result

> ## Caso de sucesso
1. ✅ Sistema solicita os dados do resultado de uma enquete do Cache
2. ✅ Sistema entrega os dados do resultado da enquete

> ## Exceção - Erro ao carregar dados do Cache
1. ✅ Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Cache vazio
1. ✅ Sistema retorna uma mensagem de erro inesperado

---

# Local Validate Survey Result

> ## Caso de sucesso
1. ✅ Sistema solicita os dados do resultado de uma enquete do Cache
2. ✅ Sistema valida os dados recebidos do Cache

> ## Exceção - Erro ao carregar dados do Cache
1. ✅ Sistema limpa os dados do cache

> ## Exceção - Dados inválidos no cache
1. ✅ Sistema limpa os dados do cache

---

# Local Save Survey Result

> ## Caso de sucesso
1. ✅ Sistema grava os novos dados no Cache

> ## Exceção - Erro ao gravar dados no Cache
1. ✅ Sistema retorna uma mensagem de erro inesperado
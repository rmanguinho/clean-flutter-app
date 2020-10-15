# Authorize HTTP Client Decorator

> ## Sucesso
1. ✅ Obter o token de acesso do Cache
2. ✅ Executar o request do HttpClient que está sendo decorado com um novo header (x-access-token)
3. ✅ Retornar a mesma resposta do HttpClient que está sendo decorado

> ## Exceção - Falha ao obter dados do cache
1. ✅ Retornar erro HTTP Forbidden - 403
2. ✅ Apagar token de acesso do Cache

> ## Exceção - HttpClient retornou alguma exceção (menos Forbidden)
1. ✅ Retornar a mesma exceção recebida

> ## Exceção - HttpClient retornou erro Forbidden
1. ✅ Retornar erro HTTP Forbidden - 403
2. ✅ Apagar token de acesso do Cache
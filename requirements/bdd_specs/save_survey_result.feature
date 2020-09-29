Feature: Responder uma Enquete
Como um cliente
Quero poder responder uma enquete
Para dar minha contribuição e opinião para a comunidade

Cenário: Com internet
Dado que o cliente tem conexão com a internet
Quando solicitar para responder uma enquete
Então o sistema deve gravar sua resposta
E atualizar o cache com as novas estatísticas
E mostrar para o usuário o resultado atualizado

Cenário: Sem internet
Dado que o cliente não tem conexão com a internet
Quando solicitar para responder uma enquete
Então o sistema deve exibir uma mensagem de erro
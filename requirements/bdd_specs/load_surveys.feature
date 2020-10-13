Feature: Listar Enquetes
Como um cliente
Quero poder ver todas as enquetes
Para poder saber o resultado e poder dar minha opinião

Cenário: Com internet
Dado que o cliente tem conexão com a internet
Quando solicitar para ver as enquetes
Então o sistema deve exibir as enquetes
E armazenar os dados atualizados no cache

Cenário: Sem internet
Dado que o cliente não tem conexão com a internet
Quando solicitar para ver as enquetes
Então o sistema deve exibir as enquetes que foram gravadas no cache no último acesso
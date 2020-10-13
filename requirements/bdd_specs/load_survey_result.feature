Feature: Resultado de uma Enquete
Como um cliente
Quero poder ver o resultado de uma enquete
Para saber a opinião da comunidade a respeito de cada tópico

Cenário: Com internet
Dado que o cliente tem conexão com a internet
Quando solicitar para ver o resultado de uma enquete
Então o sistema deve exibir o resultado da enquete
E armazenar os dados atualizados no cache

Cenário: Sem internet
Dado que o cliente não tem conexão com a internet
Quando solicitar para ver o resultado de uma enquete
Então o sistema deve exibir o resultado da enquete que foi gravado no cache no último acesso
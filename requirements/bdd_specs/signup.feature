Feature: Criar Conta
Como um cliente
Quero poder criar uma conta e me manter logado
Para que eu possa ver e responder enquetes de forma rápida

Cenário: Dados Válidos
Dado que o cliente informou dados válidos
Quando solicitar para criar a conta
Então o sistema deve enviar o usuário para a tela de pesquisas
E manter o usuário conectado

Cenário: Dados Inválidos
Dado que o cliente informou dados inválidos
Quando solicitar para criar a conta
Então o sistema deve retornar uma mensagem de erro
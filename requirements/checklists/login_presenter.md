# Login Presenter

> ## Regras
1. ✅ Validar email com o Validation
2. ✅ Notificar o emailErrorStream com o resultado do Validation
3. ✅ Notificar o isFormValidStream após validar o email
4. ✅ Validar senha com o Validation
5. ✅ Notificar o passwordErrorStream com o resultado do Validation
6. ✅ Notificar o isFormValidStream após validar a senha
7. ✅ Para o formulário estar válido todos os Streams de erro precisam estar null e todos os campos obrigatórios não podem estar vazios
8. Chamar o Authentication com email e senha corretos
9. Notificar o isLoadingStream como true antes de chamar o Authentication
10. Notificar o isLoadingStream como false no fim do Authentication
11. Notificar o mainErrorStream caso o Authentication retorne um DomainError
12. ⛔️ Gravar o Account no cache em caso de sucesso
13. ⛔️ Levar o usuário pra tela de Enquetes em caso de sucesso
14. Fechar todos os Streams no dispose
15. ✅ Não notificar o emailErrorStream se o valor for igual ao último
16. ✅ Não notificar o isFormValidStream se o valor for igual ao último
17. ✅ Não notificar o passwordErrorStream se o valor for igual ao último
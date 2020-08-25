# Login Presenter

> ## Regras
1. ✅ Chamar Validation ao alterar o email
2. ✅ Notificar o emailErrorStream com o mesmo erro do Validation, caso retorne erro
3. ✅ Notificar o emailErrorStream com null, caso o Validation não retorne erro
4. ✅ Não notificar o emailErrorStream se o valor for igual ao último
5. ✅ Notificar o isFormValidStream após alterar o email
6. ✅ Chamar Validation ao alterar a senha
7. ✅ Notificar o passwordErrorStream com o mesmo erro do Validation, caso retorne erro
8. ✅ Notificar o passwordErrorStream com null, caso o Validation não retorne erro
9. ✅ Não notificar o passwordErrorStream se o valor for igual ao último
10. ✅ Notificar o isFormValidStream após alterar a senha
11. ✅ Para o formulário estar válido todos os Streams de erro precisam estar null e todos os campos obrigatórios não podem estar vazios
12. ✅ Não notificar o isFormValidStream se o valor for igual ao último
13. ✅ Chamar o Authentication com email e senha corretos
14. ✅ Notificar o isLoadingStream como true antes de chamar o Authentication
15. ✅ Notificar o isLoadingStream como false no fim do Authentication
16. ✅ Notificar o mainErrorStream caso o Authentication retorne erro
17. ✅ Fechar todos os Streams no dispose
18. ✅ Gravar o Account no cache em caso de sucesso
19. ✅ Notificar o mainErrorStream caso o SaveCurrentAccount retorne erro
20. ✅ Levar o usuário pra tela de Enquetes em caso de sucesso
21. ✅ Levar o usuário pra tela de Criar Conta ao clicar no link de criar conta
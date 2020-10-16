# Surveys Presenter

> ## Regras
1. ✅ Chamar LoadSurveys no método loadData
2. ✅ Notificar o isLoadingStream como true antes de chamar o LoadSurveys
3. ✅ Notificar o isLoadingStream como false no fim do LoadSurveys
4. ✅ Notificar o surveysStream com erro caso o LoadSurveys retorne erro
5. ✅ Notificar o surveysStream com uma lista de Surveys caso o LoadSurveys retorne sucesso
6. ✅ Levar o usuário pra tela de Resultado da Enquete ao clicar em alguma enquete
7. ✅ Notificar o sessionExpiredStream como true caso o LoadSurveys retorne erro accessDenied
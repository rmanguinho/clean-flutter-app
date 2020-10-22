# Survey Result Presenter

> ## Regras
1. ✅ Chamar LoadSurveyResult no método loadData
2. ✅ Notificar o isLoadingStream como true antes de chamar o LoadSurveyResult
3. ✅ Notificar o isLoadingStream como false no fim do LoadSurveyResult
4. ✅ Notificar o surveyResultStream com erro caso o LoadSurveyResult retorne erro
5. ✅ Notificar o surveyResultStream com um SurveyResult caso o LoadSurveyResult retorne sucesso
6. ✅ Notificar o sessionExpiredStream como true caso o LoadSurveys retorne erro accessDenied
7. ✅ Chamar SaveSurveyResult no método save
8. ✅ Notificar o isLoadingStream como true antes de chamar o SaveSurveyResult
9. ✅ Notificar o isLoadingStream como false no fim do SaveSurveyResult
10. ✅ Notificar o surveyResultStream com erro caso o SaveSurveyResult retorne erro
11. ✅ Notificar o surveyResultStream com um SurveyResult caso o SaveSurveyResult retorne sucesso
12. ✅ Notificar o sessionExpiredStream como true caso o SaveSurveyResult retorne erro accessDenied
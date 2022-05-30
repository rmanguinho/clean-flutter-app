import 'dart:async';

import 'package:fordev/ui/ui.dart';
import 'package:mocktail/mocktail.dart';

class SurveyResultPresenterSpy extends Mock implements SurveyResultPresenter {
  final StreamController<SurveyResultViewModel?> surveyResultController =
      StreamController<SurveyResultViewModel?>();
  final StreamController<bool> isSessionExpiredController =
      StreamController<bool>();
  final StreamController<bool> isLoadingController = StreamController<bool>();

  SurveyResultPresenterSpy() {
    when(() => loadData()).thenAnswer((_) async => _);
    when(() => save(answer: any(named: 'answer'))).thenAnswer((_) async => _);
    when(() => surveyResultStream)
        .thenAnswer((_) => surveyResultController.stream);
    when(() => isSessionExpiredStream)
        .thenAnswer((_) => isSessionExpiredController.stream);
    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);
  }

  void emitSurveyResult(SurveyResultViewModel? data) =>
      surveyResultController.add(data);
  void emitSurveyResultError(String error) =>
      surveyResultController.addError(error);
  void emitLoading([bool show = true]) => isLoadingController.add(show);
  void emitSessionExpired([bool show = true]) =>
      isSessionExpiredController.add(show);

  void dispose() {
    surveyResultController.close();
    isSessionExpiredController.close();
    isLoadingController.close();
  }
}

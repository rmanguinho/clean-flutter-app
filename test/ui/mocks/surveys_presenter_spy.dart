import 'dart:async';

import 'package:fordev/ui/ui.dart';
import 'package:mocktail/mocktail.dart';

class SurveysPresenterSpy extends Mock implements SurveysPresenter {
  final StreamController<List<SurveyViewModel>> surveysController =
      StreamController<List<SurveyViewModel>>();
  final StreamController<bool> isSessionExpiredController =
      StreamController<bool>();
  final StreamController<bool> isLoadingController = StreamController<bool>();
  final StreamController<String?> navigateToController =
      StreamController<String?>();

  SurveysPresenterSpy() {
    when(() => loadData()).thenAnswer((_) async => _);
    when(() => surveysStream).thenAnswer((_) => surveysController.stream);
    when(() => isSessionExpiredStream)
        .thenAnswer((_) => isSessionExpiredController.stream);
    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    when(() => navigateToStream).thenAnswer((_) => navigateToController.stream);
  }

  void emitSurveys(List<SurveyViewModel> data) => surveysController.add(data);
  void emitSurveysError(String error) => surveysController.addError(error);
  void emitLoading([bool show = true]) => isLoadingController.add(show);
  void emitSessionExpired([bool show = true]) =>
      isSessionExpiredController.add(show);
  void emitNavigateTo(String route) => navigateToController.add(route);

  void dispose() {
    surveysController.close();
    isSessionExpiredController.close();
    isLoadingController.close();
    navigateToController.close();
  }
}

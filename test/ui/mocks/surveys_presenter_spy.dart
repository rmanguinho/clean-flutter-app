import 'package:fordev/ui/pages/pages.dart';

import 'dart:async';
import 'package:mocktail/mocktail.dart';

class SurveysPresenterSpy extends Mock implements SurveysPresenter {
  final surveysController = StreamController<List<SurveyViewModel>>();
  final isSessionExpiredController = StreamController<bool>();
  final isLoadingController = StreamController<bool>();
  final navigateToController = StreamController<String?>();

  SurveysPresenterSpy() {
    when(() => this.loadData()).thenAnswer((_) async => _);
    when(() => this.surveysStream).thenAnswer((_) => surveysController.stream);
    when(() => this.isSessionExpiredStream).thenAnswer((_) => isSessionExpiredController.stream);
    when(() => this.isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    when(() => this.navigateToStream).thenAnswer((_) => navigateToController.stream);
  }

  void emitSurveys(List<SurveyViewModel> data) => surveysController.add(data);
  void emitSurveysError(String error) => surveysController.addError(error);
  void emitLoading([bool show = true]) => isLoadingController.add(show);
  void emitSessionExpired([bool show = true]) => isSessionExpiredController.add(show);
  void emitNavigateTo(String route) => navigateToController.add(route);

  void dispose() {
    surveysController.close();
    isSessionExpiredController.close();
    isLoadingController.close();
    navigateToController.close();
  }
}
import 'package:fordev/data/usecases/usecases.dart';
import 'package:fordev/domain/entities/entities.dart';
import 'package:fordev/domain/helpers/helpers.dart';

import 'package:mocktail/mocktail.dart';

class RemoteLoadSurveysSpy extends Mock implements RemoteLoadSurveys {
  When mockLoadCall() => when(() => this.load());
  void mockLoad(List<SurveyEntity> surveys) => this.mockLoadCall().thenAnswer((_) async => surveys);
  void mockLoadError(DomainError error) => this.mockLoadCall().thenThrow(error);
}
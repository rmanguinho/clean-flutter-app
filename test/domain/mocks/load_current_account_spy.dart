import 'package:fordev/domain/domain.dart';

import 'package:mocktail/mocktail.dart';

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {
  When mockLoadCall() => when(() => load());
  void mockLoad({required AccountEntity account}) =>
      mockLoadCall().thenAnswer((_) async => account);
  void mockLoadError() => mockLoadCall().thenThrow(Exception());
}

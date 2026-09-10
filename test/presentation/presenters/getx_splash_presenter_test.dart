import 'package:fordev/presentation/presentation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../domain/mocks/mocks.dart';

void main() {
  late GetxSplashPresenter sut;
  late LoadCurrentAccountSpy loadCurrentAccount;

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    loadCurrentAccount.mockLoad(account: EntityFactory.makeAccount());
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
  });

  setUpAll(() {
    registerFallbackValue(EntityFactory.makeAccount());
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount(durationInSeconds: 0);

    verify(() => loadCurrentAccount.load()).called(1);
  });

  test('Should go to surveys page on success', () async {
    sut.navigateToStream
        .listen(expectAsync1((String? page) => expect(page, '/surveys')));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on error', () async {
    loadCurrentAccount.mockLoadError();

    sut.navigateToStream
        .listen(expectAsync1((String? page) => expect(page, '/login')));

    await sut.checkAccount(durationInSeconds: 0);
  });
}

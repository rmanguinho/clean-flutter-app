import 'package:faker/faker.dart';
import 'package:fordev/data/data.dart';
import 'package:fordev/domain/domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late LocalSaveCurrentAccount sut;
  late SecureCacheStorageSpy secureCacheStorage;
  late AccountEntity account;

  setUp(() {
    secureCacheStorage = SecureCacheStorageSpy();
    account = AccountEntity(token: faker.guid.guid());
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage: secureCacheStorage);
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.save(account);

    verify(() => secureCacheStorage.save(key: 'token', value: account.token));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws',
      () async {
    secureCacheStorage.mockSaveError();

    final Future<void> future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}

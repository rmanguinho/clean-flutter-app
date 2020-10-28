import 'package:faker/faker.dart';

import 'package:ForDev/domain/usecases/usecases.dart';

class FakeParamsFactory {
  static AddAccountParams makeAddAccount() => AddAccountParams(
    name: faker.person.name(),
    email: faker.internet.email(),
    password: faker.internet.password(),
    passwordConfirmation: faker.internet.password()
  );

  static AuthenticationParams makeAuthentication() => AuthenticationParams(
    email: faker.internet.email(),
    secret: faker.internet.password()
  );
}
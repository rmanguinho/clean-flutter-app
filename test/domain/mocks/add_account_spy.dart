import 'package:fordev/domain/entities/entities.dart';
import 'package:fordev/domain/helpers/helpers.dart';
import 'package:fordev/domain/usecases/usecases.dart';

import 'package:mocktail/mocktail.dart';

class AddAccountSpy extends Mock implements AddAccount {
  When mockAddAccountCall() => when(() => this.add(any()));
  void mockAddAccount(AccountEntity data) => this.mockAddAccountCall().thenAnswer((_) async => data);
  void mockAddAccountError(DomainError error) => this.mockAddAccountCall().thenThrow(error);
}
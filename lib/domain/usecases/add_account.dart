import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

abstract class AddAccount {
  Future<AccountEntity> add(AddAccountParams params);
}

class AddAccountParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  @override
  List<String> get props =>
      <String>[name, email, password, passwordConfirmation];

  const AddAccountParams({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });
}

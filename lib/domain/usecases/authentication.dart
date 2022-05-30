import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams extends Equatable {
  final String email;
  final String secret;

  @override
  List<String> get props => <String>[email, secret];

  const AuthenticationParams({required this.email, required this.secret});
}

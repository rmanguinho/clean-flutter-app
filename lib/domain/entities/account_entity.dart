import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AccountEntity extends Equatable {
  final String token;

  List get props => [token];

  AccountEntity({@required this.token});
}
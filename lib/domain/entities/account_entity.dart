import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final String token;

  @override
  List<String> get props => <String>[token];

  const AccountEntity({required this.token});
}

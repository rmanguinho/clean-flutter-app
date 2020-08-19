import 'package:meta/meta.dart';

import '../../../domain/usecases/usecases.dart';

import '../../http/http.dart';

class RemoteAddAccount {
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({
    @required this.httpClient,
    @required this.url
  });

  Future<void> add(AddAccountParams params) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();
    await httpClient.request(url: url, method: 'post', body: body);
  }
}

class RemoteAddAccountParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RemoteAddAccountParams({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.passwordConfirmation
  });

  factory RemoteAddAccountParams.fromDomain(AddAccountParams params) => 
    RemoteAddAccountParams(
      name: params.name,
      email: params.email,
      password: params.password,
      passwordConfirmation: params.passwordConfirmation,
    );

  Map toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'passwordConfirmation': passwordConfirmation,
  };
}
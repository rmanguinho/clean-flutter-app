import 'dart:async';

import 'package:meta/meta.dart';

import '../../protocols/protocols.dart';

class StreamLoginPresenter {
  final Validation validation;
  final _emailErrorController = StreamController<String>();
  final _passwordErrorController = StreamController<String>();
  final _isFormValidController = StreamController<bool>();
  String _emailError;
  String _passwordError;

  Stream<String> get emailErrorStream => _emailErrorController.stream.distinct();
  Stream<String> get passwordErrorStream => _passwordErrorController.stream.distinct();
  Stream<bool> get isFormValidStream => _isFormValidController.stream.distinct();

  StreamLoginPresenter({@required this.validation});

  void validateEmail(String email) {
    _emailError = validation.validate(field: 'email', value: email);
    _emailErrorController.add(_emailError);
    _isFormValidController.add(false);
  }

  void validatePassword(String password) {
    _passwordError = validation.validate(field: 'password', value: password);
    _passwordErrorController.add(_passwordError);
    _isFormValidController.add(false);
  }
}
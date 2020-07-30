import 'dart:async';

import 'package:meta/meta.dart';

import '../../protocols/protocols.dart';

class StreamLoginPresenter {
  final Validation validation;
  final _emailErrorController = StreamController<String>();
  final _isFormValidController = StreamController<bool>();
  String _emailError;

  Stream<String> get emailErrorStream => _emailErrorController.stream;
  Stream<bool> get isFormValidStream => _isFormValidController.stream;

  StreamLoginPresenter({@required this.validation});

  void validateEmail(String email) {
    _emailError = validation.validate(field: 'email', value: email);
    _emailErrorController.add(_emailError);
    _isFormValidController.add(false);
  }
}
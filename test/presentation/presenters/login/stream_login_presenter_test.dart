import 'dart:async';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

abstract class Validation {
  String validate({@required String field, @required String value});
}

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

class ValidationSpy extends Mock implements Validation {}

void main() {
  StreamLoginPresenter sut;
  ValidationSpy validation;
  String email;

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit error if email validation fails', () {
    when(validation.validate(field: anyNamed('field'), value: anyNamed('value')))
      .thenReturn('error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
  });
}
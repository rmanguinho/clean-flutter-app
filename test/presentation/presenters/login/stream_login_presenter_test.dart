import 'dart:async';

import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ForDev/presentation/protocols/protocols.dart';

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

  PostExpectation mockValidationCall(String field) =>
    when(validation.validate(field: field == null ? anyNamed('field') : field, value: anyNamed('value')));

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit error if email validation fails', () {
    mockValidation(value: 'error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
  });

  test('Should emit no error if email validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
  });
}
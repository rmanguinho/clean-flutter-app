import 'package:test/test.dart';

import 'package:ForDev/presentation/protocols/protocols.dart';
import 'package:ForDev/validation/validators/validators.dart';

void main() {
  RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });

  test('Should return null if value is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), ValidationError.requiredField);
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null), ValidationError.requiredField);
  });
}
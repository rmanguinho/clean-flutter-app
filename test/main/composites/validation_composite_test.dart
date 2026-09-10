import 'package:fordev/main/main.dart';
import 'package:fordev/presentation/presentation.dart';
import 'package:test/test.dart';

import '../../validation/mocks/mocks.dart';

void main() {
  late ValidationComposite sut;
  late FieldValidationSpy validation1;
  late FieldValidationSpy validation2;
  late FieldValidationSpy validation3;

  setUp(() {
    validation1 = FieldValidationSpy();
    validation1.mockFieldName('other_field');
    validation2 = FieldValidationSpy();
    validation3 = FieldValidationSpy();
    sut = ValidationComposite([validation1, validation2, validation3]);
  });

  test('Should return null if all validations returns null or empty', () {
    final ValidationError? error =
        sut.validate(field: 'any_field', input: {'any_field': 'any_value'});

    expect(error, null);
  });

  test('Should return the first error', () {
    validation1.mockValidationError(ValidationError.invalidField);
    validation2.mockValidationError(ValidationError.requiredField);
    validation3.mockValidationError(ValidationError.invalidField);

    final ValidationError? error =
        sut.validate(field: 'any_field', input: {'any_field': 'any_value'});

    expect(error, ValidationError.requiredField);
  });
}

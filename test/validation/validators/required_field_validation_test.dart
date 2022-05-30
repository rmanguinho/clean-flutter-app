import 'package:fordev/presentation/presentation.dart';
import 'package:fordev/validation/validation.dart';

import 'package:test/test.dart';

void main() {
  late RequiredFieldValidation sut;

  setUp(() {
    sut = const RequiredFieldValidation('any_field');
  });

  test('Should return null if value is not empty', () {
    expect(sut.validate({'any_field': 'any_value'}), null);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate({'any_field': ''}), ValidationError.requiredField);
  });

  test('Should return error if value is null', () {
    expect(sut.validate({}), ValidationError.requiredField);
    expect(sut.validate({'any_field': null}), ValidationError.requiredField);
  });
}

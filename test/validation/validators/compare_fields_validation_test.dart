import 'package:fordev/presentation/presentation.dart';
import 'package:fordev/validation/validation.dart';

import 'package:test/test.dart';

void main() {
  late CompareFieldsValidation sut;

  setUp(() {
    sut = const CompareFieldsValidation(
      field: 'any_field',
      fieldToCompare: 'other_field',
    );
  });

  test('Should return null on invalid cases', () {
    expect(sut.validate({'any_field': 'any_value'}), null);
    expect(sut.validate({'any_field': null}), null);
    expect(sut.validate({'other_field': 'any_value'}), null);
    expect(sut.validate({'other_field': null}), null);
    expect(sut.validate({'any_field': null, 'other_field': null}), null);
    expect(sut.validate({}), null);
  });

  test('Should return error if values are not equal', () {
    final Map<String, String> formData = {
      'any_field': 'any_value',
      'other_field': 'other_value'
    };
    expect(sut.validate(formData), ValidationError.invalidField);
  });

  test('Should return null if values are equal', () {
    final Map<String, String> formData = {
      'any_field': 'any_value',
      'other_field': 'any_value'
    };
    expect(sut.validate(formData), null);
  });
}

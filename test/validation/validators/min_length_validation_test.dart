import 'package:fordev/presentation/protocols/protocols.dart';
import 'package:fordev/validation/validators/validators.dart';

import 'package:faker/faker.dart';
import 'package:test/test.dart';

void main() {
  late MinLengthValidation sut;

  setUp(() {
    sut = MinLengthValidation(field: 'any_field', size: 5);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate({'any_field': ''}), ValidationError.invalidField);
  });

  test('Should return error if value is null', () {
    expect(sut.validate({}), ValidationError.invalidField);
    expect(sut.validate({'any_field': null}), ValidationError.invalidField);
  });

  test('Should return error if value is less than min size', () {
    expect(sut.validate({'any_field': faker.randomGenerator.string(4, min: 1)}), ValidationError.invalidField);
  });

  test('Should return null if value is equal than min size', () {
    expect(sut.validate({'any_field': faker.randomGenerator.string(5, min: 5)}), null);
  });

  test('Should return null if value is bigger than min size', () {
    expect(sut.validate({'any_field': faker.randomGenerator.string(10, min: 6)}), null);
  });
}
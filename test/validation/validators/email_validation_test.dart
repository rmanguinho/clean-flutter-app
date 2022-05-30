import 'package:fordev/presentation/presentation.dart';
import 'package:fordev/validation/validation.dart';

import 'package:test/test.dart';

void main() {
  late EmailValidation sut;

  setUp(() {
    sut = const EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate({'any_field': ''}), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate({}), null);
    expect(sut.validate({'any_field': null}), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate({'any_field': 'rodrigo.manguinho@gmail.com'}), null);
  });

  test('Should return error if email is invalid', () {
    expect(
      sut.validate({'any_field': 'rodrigo.manguinho'}),
      ValidationError.invalidField,
    );
  });
}

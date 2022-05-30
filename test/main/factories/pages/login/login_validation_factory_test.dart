import 'package:fordev/main/main.dart';
import 'package:fordev/validation/validation.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct validations', () {
    final List<FieldValidation> validations = makeLoginValidations();

    expect(validations, [
      const RequiredFieldValidation('email'),
      const EmailValidation('email'),
      const RequiredFieldValidation('password'),
      const MinLengthValidation(field: 'password', size: 3)
    ]);
  });
}

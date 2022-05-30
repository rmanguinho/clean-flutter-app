import 'package:fordev/main/main.dart';
import 'package:fordev/validation/validation.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct validations', () {
    final List<FieldValidation> validations = makeSignUpValidations();

    expect(validations, [
      const RequiredFieldValidation('name'),
      const MinLengthValidation(field: 'name', size: 3),
      const RequiredFieldValidation('email'),
      const EmailValidation('email'),
      const RequiredFieldValidation('password'),
      const MinLengthValidation(field: 'password', size: 3),
      const RequiredFieldValidation('passwordConfirmation'),
      const CompareFieldsValidation(
        field: 'passwordConfirmation',
        fieldToCompare: 'password',
      )
    ]);
  });
}

import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/validators/validators.dart';

Validation makeLoginValidation() {
  return ValidationComposite([
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password')
  ]);
}
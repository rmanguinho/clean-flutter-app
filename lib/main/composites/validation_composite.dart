import '../../presentation/protocols/protocols.dart';
import '../../validation/protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  ValidationError? validate({required String field, required Map input}) {
    ValidationError? error;
    for (final FieldValidation validation
        in validations.where((FieldValidation v) => v.field == field)) {
      error = validation.validate(input);
      if (error != null) {
        return error;
      }
    }
    return error;
  }
}

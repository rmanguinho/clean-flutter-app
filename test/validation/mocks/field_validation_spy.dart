import 'package:fordev/presentation/presentation.dart';
import 'package:fordev/validation/protocols/protocols.dart';

import 'package:mocktail/mocktail.dart';

class FieldValidationSpy extends Mock implements FieldValidation {
  FieldValidationSpy() {
    mockValidation();
    mockFieldName('any_field');
  }

  When mockValidationCall() => when(() => validate(any()));
  void mockValidation() => mockValidationCall().thenReturn(null);
  void mockValidationError(ValidationError error) =>
      mockValidationCall().thenReturn(error);

  void mockFieldName(String fieldName) =>
      when(() => field).thenReturn(fieldName);
}

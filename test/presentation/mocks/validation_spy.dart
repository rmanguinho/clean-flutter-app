import 'package:fordev/presentation/protocols/protocols.dart';

import 'package:mocktail/mocktail.dart';

class ValidationSpy extends Mock implements Validation {
  ValidationSpy() {
    mockValidation();
  }

  When mockValidationCall(String? field) => when(
        () => validate(
          field: field ?? any(named: 'field'),
          input: any(named: 'input'),
        ),
      );
  void mockValidation({String? field}) =>
      mockValidationCall(field).thenReturn(null);
  void mockValidationError({String? field, required ValidationError value}) =>
      mockValidationCall(field).thenReturn(value);
}

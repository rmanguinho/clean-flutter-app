import 'package:fordev/presentation/protocols/protocols.dart';

import 'package:mocktail/mocktail.dart';

class ValidationSpy extends Mock implements Validation {
  ValidationSpy() {
    this.mockValidation();
  }

  When mockValidationCall(String? field) => when(() => this.validate(field: field == null ? any(named: 'field') : field, input: any(named: 'input')));
  void mockValidation({ String? field }) => this.mockValidationCall(field).thenReturn(null);
  void mockValidationError({ String? field, required ValidationError value }) => this.mockValidationCall(field).thenReturn(value);
}
import 'package:equatable/equatable.dart';

import '../../presentation/protocols/protocols.dart';
import '../protocols/protocols.dart';

class CompareFieldsValidation extends Equatable implements FieldValidation {
  @override
  final String field;
  final String fieldToCompare;

  @override
  List<String> get props => <String>[field, fieldToCompare];

  const CompareFieldsValidation({
    required this.field,
    required this.fieldToCompare,
  });

  @override
  ValidationError? validate(Map input) {
    return input[field] != null &&
            input[fieldToCompare] != null &&
            input[field] != input[fieldToCompare]
        ? ValidationError.invalidField
        : null;
  }
}

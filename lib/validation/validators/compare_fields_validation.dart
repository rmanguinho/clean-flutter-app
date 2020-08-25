import 'package:meta/meta.dart';

import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class CompareFieldsValidation implements FieldValidation {
  final String field;
  final String fieldToCompare;

  CompareFieldsValidation({@required this.field, @required this.fieldToCompare});

  ValidationError validate(Map input) =>
    input[field] != null &&
    input[fieldToCompare] != null &&
    input[field] != input[fieldToCompare] ?
      ValidationError.invalidField
      : null;
}
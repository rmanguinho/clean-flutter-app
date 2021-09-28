import '../../presentation/protocols/protocols.dart';
import '../protocols/protocols.dart';

import 'package:equatable/equatable.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  final String field;
  final int size;

  List get props => [field, size];

  MinLengthValidation({ required this.field, required this.size});

  ValidationError? validate(Map input) =>
    input[field] != null
    && input[field].length >= size
      ? null
      : ValidationError.invalidField;
}
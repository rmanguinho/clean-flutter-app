import '../../presentation/protocols/protocols.dart';
import '../protocols/protocols.dart';

import 'package:equatable/equatable.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  final String field;

  List get props => [field];

  RequiredFieldValidation(this.field);

  ValidationError? validate(Map input) =>
    input[field]?.isNotEmpty == true ? null : ValidationError.requiredField;
}
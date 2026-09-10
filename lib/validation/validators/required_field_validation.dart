import 'package:equatable/equatable.dart';

import '../../presentation/protocols/protocols.dart';
import '../protocols/protocols.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List<String> get props => <String>[field];

  @override
  const RequiredFieldValidation(this.field);

  @override
  ValidationError? validate(Map input) =>
      input[field]?.isNotEmpty == true ? null : ValidationError.requiredField;
}

import 'package:meta/meta.dart';

abstract class Validation {
  ValidationError validate({@required String field, @required Map input});
}

enum ValidationError {
  requiredField,
  invalidField
}
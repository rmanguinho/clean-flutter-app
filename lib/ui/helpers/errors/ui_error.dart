import '../helpers.dart';

enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials
}

extension UIErrorExtension on UIError {
  String get description {
    switch(this) {
      case UIError.requiredField: return R.string.msgRequiredField;
      case UIError.invalidField: return R.string.msgInvalidField;
      case UIError.invalidCredentials: return R.string.msgInvalidCredentials;
      default: return R.string.msgUnexpectedError;
    }
  }
}
import '../helpers.dart';

enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  emailInUse
}

extension UIErrorExtension on UIError {
  String get description {
    switch(this) {
      case UIError.requiredField: return R.string.msgRequiredField;
      case UIError.invalidField: return R.string.msgInvalidField;
      case UIError.invalidCredentials: return R.string.msgInvalidCredentials;
      case UIError.emailInUse: return R.string.msgEmailInUse;
      default: return R.string.msgUnexpectedError;
    }
  }
}
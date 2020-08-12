import '../../utils/utils.dart';

enum DomainError {
  unexpected,
  invalidCredentials
}

extension DomainErrorExtension on DomainError {
  String get description {
    switch(this) {
      case DomainError.invalidCredentials: return S.msgInvalidCredentials;
      default: return S.msgUnexpectedError;
    }
  }
}
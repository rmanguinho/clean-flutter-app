abstract class Resource {
  String get msgInvalidCredentials;
  String get msgInvalidField;
  String get msgRequiredField;
  String get msgUnexpectedError;

  String get addAccount;
  String get email;
  String get enter;
  String get login;
  String get password;
  String get wait;

  Map<String, String> toJson() => {
    'msgInvalidCredentials': msgInvalidCredentials,
    'msgInvalidField': msgInvalidField,
    'msgRequiredField': msgRequiredField,
    'msgUnexpectedError': msgUnexpectedError,

    'addAccount': addAccount,
    'email': email,
    'enter': enter,
    'login': login,
    'password': password,
    'wait': wait,
  };
}
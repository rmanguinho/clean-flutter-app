import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../mixins/mixins.dart';
import '../protocols/protocols.dart';

class GetxLoginPresenter extends GetxController
    with LoadingManager, NavigationManager, FormManager, UIErrorManager
    implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  final Rx<UIError?> _emailError = Rx<UIError?>(null);
  final Rx<UIError?> _passwordError = Rx<UIError?>(null);

  String? _email;
  String? _password;

  @override
  Stream<UIError?> get emailErrorStream => _emailError.stream;
  @override
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;

  GetxLoginPresenter({
    required this.validation,
    required this.authentication,
    required this.saveCurrentAccount,
  });

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email');
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password');
    _validateForm();
  }

  UIError? _validateField(String field) {
    final Map<String, String?> formData = {
      'email': _email,
      'password': _password,
    };
    final ValidationError? error =
        validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  void _validateForm() {
    isFormValid = _emailError.value == null &&
        _passwordError.value == null &&
        _email != null &&
        _password != null;
  }

  @override
  Future<void> auth() async {
    try {
      mainError = null;
      isLoading = true;
      final AccountEntity account = await authentication
          .auth(AuthenticationParams(email: _email!, secret: _password!));
      await saveCurrentAccount.save(account);
      navigateTo = '/surveys';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials:
          mainError = UIError.invalidCredentials;
          break;
        default:
          mainError = UIError.unexpected;
          break;
      }
      isLoading = false;
    }
  }

  @override
  void goToSignUp() {
    navigateTo = '/signup';
  }
}

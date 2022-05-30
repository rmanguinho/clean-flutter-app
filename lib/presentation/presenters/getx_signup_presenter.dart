import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../mixins/mixins.dart';
import '../protocols/protocols.dart';

class GetxSignUpPresenter extends GetxController
    with LoadingManager, NavigationManager, FormManager, UIErrorManager
    implements SignUpPresenter {
  final Validation validation;
  final AddAccount addAccount;
  final SaveCurrentAccount saveCurrentAccount;

  final Rx<UIError?> _emailError = Rx<UIError?>(null);
  final Rx<UIError?> _nameError = Rx<UIError?>(null);
  final Rx<UIError?> _passwordError = Rx<UIError?>(null);
  final Rx<UIError?> _passwordConfirmationError = Rx<UIError?>(null);

  String? _name;
  String? _email;
  String? _password;
  String? _passwordConfirmation;

  @override
  Stream<UIError?> get emailErrorStream => _emailError.stream;
  @override
  Stream<UIError?> get nameErrorStream => _nameError.stream;
  @override
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;
  @override
  Stream<UIError?> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream;

  GetxSignUpPresenter({
    required this.validation,
    required this.addAccount,
    required this.saveCurrentAccount,
  });

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email');
    _validateForm();
  }

  @override
  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField('name');
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password');
    _validateForm();
  }

  @override
  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField('passwordConfirmation');
    _validateForm();
  }

  UIError? _validateField(String field) {
    final Map<String, String?> formData = {
      'name': _name,
      'email': _email,
      'password': _password,
      'passwordConfirmation': _passwordConfirmation
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
        _nameError.value == null &&
        _passwordError.value == null &&
        _passwordConfirmationError.value == null &&
        _name != null &&
        _email != null &&
        _password != null &&
        _passwordConfirmation != null;
  }

  @override
  Future<void> signUp() async {
    try {
      mainError = null;
      isLoading = true;
      final AccountEntity account = await addAccount.add(
        AddAccountParams(
          name: _name!,
          email: _email!,
          password: _password!,
          passwordConfirmation: _passwordConfirmation!,
        ),
      );
      await saveCurrentAccount.save(account);
      navigateTo = '/surveys';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.emailInUse:
          mainError = UIError.emailInUse;
          break;
        default:
          mainError = UIError.unexpected;
          break;
      }
      isLoading = false;
    }
  }

  @override
  void goToLogin() {
    navigateTo = '/login';
  }
}

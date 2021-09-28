import 'package:fordev/ui/helpers/helpers.dart';
import 'package:fordev/ui/pages/pages.dart';

import 'dart:async';
import 'package:mocktail/mocktail.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {
  final nameErrorController = StreamController<UIError?>();
  final emailErrorController = StreamController<UIError?>();
  final passwordErrorController = StreamController<UIError?>();
  final passwordConfirmationErrorController = StreamController<UIError?>();
  final mainErrorController = StreamController<UIError?>();
  final navigateToController = StreamController<String?>();
  final isFormValidController = StreamController<bool>();
  final isLoadingController = StreamController<bool>();

  SignUpPresenterSpy() {
    when(() => this.signUp()).thenAnswer((_) async => _);
    when(() => this.nameErrorStream).thenAnswer((_) => nameErrorController.stream);
    when(() => this.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => this.passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(() => this.passwordConfirmationErrorStream).thenAnswer((_) => passwordConfirmationErrorController.stream);
    when(() => this.mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(() => this.navigateToStream).thenAnswer((_) => navigateToController.stream);
    when(() => this.isFormValidStream).thenAnswer((_) => isFormValidController.stream);
    when(() => this.isLoadingStream).thenAnswer((_) => isLoadingController.stream);
  }

  void emitNameError(UIError error) => nameErrorController.add(error);
  void emitNameValid() => nameErrorController.add(null);
  void emitEmailError(UIError error) => emailErrorController.add(error);
  void emitEmailValid() => emailErrorController.add(null);
  void emitPasswordError(UIError error) => passwordErrorController.add(error);
  void emitPasswordValid() => passwordErrorController.add(null);
  void emitPasswordConfirmationError(UIError error) => passwordConfirmationErrorController.add(error);
  void emitPasswordConfirmationValid() => passwordConfirmationErrorController.add(null);
  void emitFormError() => isFormValidController.add(false);
  void emitFormValid() => isFormValidController.add(true);
  void emitLoading([bool show = true]) => isLoadingController.add(show);
  void emitMainError(UIError error) => mainErrorController.add(error);
  void emitNavigateTo(String route) => navigateToController.add(route);

  void dispose() {
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    passwordConfirmationErrorController.close();
    mainErrorController.close();
    navigateToController.close();
    isFormValidController.close();
    isLoadingController.close();
  }
}
import 'dart:async';

import 'package:fordev/ui/ui.dart';
import 'package:mocktail/mocktail.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {
  final StreamController<UIError?> nameErrorController =
      StreamController<UIError?>();
  final StreamController<UIError?> emailErrorController =
      StreamController<UIError?>();
  final StreamController<UIError?> passwordErrorController =
      StreamController<UIError?>();
  final StreamController<UIError?> passwordConfirmationErrorController =
      StreamController<UIError?>();
  final StreamController<UIError?> mainErrorController =
      StreamController<UIError?>();
  final StreamController<String?> navigateToController =
      StreamController<String?>();
  final StreamController<bool> isFormValidController = StreamController<bool>();
  final StreamController<bool> isLoadingController = StreamController<bool>();

  SignUpPresenterSpy() {
    when(() => signUp()).thenAnswer((_) async => _);
    when(() => nameErrorStream).thenAnswer((_) => nameErrorController.stream);
    when(() => emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(() => passwordConfirmationErrorStream)
        .thenAnswer((_) => passwordConfirmationErrorController.stream);
    when(() => mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(() => navigateToStream).thenAnswer((_) => navigateToController.stream);
    when(() => isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);
  }

  void emitNameError(UIError error) => nameErrorController.add(error);
  void emitNameValid() => nameErrorController.add(null);
  void emitEmailError(UIError error) => emailErrorController.add(error);
  void emitEmailValid() => emailErrorController.add(null);
  void emitPasswordError(UIError error) => passwordErrorController.add(error);
  void emitPasswordValid() => passwordErrorController.add(null);
  void emitPasswordConfirmationError(UIError error) =>
      passwordConfirmationErrorController.add(error);
  void emitPasswordConfirmationValid() =>
      passwordConfirmationErrorController.add(null);
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

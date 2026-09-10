import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './components/components.dart';
import './login.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../mixins/mixins.dart';

class LoginPage extends StatelessWidget
    with KeyboardManager, LoadingManager, UIErrorManager, NavigationManager {
  final LoginPresenter presenter;

  LoginPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          handleLoading(context, presenter.isLoadingStream);
          handleMainError(context, presenter.mainErrorStream);
          handleNavigation(presenter.navigateToStream, clear: true);

          return GestureDetector(
            onTap: () => hideKeyboard(context),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const LoginHeader(),
                  Headline1(text: R.string.login),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: ListenableProvider<LoginPresenter>(
                      create: (_) => presenter,
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            const EmailInput(),
                            const Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 32),
                              child: PasswordInput(),
                            ),
                            const LoginButton(),
                            TextButton.icon(
                              onPressed: presenter.goToSignUp,
                              icon: const Icon(Icons.person),
                              label: Text(R.string.addAccount),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

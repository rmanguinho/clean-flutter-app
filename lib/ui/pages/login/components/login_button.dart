import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart';
import '../login.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginPresenter presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return ElevatedButton(
          onPressed: snapshot.data == true ? presenter.auth : null,
          child: Text(R.string.enter.toUpperCase()),
        );
      },
    );
  }
}

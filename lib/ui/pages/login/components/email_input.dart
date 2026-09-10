import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart';
import '../login.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginPresenter presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<UIError?>(
      stream: presenter.emailErrorStream,
      builder: (BuildContext context, AsyncSnapshot<UIError?> snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: R.string.email,
            icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
            errorText: snapshot.data?.description,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: presenter.validateEmail,
        );
      },
    );
  }
}

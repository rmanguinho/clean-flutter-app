import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_presenter.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<LoginPresenter>();
    return Obx(() => TextFormField(
      decoration: InputDecoration(
        labelText: 'Senha',
        icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
        errorText: presenter.passwordError?.value?.isEmpty == true ? null : presenter.passwordError.value,
      ),
      obscureText: true,
      onChanged: presenter.validatePassword,
    ));
  }
}
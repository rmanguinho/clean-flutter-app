import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_presenter.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<LoginPresenter>();
    return Obx(() => TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
        errorText: presenter.emailError?.value?.isEmpty == true ? null : presenter.emailError.value,
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: presenter.validateEmail,
    ));
  }
}
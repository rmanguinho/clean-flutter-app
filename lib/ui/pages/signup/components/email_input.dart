import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: R.string.email,
        icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
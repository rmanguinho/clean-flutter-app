import 'package:flutter/material.dart';

import '../helpers/helpers.dart';

Future<void> showLoading(BuildContext context) async {
  // await Future.delayed(Duration.zero);
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return SimpleDialog(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              Text(R.string.wait, textAlign: TextAlign.center),
            ],
          ),
        ],
      );
    },
  );
}

void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}

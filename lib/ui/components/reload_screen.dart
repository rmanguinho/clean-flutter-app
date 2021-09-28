import '../helpers/helpers.dart';

import 'package:flutter/material.dart';

class ReloadScreen extends StatelessWidget {
  final String error;
  final Future<void> Function() reload;

  const ReloadScreen({ required this.error, required this.reload });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error, style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: reload,
            child: Text(R.string.reload),
          )
        ],
      ),
    );
  }
}
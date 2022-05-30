import 'package:flutter/material.dart';

class Headline1 extends StatelessWidget {
  final String text;

  const Headline1({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

import 'package:flutter/material.dart';

class Headline1 extends StatelessWidget {
  final String text;

  const Headline1({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

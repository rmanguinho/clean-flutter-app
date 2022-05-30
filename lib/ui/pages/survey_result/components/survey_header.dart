import 'package:flutter/material.dart';

class SurveyHeader extends StatelessWidget {
  final String question;

   const SurveyHeader(this.question, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
      decoration:
          BoxDecoration(color: Theme.of(context).disabledColor.withAlpha(90)),
      child: Text(question),
    );
  }
}

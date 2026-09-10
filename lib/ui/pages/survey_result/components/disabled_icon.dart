import 'package:flutter/material.dart';

class DisabledIcon extends StatelessWidget {
  const DisabledIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Icon(
        Icons.check_circle,
        color: Theme.of(context).disabledColor,
      ),
    );
  }
}

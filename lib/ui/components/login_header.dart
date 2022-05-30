import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            Theme.of(context).primaryColorLight,
            Theme.of(context).primaryColorDark
          ],
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 0),
            spreadRadius: 0,
            blurRadius: 4,
            color: Colors.black,
          )
        ],
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80)),
      ),
      child: const Image(image: AssetImage('lib/ui/assets/logo.png')),
    );
  }
}

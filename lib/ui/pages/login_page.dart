import 'package:flutter/material.dart';

import '../components/components.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LoginHeader(),
            Headline1(text: 'Login'),
            Padding(
              padding: EdgeInsets.all(32),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight)
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 32),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight)
                        ),
                        obscureText: true,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text('Entrar'.toUpperCase()),
                    ),
                    FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.person),
                      label: Text('Criar Conta')
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

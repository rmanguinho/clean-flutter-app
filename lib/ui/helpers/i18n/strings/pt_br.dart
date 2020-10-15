import './translation.dart';

class PtBr implements Translation {
  String get msgEmailInUse => 'O email já está em uso.';
  String get msgInvalidCredentials => 'Credenciais inválidas.';
  String get msgInvalidField => 'Campo inválido';
  String get msgRequiredField => 'Campo obrigatório';
  String get msgUnexpectedError => 'Algo errado aconteceu. Tente novamente em breve.';

  String get addAccount => 'Criar conta';
  String get confirmPassword => 'Confirmar senha';
  String get email => 'Email';
  String get enter => 'Entrar';
  String get login => 'Login';
  String get name => 'Nome';
  String get password => 'Senha';
  String get reload => 'Recarregar';
  String get surveys => 'Enquetes';
  String get surveyResult => 'Resultado da enquete';
  String get wait => 'Aguarde...';
}
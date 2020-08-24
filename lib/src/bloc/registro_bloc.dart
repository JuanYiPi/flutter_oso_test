import 'dart:async';

class RegistroBloc{

  final _nameController                 = StreamController<String>.broadcast();
  final _emailController                = StreamController<String>.broadcast();
  final _passwordController             = StreamController<String>.broadcast();
  final _passwordConfirmationController = StreamController<String>.broadcast();

  //Recuperar los datos del Stream
  Stream<String> get nameStream                 => _nameController.stream;
  Stream<String> get emailStream                => _emailController.stream;
  Stream<String> get passwordtream              => _passwordController.stream;
  Stream<String> get passwordConfirmationStream => _passwordConfirmationController.stream; 

  //Insertar valores al Stream
  Function(String) get changeName                 => _nameController.sink.add;
  Function(String) get changeEmail                => _emailController.sink.add;
  Function(String) get changePassword             => _passwordController.sink.add;
  Function(String) get changePasswordConfirmation => _passwordConfirmationController.sink.add;

  dispose() {
    _nameController?.close();
    _emailController?.close();
    _passwordController?.close();
    _passwordConfirmationController?.close();
  }
}
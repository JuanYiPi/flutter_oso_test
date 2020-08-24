import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_oso_test/src/bloc/validators.dart';

class RegistroBloc with Validators {

  final _nameController                 = BehaviorSubject<String>();
  final _emailController                = BehaviorSubject<String>();
  final _passwordController             = BehaviorSubject<String>();
  final _passwordConfirmationController = BehaviorSubject<String>();

  //Recuperar los datos del Stream
  Stream<String> get nameStream                 => _nameController.stream.transform( validarName );
  Stream<String> get emailStream                => _emailController.stream.transform( validarEmail );
  Stream<String> get passwordStream              => _passwordController.stream.transform( validarPassword );
  Stream<String> get passwordConfirmationStream => _passwordConfirmationController.stream.transform( validarPasswordConfirmation ); 

  //Validar botón
  Stream<bool> get formValiedStream =>
    Rx.combineLatest4(nameStream, emailStream, passwordStream, passwordConfirmationStream, (n, e, p, pc) => true);

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
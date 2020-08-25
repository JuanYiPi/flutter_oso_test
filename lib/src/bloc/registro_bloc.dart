import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_oso_test/src/bloc/validators.dart';

class RegistroBloc with Validators {

  //Registro
  final _nameController                 = BehaviorSubject<String>();
  final _emailController                = BehaviorSubject<String>();
  final _passwordController             = BehaviorSubject<String>();
  final _passwordConfirmationController = BehaviorSubject<String>();
  //Login
  final _emailLoginController           = BehaviorSubject<String>();
  final _passwordLoginController        = BehaviorSubject<String>();


  //Recuperar los datos del Stream
  Stream<String> get nameStream                 => _nameController.stream.transform( validarName );
  Stream<String> get emailStream                => _emailController.stream.transform( validarEmail );
  Stream<String> get passwordStream             => _passwordController.stream.transform( validarPassword );
  Stream<String> get passwordConfirmationStream => _passwordConfirmationController.stream.transform( validarPasswordConfirmation );
  //Login
  Stream<String> get emailStreamLogin            => _emailLoginController.stream.transform( validarEmailLogin );
  Stream<String> get passwordStreamLogin         => _passwordLoginController.stream.transform( validarPasswordLogin );
  


  //Validar botón
  Stream<bool> get formValiedStream =>
    Rx.combineLatest4(nameStream, emailStream, passwordStream, passwordConfirmationStream, (n, e, p, pc) => true);
  Stream<bool> get formValiedStreamLogin =>
    Rx.combineLatest2(emailStreamLogin, passwordStreamLogin, (e, p) => true);

  //Insertar valores al Stream
  Function(String) get changeName                 => _nameController.sink.add;
  Function(String) get changeEmail                => _emailController.sink.add;
  Function(String) get changePassword             => _passwordController.sink.add;
  Function(String) get changePasswordConfirmation => _passwordConfirmationController.sink.add;
  //Login
  Function(String) get changeEmailLogin           => _emailLoginController.sink.add;
  Function(String) get changePasswordLogin        => _passwordLoginController.sink.add;
  


  dispose() {
    _nameController?.close();
    _emailController?.close();
    _passwordController?.close();
    _passwordConfirmationController?.close();

    _emailLoginController?.close();
    _passwordLoginController?.close();
  }
}
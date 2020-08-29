import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_oso_test/src/bloc/validators.dart';

class Blocs with Validators {

  //Registro
  final _nameController                 = BehaviorSubject<String>();
  final _emailController                = BehaviorSubject<String>();
  final _passwordController             = BehaviorSubject<String>();
  final _passwordConfirmationController = BehaviorSubject<String>();
  //Login
  final _emailLoginController           = BehaviorSubject<String>();
  final _passwordLoginController        = BehaviorSubject<String>();
  //RegistrarDireccionesEnvio
  final _completeName                   = BehaviorSubject<String>();
  final _codigoPostal                   = BehaviorSubject<String>();
  final _pais                           = BehaviorSubject<String>();
  final _estado                         = BehaviorSubject<String>();
  final _municipio                      = BehaviorSubject<String>();
  final _colonia                        = BehaviorSubject<String>();
  final _calle                          = BehaviorSubject<String>();
  final _numeroExterior                 = BehaviorSubject<String>();
  final _telefonoContacto               = BehaviorSubject<String>();


  //Recuperar los datos del Stream
  Stream<String> get nameStream                 => _nameController.stream.transform( validarName );
  Stream<String> get emailStream                => _emailController.stream.transform( validarEmail );
  Stream<String> get passwordStream             => _passwordController.stream.transform( validarPassword );
  Stream<String> get passwordConfirmationStream => _passwordConfirmationController.stream.transform( validarPasswordConfirmation );
  //Login
  Stream<String> get emailStreamLogin            => _emailLoginController.stream.transform( validarEmailLogin );
  Stream<String> get passwordStreamLogin         => _passwordLoginController.stream.transform( validarPasswordLogin );
  //RegistrarDireccionesEnvio
  Stream<String> get completeNameStream          => _completeName.stream.transform(validarCompleteName);
  Stream<String> get codigoPostalStream          => _codigoPostal.stream.transform(validarCodigoPostal);
  Stream<String> get paisStream                  => _pais.stream.transform(validarPais);
  Stream<String> get estadoStream                => _estado.stream.transform(validarEstado);
  Stream<String> get municipioStream             => _municipio.stream.transform(validarMunicipio);
  Stream<String> get coloniaStream               => _colonia.stream.transform(validarColonia);
  Stream<String> get calleStream                 => _calle.stream.transform(validarCalle);
  Stream<String> get numeroExteriorStream        => _numeroExterior.stream.transform(validarNumeroExterior);
  Stream<String> get telefonoContactoStream      => _telefonoContacto.stream.transform(validarNumeroTelefonico);
  


  //Validar botón
  Stream<bool> get formValiedStream =>
    Rx.combineLatest4(nameStream, emailStream, passwordStream, passwordConfirmationStream, (n, e, p, pc) => true);
    //Login
  Stream<bool> get formValiedStreamLogin =>
    Rx.combineLatest2(emailStreamLogin, passwordStreamLogin, (e, p) => true);
    //RegistrarDireccionesEnvio
  Stream<bool> get formValiedStreamDirecciones =>
    Rx.combineLatest9(completeNameStream, codigoPostalStream, paisStream, estadoStream, municipioStream, coloniaStream, calleStream, numeroExteriorStream, telefonoContactoStream, (cn, cp, p, e, m, col, calle, nomExt, tel) => true);

  //Insertar valores al Stream
  Function(String) get changeName                 => _nameController.sink.add;
  Function(String) get changeEmail                => _emailController.sink.add;
  Function(String) get changePassword             => _passwordController.sink.add;
  Function(String) get changePasswordConfirmation => _passwordConfirmationController.sink.add;
  //Login
  Function(String) get changeEmailLogin           => _emailLoginController.sink.add;
  Function(String) get changePasswordLogin        => _passwordLoginController.sink.add;
  //RegistrarDireccionesEnvio
  Function(String) get changeCompleteName         => _completeName.sink.add;
  Function(String) get changeCodigoPostal         => _codigoPostal.sink.add;
  Function(String) get changePais                 => _pais.sink.add;
  Function(String) get changeEstado               => _estado.sink.add;
  Function(String) get changeMunicipio            => _municipio.sink.add;
  Function(String) get changeColonia              => _colonia.sink.add;
  Function(String) get changeCalle                => _calle.sink.add;
  Function(String) get changeNumeroExterior       => _numeroExterior.sink.add;
  Function(String) get changeTelefonoContacto     => _telefonoContacto.sink.add;
  


  dispose() {
    _nameController?.close();
    _emailController?.close();
    _passwordController?.close();
    _passwordConfirmationController?.close();
  //Login
    _emailLoginController?.close();
    _passwordLoginController?.close();
  //RegistrarDireccionesEnvio
    _completeName?.close();
    _codigoPostal?.close();
    _pais?.close();
    _estado?.close();
    _municipio?.close();
    _colonia?.close();
    _calle?.close();
    _numeroExterior?.close();  
    _telefonoContacto?.close();    
  }
}
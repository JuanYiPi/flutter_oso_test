import 'dart:async';

class Validators {

  static String psw = '';

  final validarName = StreamTransformer<String, String>.fromHandlers(
    handleData: ( name, sink ) {

      if ( name.length >= 7 ) {
        sink.add( name );
      } else {
        sink.addError('Escriba su nombre completo');
      }
    }
  );

  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: ( email, sink ) {

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if ( regExp.hasMatch( email ) ) {
        sink.add(email);
      } else {
        sink.addError('Inserte un correo valido');
      }
    }
  );

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: ( password, sink ) {

      if ( password.length >= 7 ) {
        sink.add( password );
      } else {
        sink.addError('La contraseña necesita mas de 6 digitos');
      } 
      
      psw = password;
    }
  );

  final validarPasswordConfirmation = StreamTransformer<String, String>.fromHandlers(
    handleData: ( passwordConfirmation, sink ) {

      if ( passwordConfirmation == psw ) {
        sink.add( passwordConfirmation );
      } else {
        sink.addError('Las contraseñas no coinciden');
      }
    }
  );
}
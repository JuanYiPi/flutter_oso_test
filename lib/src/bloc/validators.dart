import 'dart:async';

class Validators {

  //RegistrarUsuario

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

  //Login

  final validarEmailLogin = StreamTransformer<String, String>.fromHandlers(
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

  final validarPasswordLogin = StreamTransformer<String, String>.fromHandlers(
    handleData: ( password, sink ) {

      if ( password.length >= 7 ) {
        sink.add( password );
      } else {
        sink.addError('La contraseña necesita mas de 6 digitos');
      } 
    
    }
  );

  //RegistrarDirecciones

  final validarCompleteName = StreamTransformer<String, String>.fromHandlers(
    handleData: ( completeName, sink ) {

      if ( completeName.length >= 8 ) {
        sink.add( completeName );
      } else {
        sink.addError('Escriba su nombre completo');
      }
    }
  );

  final validarCodigoPostal = StreamTransformer<String, String>.fromHandlers(
    handleData: ( codigoPostal, sink ) {

      Pattern pattern = '^\\d{4,5}\$';
      RegExp regExp = new RegExp(pattern);

      if ( regExp.hasMatch( codigoPostal )) {
        sink.add(codigoPostal);
      } else {
        sink.addError('Ingrese un código postal valido');
      }
    }
  );

  final validarPais = StreamTransformer<String, String>.fromHandlers(
    handleData: ( pais, sink ) {

      if ( pais.length != null ) {
        sink.add( pais );
      }
    }
  );

  final validarEstado = StreamTransformer<String, String>.fromHandlers(
    handleData: ( estado, sink ) {

      if ( estado.length != null ) {
        sink.add( estado );
      } 
    }
  );

  final validarMunicipio = StreamTransformer<String, String>.fromHandlers(
    handleData: ( municipio, sink ) {

      if ( municipio.length != null ) {
        sink.add( municipio );
      } 
    }
  );

  final validarColonia = StreamTransformer<String, String>.fromHandlers(
    handleData: ( colonia, sink ) {

      if ( colonia.length != null ) {
        sink.add( colonia );
      } 
    }
  );

  final validarCalle = StreamTransformer<String, String>.fromHandlers(
    handleData: ( calle, sink ) {

      if ( calle.length != null ) {
        sink.add( calle );
      } 
    }
  );

  final validarNumeroExterior = StreamTransformer<String, String>.fromHandlers(
    handleData: ( numeroExterior, sink ) {

      if ( numeroExterior.length != null ) {
        sink.add( numeroExterior );
      } 
    }
  );

  final validarNumeroTelefonico = StreamTransformer<String, String>.fromHandlers(
    handleData: ( numeroTelefonico, sink ) {

      if ( numeroTelefonico.length == 10 ) {
        sink.add( numeroTelefonico );
      } else {
        sink.addError('Escriba un número telefonico valido');
      }
    }
  );

}
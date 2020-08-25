import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/bloc/provider_bloc.dart';

//Miguel
import 'package:flutter_oso_test/src/models/error_user_model.dart';
import 'package:flutter_oso_test/src/models/user_model.dart';
import 'package:flutter_oso_test/src/providers/users_providers.dart';

class RegistroPage extends StatefulWidget {

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {

  final usersProviders = new UsersProviders();

  bool visiblePassword1 = true;
  bool visiblePassword2 = true;
  IconData icon1 = Icons.visibility;
  IconData icon2 = Icons.visibility;
  bool _isLoading = false;

  final textControllerName                  = TextEditingController();
  final textControllerEmail                 = TextEditingController();
  final textControllerPassword              = TextEditingController();
  final textControllerPasswordConfirmation  = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textControllerName.dispose();
    textControllerEmail.dispose();
    textControllerPassword.dispose();
    textControllerPasswordConfirmation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo( context ),
          _loginForm( context ),
        ],
      ),
    );
  }

  Widget _loginForm( BuildContext context ) {

  final bloc = Provider.of(context);
  final size = MediaQuery.of(context).size;  

   return SingleChildScrollView(
    child: Column(
      children: <Widget>[

       SafeArea(
         child: Container(
          height: 220.0,
         )
       ),

       Container(
        width: size.width * 0.85,
        margin: EdgeInsets.symmetric( vertical: 30.0 ),
        padding: EdgeInsets.symmetric( vertical: 50.0 ),
        decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(5.0),
         boxShadow: <BoxShadow> [
           BoxShadow(
             color: Colors.black26,
             blurRadius: 3.0,
             offset: Offset(0.0, 5.0),
             spreadRadius: 3.0,
          ),
        ]
       ),

        child: Column(
          children: <Widget>[
           Text('Crear cuenta', style: TextStyle(fontSize: 20.0)),
                SizedBox( height: 60.0 ),
                _registrarNombre(bloc),
                SizedBox( height: 30.0 ),
                _crearEmail(bloc),
                SizedBox( height: 30.0 ),
                _crearPassword(bloc),
                SizedBox( height: 30.0 ),
                _confirmarPassword(bloc),
                SizedBox( height: 30.0 ),
                _crearBoton( context, bloc ),
         ],
       ),
      ),
        FlatButton(
       child: Text( '¿Ya tienes cuenta? Ingresa aquí' ),
       onPressed: ()=> Navigator.pushReplacementNamed(context, 'login'),
      ),
        SizedBox( height: 100.0 ),
       ],
     ),
   );
 } 

 Widget _registrarNombre(RegistroBloc bloc) {

   return StreamBuilder(
     stream: bloc.nameStream,
     builder: (BuildContext context, AsyncSnapshot snapshot){

      return Container(
         padding: EdgeInsets.symmetric( horizontal: 20.0 ),

         child: TextField(
           controller: textControllerName,
           textCapitalization: TextCapitalization.words,
           decoration: InputDecoration(
            icon: Icon( Icons.person_pin, color: Colors.deepPurple),
            hintText: 'Juan Miguel Gómez Pérez',
            labelText: 'Nombre completo',
            // counterText: snapshot.data,
            errorText: snapshot.error,
          ),
          onChanged: bloc.changeName,
        ),
      );
    },
  );   
 }

 Widget _crearEmail(RegistroBloc bloc) {

  return StreamBuilder(
    stream: bloc.emailStream,
    builder: (BuildContext context, AsyncSnapshot snapshot){

      return Container(
        padding: EdgeInsets.symmetric( horizontal: 20.0 ),

        child: TextField(
          controller: textControllerEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon( Icons.alternate_email, color: Colors.deepPurple),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo electronico',
            // counterText: snapshot.data,
            errorText: snapshot.error,
          ),
          onChanged: bloc.changeEmail,
        ),
      );
    },
  );
 }

  Widget _crearPassword(RegistroBloc bloc) {
    
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return Container(
          padding: EdgeInsets.symmetric( horizontal: 20.0 ),

          child: TextField(
            controller: textControllerPassword,
            obscureText: visiblePassword2,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(icon1),
                onPressed: () {
                  if ( visiblePassword2 == true ) {
                    visiblePassword2 = false;
                    icon1 = Icons.visibility_off;
                    setState(() {});
                  } else {
                    visiblePassword2 = true;
                    icon1 = Icons.visibility;
                    setState(() {});
                  }
                }
              ),
              icon: Icon( Icons.lock_outline, color: Colors.deepPurple),
              labelText: 'Contraseña',
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );    
  }

  Widget _confirmarPassword(RegistroBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordConfirmationStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return Container(
          padding: EdgeInsets.symmetric( horizontal: 20.0 ),

          child: TextField(
            controller: textControllerPasswordConfirmation,
            obscureText: visiblePassword1,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(icon2),
                onPressed: () {
                  if ( visiblePassword1 == true ) {
                    visiblePassword1 = false;
                    icon2 = Icons.visibility_off;
                    setState(() {});
                  } else {
                    visiblePassword1 = true;
                    icon2 = Icons.visibility;
                    setState(() {});
                  }
                }
              ),
              icon: Icon( Icons.lock_outline, color: Colors.deepPurple),
              labelText: 'Confirmar contraseña',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePasswordConfirmation,
          ),
        );
      },
    );

    
  }

  Widget _crearBoton( BuildContext context, RegistroBloc bloc ) {

    return StreamBuilder(
      stream: bloc.formValiedStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

         return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0 ),
            child: Text('Registrar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: (snapshot.hasData && !_isLoading) ? (){
            _addNewUser(context);
          } : null
        );
      },
    );   
  }

  void _addNewUser(BuildContext context) async {
  
    setState(() {
      _isLoading = true;
    });

    var response = await usersProviders.addNewUser(
      nombre           : textControllerName.text,
      correo           : textControllerEmail.text,
      clave            : textControllerPassword.text,
      claveConfirmation: textControllerPasswordConfirmation.text,
    );

    if (response is User) {

      textControllerName.clear();
      textControllerEmail.clear();
      textControllerPassword.clear();
      textControllerPasswordConfirmation.clear();
      setState(() {});

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Icon(Icons.done, size: 35.0, color: Colors.green,),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
          content: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black,),
              children: [
                TextSpan(text: "Usuario creado exitosamente!\n"),
                TextSpan(text: 'Se le ha enviado un correo electronico para verificar su cuenta', style: TextStyle(fontWeight: FontWeight.w500)),
              ]
            ),
            textAlign: TextAlign.center,
          ),
        ),
        barrierDismissible: true,
      );

    } else if (response is ErrorUser){
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Icon(Icons.warning, size: 35.0, color: Colors.red),
          content: Text('error: ${response.name}, ${response.email}, ${response.password}'),
        ),
        barrierDismissible: true,
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Icon(Icons.warning, size: 35.0, color: Colors.red),
          content: Text('error: $response'),
        ),
        barrierDismissible: true,
      );
    }
    _isLoading = false;
  }

  _crearFondo( BuildContext context) {

    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
          ]
        )
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    final presentacion = Container(
      padding: EdgeInsets.only(top: 80.0),
      child: Column(
        children: <Widget>[
          Icon( Icons.bubble_chart, color: Colors.white, size: 100.0 ),
          SizedBox( width: double.infinity, height: 10),
          Text('Osonline', style: TextStyle( color: Colors.white, fontSize: 25.0 ))
        ],
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned( top: 90.0,  left:  30.0, child: circulo, ),
        Positioned( top: 250.0, left:  0.0,  child: circulo, ),
        Positioned( top: 120.0, right: 30.0, child: circulo, ),
        Positioned( top: -40.0, right: 70.0, child: circulo, ),
        presentacion,
      ],
    );
  }

}
import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/bloc/provider_bloc.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final prefs = new UserPreferences();

  final _emailController = TextEditingController();

  IconData icon        = Icons.visibility;
  bool visiblePassword = true;

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
           Text('Ingreso', style: TextStyle(fontSize: 20.0)),
           SizedBox( height: 60.0 ),
           _crearEmail(bloc),
           SizedBox( height: 30.0 ),
           _crearPassword(bloc),
            SizedBox( height: 30.0 ),
           _crearBoton(bloc),
         ],
       ),
      ),
        FlatButton(
       child: Text( 'Crear una nueva cuenta' ),
       onPressed: ()=> Navigator.pushReplacementNamed(context, 'registro'),
      ),
        SizedBox( height: 100.0 ),
      ],
    ),
  );
 }

 Widget _crearEmail(RegistroBloc bloc) {

  return StreamBuilder(
    stream: bloc.emailStreamLogin,
    builder: (BuildContext context, AsyncSnapshot snapshot){

      return Container(
        padding: EdgeInsets.symmetric( horizontal: 20.0 ),

        child: TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon( Icons.alternate_email, color: Colors.deepPurple),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo electronico',   
            errorText: snapshot.error
          ),
          onChanged: bloc.changeEmailLogin,
        ),
      );
    },
  );

  
  }

  Widget _crearPassword(RegistroBloc bloc) {
    
    return StreamBuilder(
      stream: bloc.passwordStreamLogin,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return Container(
          padding: EdgeInsets.symmetric( horizontal: 20.0 ),

          child: TextField(
            obscureText: visiblePassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(icon),
                onPressed: () {
                  if ( visiblePassword == true ) {
                    visiblePassword = false;
                    icon = Icons.visibility_off;
                    setState(() {});
                  } else {
                    visiblePassword = true;
                    icon = Icons.visibility;
                    setState(() {});
                  }
                }
              ),
              icon: Icon( Icons.lock_outline, color: Colors.deepPurple),
              labelText: 'Contraseña',
              errorText: snapshot.error
            ),
            onChanged: bloc.changePasswordLogin,
          ),
        );
      },
    );

    
  }

  Widget _crearBoton(RegistroBloc bloc) {

    final size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: bloc.formValiedStreamLogin,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return Container(
          width: size.width * 0.6,
          height: 45.0,

          child: RaisedButton(
            child: Text('Ingresar'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
            ),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () {
              prefs.userEmail = _emailController.text;
              Navigator.pushReplacementNamed(context, 'home');
            } : null
          ),
        );
      },
    );

    
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
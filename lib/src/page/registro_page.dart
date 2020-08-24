import 'package:flutter/material.dart';

class RegistroPage extends StatelessWidget {
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
                _registrarNombre(),
                SizedBox( height: 30.0 ),
                _crearEmail(),
                SizedBox( height: 30.0 ),
                _crearPassword(),
                SizedBox( height: 30.0 ),
                _confirmarPassword(),
                SizedBox( height: 30.0 ),
                _crearBoton(),
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

 Widget _confirmarPassword() {
    return Container(
       padding: EdgeInsets.symmetric( horizontal: 20.0 ),

       child: TextField(
         obscureText: true,
         decoration: InputDecoration(
           icon: Icon( Icons.lock_outline, color: Colors.deepPurple),
           labelText: 'Confirmar contraseña'
         ),
       ),
     );
  }

 Widget _registrarNombre() {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20.0 ),

      child: TextField(
          decoration: InputDecoration(
            icon: Icon( Icons.person_pin, color: Colors.deepPurple),
            hintText: 'Juan Miguel Gómez Pérez',
            labelText: 'Nombre completo',
        ),
      ),
    );
  }

 Widget _crearEmail() {

  return Container(
    padding: EdgeInsets.symmetric( horizontal: 20.0 ),

    child: TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon( Icons.alternate_email, color: Colors.deepPurple),
        hintText: 'ejemplo@correo.com',
        labelText: 'Correo electronico',   
      ),
    ),
   );
  }

  Widget _crearPassword() {
    
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20.0 ),

      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon( Icons.lock_outline, color: Colors.deepPurple),
          labelText: 'Contraseña',
        ),

      ),
    );
  }

  Widget _crearBoton() {

    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0 ),
        child: Text('Ingresar'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 0.0,
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: (){}
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
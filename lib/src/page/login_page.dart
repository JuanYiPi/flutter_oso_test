import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/bloc/provider_bloc.dart';
import 'package:flutter_oso_test/src/models/user_model.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import 'package:flutter_oso_test/src/providers/users_providers.dart';

import 'package:flutter_oso_test/src/constants/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final prefs = new UserPreferences();
  final usersProviders = new UsersProviders();
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  IconData icon        = Icons.visibility;
  bool visiblePassword = true;
  bool _isLoading;

  @override
  void initState() { 
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo( context ),
          _loginForm( context ),
          _botonSkip( context ),
          _loadingIndicator()
        ],
      ),
    );
  }

  Widget _loadingIndicator() {
    if (_isLoading == true) {
      return Stack(
        children: [
          Container(color: Colors.white.withOpacity(0.85),),
          Center(child: CircularProgressIndicator(),),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _loginForm( BuildContext context ) {

  final bloc = Provider.of(context);
  final size = MediaQuery.of(context).size;

   return SingleChildScrollView(
    child: Column(
      children: <Widget>[

       SafeArea(
         child: Container(
          height: 250.0,
         )
       ),

       Container(
        width: size.width * 0.85,
        margin: EdgeInsets.symmetric( vertical: kDefaultPaddin * 1.5 ),
        padding: EdgeInsets.symmetric( vertical: kDefaultPaddin * 2.0 ),
        decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(10.0),
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
           SizedBox( height: kDefaultPaddin * 3.0 ),
           _crearEmail(context, bloc),
           SizedBox( height: kDefaultPaddin * 1.5 ),
           _crearPassword(context, bloc),
            SizedBox( height: kDefaultPaddin * 1.5 ),
           _crearCheckbox(),
            SizedBox( height: kDefaultPaddin * 1.5 ),
           _crearBoton(bloc),
         ],
       ),
      ),
        FlatButton(
       child: Text( 'Crear una nueva cuenta' ),
       onPressed: ()=> Navigator.pushReplacementNamed(context, 'registro'),
      ),
      ],
    ),
  );
 }

  Widget _crearEmail(BuildContext context, Blocs bloc) {

  return StreamBuilder(
    stream: bloc.emailStreamLogin,
    builder: (BuildContext context, AsyncSnapshot snapshot){

      return Container(
        padding: EdgeInsets.symmetric( horizontal: kDefaultPaddin ),

        child: TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon( Icons.alternate_email, color: Theme.of(context).primaryColor),
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

  Widget _crearPassword(BuildContext context, Blocs bloc) {
    
    return StreamBuilder(
      stream: bloc.passwordStreamLogin,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return Container(
          padding: EdgeInsets.symmetric( horizontal: kDefaultPaddin ),

          child: TextField(
            controller: _passwordController,
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
              icon: Icon( Icons.lock_outline, color: Theme.of(context).primaryColor),
              labelText: 'Contraseña',
              errorText: snapshot.error
            ),
            onChanged: bloc.changePasswordLogin,
          ),
        );
      },
    );

    
  }

  Widget _crearCheckbox(){

    return Container(
      padding: EdgeInsets.symmetric( horizontal: kDefaultPaddin ),

      child: CheckboxListTile(
        activeColor: Theme.of(context).primaryColor,
        title: Text('Recordarme'),
        value: _rememberMe,
        onChanged: (valor){
          setState(()=> _rememberMe = valor);
        }
      ),
    );
  } 

  Widget _crearBoton(Blocs bloc) {

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
              borderRadius: BorderRadius.circular(kDefaultRadius)
            ),
            elevation: 0.0,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () {
              _login();
            } : null
          ),
        );
      },
    );

    
  }

  Widget _botonSkip( BuildContext context ) {

    return Container(
      
      child: Row(

        mainAxisAlignment: MainAxisAlignment.end,

        children: <Widget>[

          SafeArea(
            child: RaisedButton(
              child: Title(
                color: Colors.black,
                child: Text('Entrar como invitado')
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              elevation: 20.0,
              onPressed: (){
                prefs.id = 0;
                prefs.userEmail = "Sin registrar";
                prefs.userName  = "Invitado";
                Navigator.pushReplacementNamed(context, 'home');
              }
            ),
          ),

          SizedBox(width: kDefaultPaddin),

        ]
      ),


      
    );
  }

  _crearFondo( BuildContext context) {

    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.45,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            // Color.fromRGBO(63, 63, 156, 1.0),
            // Color.fromRGBO(90, 70, 178, 1.0),
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.98)
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
      padding: EdgeInsets.only(top: kDefaultPaddin * 5.0),
      child: Column(
        children: <Widget>[
          Container(
            width: size.width * 0.3,
            child: Image
            (image: AssetImage('assets/icon/oso-icon.png'))
          ),
          SizedBox( width: double.infinity, height: kDefaultPaddin / 2.0),
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

  void _login() async {

    setState(() {
      _isLoading = true;
    });

    var resp = await usersProviders.login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if ( resp is User ) {

      if (_rememberMe) prefs.rememberMe = true;
      
      prefs.id        = resp.id;
      prefs.userName  = resp.name;
      prefs.userEmail = resp.email;
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Icon(Icons.warning, size: 35.0, color: Colors.red),
          content: Text('El correo o la contraseña son incorrectos'),
        ),
        barrierDismissible: true,
      );
    }
  }
}
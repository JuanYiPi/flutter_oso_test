import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/error_user_model.dart';
import 'package:flutter_oso_test/src/models/user_model.dart';

import 'package:flutter_oso_test/src/providers/users_providers.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class UpdateMyDataPage extends StatefulWidget {
  @override
  _UpdateMyDataPageState createState() => _UpdateMyDataPageState();
}

class _UpdateMyDataPageState extends State<UpdateMyDataPage> {

  final userProvider = new UsersProviders();
  final prefs        = new UserPreferences();
  String name;
  String email;

  @override
  void initState() { 
    super.initState();
    name  = prefs.userName;
    email = prefs.userEmail;
  }
  
  @override
  Widget build(BuildContext context) {

    final queryData = MediaQuery.of(context);

    return FutureBuilder(
      future: userProvider.getUserById( prefs.idUsuario.toString() ),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Modificar mis datos'),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Container(
                height: queryData.size.height - 120, 
                child: Column(
                    children: <Widget>[
                      changeName(snapshot.data),
                      SizedBox(height: 20.0),
                      changeEmail(snapshot.data),
                      Expanded(child: Container()),
                      modificar(context, snapshot.data),
                      SizedBox(height: 10.0),
                      cancelar(context),
                    ],
                  ),
              ),
            ), 
          );
        } else {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
      },
    );
  }

  Widget changeName(User user) {

    return TextFormField(
      initialValue: name,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
       icon: Icon( Icons.person_pin, color: Theme.of(context).primaryColor),
       hintText: 'Juan Miguel Gómez Pérez',
       labelText: 'Nombre completo',
      ),
      onChanged: (value){
        setState(() {
          name = value;
        });
      },
    );
  }

  Widget changeEmail(User user) {

    return TextFormField(
      initialValue: email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon( Icons.alternate_email, color: Theme.of(context).primaryColor),
        hintText: 'ejemplo@correo.com',
        labelText: 'Correo electrónico',
      ),
      onChanged: (value){
        setState(() {
          email = value;
        });
      },
    );
  }

  Widget modificar(BuildContext context, User user) {

    final size = MediaQuery.of(context).size;  

    return Container(
      width: size.width * 0.6,
      height: 45.0,
      child: RaisedButton(
        child: Text('Modificar'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        // elevation: 0.0,
        color: kColorPrimario,
        textColor: Colors.white,
        onPressed: (name == prefs.userName && email == prefs.userEmail)? null : () {
          _updateUser(user, context);
        }, 
      ),
    );
  }

  _updateUser(User user, BuildContext context) async {
    var updatedUser = await userProvider.updateUser(
      email: email,
      name: name,
      id: user.id.toString()
    );

    if (updatedUser is User) {

      prefs.userName = updatedUser.name;
      prefs.userEmail = updatedUser.email;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Icon(Icons.done, size: 35.0, color: Colors.green,),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
          content: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black,),
              children: [
                TextSpan(text: "Sus datos se han actualizado exitosamente!"),
              ]
            ),
            textAlign: TextAlign.center,
          ),
        ),
        barrierDismissible: true,
      );

    } else if (updatedUser is ErrorUser){
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Icon(Icons.warning, size: 35.0, color: Colors.red),
          content: Text('error: ${updatedUser.name}, ${updatedUser.email}'),
        ),
        barrierDismissible: true,
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Icon(Icons.warning, size: 35.0, color: Colors.red),
          content: Text('error: $updatedUser'),
        ),
        barrierDismissible: true,
      );
    }
  }

  Widget cancelar(BuildContext context) {

    final size = MediaQuery.of(context).size;  

    return Container(
      width: size.width * 0.6,
      height: 45.0,
      child: RaisedButton(
        child: Text('Cancelar'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultRadius)
        ),
        // elevation: 0.0,
        color: kColorPrimario,
        textColor: Colors.white,
        onPressed: ()=> Navigator.pop(context)
      ),
    );
  }


}
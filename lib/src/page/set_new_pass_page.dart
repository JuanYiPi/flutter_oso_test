import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/components/custom_pass_tf.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/user_model.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import 'package:flutter_oso_test/src/providers/users_providers.dart';

class SetNewPassPage extends StatefulWidget {

  @override
  _SetNewPassPageState createState() => _SetNewPassPageState();
}

class _SetNewPassPageState extends State<SetNewPassPage> {

  final _passController = TextEditingController();
  final _rpassController = TextEditingController();
  final usersProvider = UsersProviders();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final prefs = UserPreferences();

  String msgError = '';
  String msgError2 = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87,), 
          onPressed: () => Navigator.pop(context)
        ),
        title: Text('Nueva clave', style: TextStyle(color: Colors.black87),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _msg('Introduce tu nueva contraseña'),
            _newPassword(),
            _msg('Repite tu contraseña'),
            _rnewPassword(),
            _saveButtom(),
            _loadingIndicator()
          ],
        ),
      )
    );
  }

  Widget _newPassword() {
    
    return Container(
      margin: EdgeInsets.only(bottom: 40.0),
      child: CustomPassTextField(
        passController: _passController,
        labelText: 'Contraseña',
        errorText: (msgError.length < 1) ? null : msgError,
        onTap: clearError,
      )
    );    
  }

  Widget _rnewPassword() {
    
    return Container(
      child: CustomPassTextField(
        passController: _rpassController,
        labelText: 'Confirmar contraseña',
        errorText: (msgError2.length < 1) ? null : msgError2,
        onTap: clearError,
      )
    );    
  }

  Widget _saveButtom() {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      child: RaisedButton(
        color: kColorPrimario,
        textColor: Colors.white,
        child: Text('Guardar'),
        onPressed: (_isLoading) ? null : verifyPass
      ),
    );
  }

  Widget _msg(String msg) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.0),
      child: Text(msg, style: TextStyle(fontSize: 18.0),),
    );
  }

  Widget _loadingIndicator() {
    if (_isLoading == true) {
      return Container(
        margin: EdgeInsets.only(top: 40.0),
        height: 60.0,
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Container();
    }
  }

  void clearError() {
    setState(() {
      msgError = '';
      msgError2 = '';
    });
  }

  void verifyPass() {
    if (_passController.text.length < 7) {
      setState(() {
        msgError = 'Mínimo 6 caracteres';
      });
    } else if (_passController.text != _rpassController.text) {
      setState(() {
        msgError2 = 'Las contraseñas no coinciden';
      });
    } else {
      print('contraseña actualizada');
      _updatePass();
    }
  }

  void _updatePass() async {
    setState(() {
      _isLoading = true;
    });
    final resp = await usersProvider.updateUser(
      pass: _passController.text.trim()
    );
    setState(() {
      _isLoading = false;
    });
    if ( resp is User ) {
      prefs.idUsuario = resp.id;
      prefs.userName  = resp.name;
      prefs.userEmail = resp.email;
      Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
    } else {
      _mostrarSnackbar('Algo salio mal, intentelo de nuevo más tarde', Colors.red);
    }
  }

  void _mostrarSnackbar(String text, Color color) {
    final snackbar = SnackBar(
      backgroundColor: color,
      content: Text(text),
      duration: Duration(milliseconds: 3000),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
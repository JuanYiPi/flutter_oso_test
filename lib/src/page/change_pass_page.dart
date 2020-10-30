import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/providers/users_providers.dart';

class ChangePassPage extends StatefulWidget {

  @override
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {

  final _emailController = TextEditingController();
  final usersProviders = UsersProviders();
  String _email = '';
  String _errorMsg = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87,), 
          onPressed: () => Navigator.pop(context)
        ),
        title: Text('Recupera tu clave', style: TextStyle(color: Colors.black87),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            _headText(),
            _emailBox(context),
            _sendButton(),
            _infoText(),
            _loadingIndicator()
          ],
        )
      )
    );
  }

  Container _emailBox(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: TextField(
        onTap: clearError,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon( Icons.alternate_email, color: Theme.of(context).primaryColor),
          hintText: 'ejemplo@correo.com',
          labelText: 'Correo electrónico',   
          errorText: (_errorMsg.length < 1) ? null : _errorMsg
        ),
        onChanged: (value) {
          setState(() {
            _email = value; 
          });
        },
      ),
    );
  }

  void clearError() {
    _errorMsg = '';
  }

  Container _headText() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        'Introduce la cuenta de correo electrónico asociada a tu cuenta',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget _infoText() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Text(
        'Al dar clic en enviar, un correo con un código de recuperación se enviará a la direccion de correo proporcionada',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget _sendButton() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: RaisedButton(
        onPressed: (_email.contains('@') && _email.contains('.') && !_isLoading) 
        ? _verificarEmail
        : null,
        color: kColorPrimario,
        textColor: Colors.white,
        child: Text('Enviar'),
      ),
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

  void _verificarEmail() async {
    setState(() {
      _isLoading = true;
    });
    final response = await usersProviders.getVerificationCode(_emailController.text.trim());
    setState(() {
      _isLoading = false;
    });
    print(response.toString());
    if (response != null) {
      Navigator.pushNamed(context, 'check_code', arguments: response);
    } else {
      _errorMsg = 'Este correo no esta registrado';
    }
    // Navigator.pushNamed(context, 'check_code', arguments: 1234);
  }
}
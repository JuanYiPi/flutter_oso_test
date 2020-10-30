import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';

class CheckCodePage extends StatefulWidget {

  @override
  _CheckCodePageState createState() => _CheckCodePageState();
}

class _CheckCodePageState extends State<CheckCodePage> {

  final codeController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final int code = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87,), 
          onPressed: () => Navigator.pop(context)
        ),
        title: Text('Verificación', style: TextStyle(color: Colors.black87),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            _infoMsg(context),
            _codeInput(context),
            _okButtom(code),
          ],
        )
      )
    );
  }

  Container _codeInput(BuildContext context) {
    return Container(
      child: TextField(
        controller: codeController,
        autofocus: true,
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 32.0),
        maxLength: 4,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {});
        },
      )
    );
  }

  Container _infoMsg(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30.0),
      child: Text(
        'Introduce el código de verifición que se envío al correo', 
        style: TextStyle(fontSize: 18.0),
      )
    );
  }

  Widget _okButtom(int code) {
    return Container(
      child: RaisedButton(
        color: kColorPrimario,
        textColor: Colors.white,
        child: Text('Confirmar'),
        onPressed: (codeController.text.length == 4) ?
          () => _verifyCode(code) : null
      ),
    );
  }

  void _verifyCode(int code) {
    if (code.toString() == codeController.text) {
      Navigator.of(context).pushNamed('set_new_pass');
    } else {
      codeController.clear();
      _mostrarSnackbar('Código invalido', Colors.red);
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
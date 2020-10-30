import 'package:flutter/material.dart';

class CustomPassTextField extends StatefulWidget {

  final String labelText;
  final String errorText;
  final Function onTap;
  
  CustomPassTextField({
    Key key,
    @required TextEditingController passController, 
    @required this.labelText, 
    this.errorText, 
    this.onTap,
  }) : _passController = passController, super(key: key);

  final TextEditingController _passController;

  @override
  _CustomPassTextFieldState createState() => _CustomPassTextFieldState();
}

class _CustomPassTextFieldState extends State<CustomPassTextField> {

  bool visiblePassword = true;
  IconData icon = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._passController,
      obscureText: visiblePassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(icon),
          onPressed: verifyVisibility,
        ),
        icon: Icon( Icons.lock_outline, color: Theme.of(context).primaryColor),
        labelText: widget.labelText,
        errorText: widget.errorText
      ),
      onTap: widget.onTap,
      // onChanged: (_) => widget.onChanged,
    );
  }

  void verifyVisibility() {
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
}
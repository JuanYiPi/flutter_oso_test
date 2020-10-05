import 'package:flutter/material.dart';

class DeleteButton extends StatefulWidget {

  final Function onDeleteSuccess;
  final Function onPress;

  DeleteButton({
    Key key, 
    this.onDeleteSuccess, 
    @required this.onPress
  }) : super(key: key);

  @override
  _DeleteButtonState createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {

  bool _isLoading;

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete, color: Colors.black38,), 
      onPressed: (_isLoading) ? null : _deleteFunction
    );
  }

  void _deleteFunction() async {
    setState(() {_isLoading = true;});
    await widget.onPress();
    setState(() {_isLoading = false;});
  }
}
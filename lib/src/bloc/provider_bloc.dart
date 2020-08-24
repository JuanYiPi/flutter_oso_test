import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/bloc/registro_bloc.dart';

class Provider extends InheritedWidget {

  final registroBloc = RegistroBloc();

  Provider({ Key key, Widget child })
    : super( key: key, child: child );
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static RegistroBloc of ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>().registroBloc;
  }
}
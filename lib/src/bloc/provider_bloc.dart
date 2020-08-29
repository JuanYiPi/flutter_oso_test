import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/bloc/blocs.dart';
export 'package:flutter_oso_test/src/bloc/blocs.dart';

class Provider extends InheritedWidget {

  final registroBloc = Blocs();

  Provider({ Key key, Widget child })
    : super( key: key, child: child );
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static Blocs of ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>().registroBloc;
  }
}
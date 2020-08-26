//Paquetes Dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Pages
import 'src/page/login_page.dart';
import 'src/page/registro_page.dart';
import 'src/page/update_my_data.dart';
import 'src/page/user_det_page.dart';
import 'package:flutter_oso_test/src/page/home_page.dart';

//Bloc 
import 'package:flutter_oso_test/src/bloc/provider_bloc.dart';

//Preferencias de Usuario
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userPrefs = new UserPreferences();
  await userPrefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent
    ));

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Oso test',
        initialRoute: 'login',
        routes: {
          'login'        :  ( BuildContext context ) => LoginPage(),
          'registro'     :  ( BuildContext context ) => RegistroPage(),
          'home'         :  ( BuildContext context ) => HomePage(),
          'user_det'     :  ( BuildContext context ) => UserDetPage(),
          'update_data'  :  ( BuildContext context ) =>UpdateMyDataPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      )
    );
  }
}
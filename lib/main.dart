//Paquetes Dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//Pages
import 'package:flutter_oso_test/src/page/shopping_cart_page.dart';
import 'src/page/categories_page.dart';
import 'src/page/det_compra_page.dart';
import 'src/page/det_product_page.dart';
import 'src/page/addresses_page.dart';
import 'src/page/login_page.dart';
import 'src/page/my_shopping.dart';
import 'src/page/products_by_category_page.dart';
import 'src/page/register_addresses_page.dart';
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
  await DotEnv().load('.env');
  final userPrefs = new UserPreferences();
  await userPrefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = new UserPreferences();
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent
    ));

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Oso online',
        initialRoute: prefs.rememberMe? 'home' : 'login',
        routes: {
          'login'              :  ( BuildContext context ) => LoginPage(),
          'registro'           :  ( BuildContext context ) => RegistroPage(),
          'home'               :  ( BuildContext context ) => HomePage(),
          'user_det'           :  ( BuildContext context ) => UserDetPage(),
          'update_data'        :  ( BuildContext context ) => UpdateMyDataPage(),
          'cat_page'           :  ( BuildContext context ) => CategoriesPage(),
          'det_product'        :  ( BuildContext context ) => DetProductPage(),
          'products_by_cat'    :  ( BuildContext context ) => ProductsByCategoryPage(),
          'shipping_addresses' :  ( BuildContext context ) => AddressesPage(),
          'register_addresses' :  ( BuildContext context ) => RegisterAddresses(),
          'my_shopping'        :  ( BuildContext context ) => MyShoppingPage(),
          'det_shopping'       :  ( BuildContext context ) => DetCompraPage(),
          'shopping_cart'      :  ( BuildContext context ) => ShoppingCartPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.teal,
        ),
      )
    );
  }
}
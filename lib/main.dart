//Paquetes Dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/page/add_comment_page.dart';
import 'package:flutter_oso_test/src/page/all_comments_page.dart';
import 'package:flutter_oso_test/src/page/buy_success.dart';
import 'package:flutter_oso_test/src/page/change_pass_page.dart';
import 'package:flutter_oso_test/src/page/choose_address_page.dart';
import 'package:flutter_oso_test/src/page/choose_branch_page.dart';
import 'package:flutter_oso_test/src/page/comment_done_page.dart';
import 'package:flutter_oso_test/src/page/confirm_buy_page.dart';
import 'package:flutter_oso_test/src/page/favorites_page.dart';
import 'package:flutter_oso_test/src/page/image_zoom.dart';
import 'package:flutter_oso_test/src/page/oxxo_reference_page.dart';
import 'package:flutter_oso_test/src/page/payment_method_page.dart';
import 'package:flutter_oso_test/src/page/purchase_det.dart';
import 'package:flutter_oso_test/src/page/check_code_page.dart';
import 'package:flutter_oso_test/src/page/set_new_pass_page.dart';
import 'package:flutter_oso_test/src/page/shipping_method_page.dart';

//Pages
import 'package:flutter_oso_test/src/page/shopping_cart_page.dart';
import 'src/page/categories_page.dart';
// import 'src/page/det_compra_page.dart';
import 'src/page/det_product_page.dart';
import 'src/page/addresses_page.dart';
import 'src/page/login_page.dart';
import 'src/page/my_purchases.dart';
import 'src/page/products_by_category_page.dart';
import 'src/page/register_addresses_page.dart';
import 'src/page/registro_page.dart';
import 'src/page/update_address.dart';
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
        initialRoute: 
        // 'choose_branch',
        prefs.rememberMe? (prefs.rutaAlmacen == ""? 'choose_branch' : 'home') : 'login',
        
        routes: {
          'login'              : ( BuildContext context ) => LoginPage(),
          'registro'           : ( BuildContext context ) => RegistroPage(),
          'home'               : ( BuildContext context ) => HomePage(),
          'user_det'           : ( BuildContext context ) => UserDetPage(),
          'update_data'        : ( BuildContext context ) => UpdateMyDataPage(),
          'cat_page'           : ( BuildContext context ) => CategoriesPage(),
          'det_product'        : ( BuildContext context ) => DetProductPage(),
          'products_by_cat'    : ( BuildContext context ) => ProductsByCategoryPage(),
          'shipping_addresses' : ( BuildContext context ) => AddressesPage(),
          'register_addresses' : ( BuildContext context ) => RegisterAddresses(),
          'my_shopping'        : ( BuildContext context ) => MyShoppingPage(),
          // 'det_shopping'       : ( BuildContext context ) => DetCompraPage(),
          'shopping_cart'      : ( BuildContext context ) => ShoppingCartPage(),
          'shipping'           : ( BuildContext context ) => ShippingMethod(),
          'address'            : ( BuildContext context ) => ChooseAddress(),
          'payment'            : ( BuildContext context ) => PaymentMethodPage(),
          'confirm'            : ( BuildContext context ) => ConfirmBuyPage(),
          'update_address'     : ( BuildContext context ) => UpdateAddress(),
          'finish'             : ( BuildContext context ) => BuySuccess(),
          'purchase_det'       : ( BuildContext context ) => PurchaseDetPage(),
          'favorites'          : ( BuildContext context ) => FavoritesPage(),
          'zoom'               : ( BuildContext context ) => ImageZoomPage(),
          'oxxo'               : ( BuildContext context ) => OxxoReferencePage(),
          'comments'           : ( BuildContext context ) => AllCommentsPage(),
          'add_comment'        : ( BuildContext context ) => AddCommentPage(),
          'comment_done'       : ( BuildContext context ) => CommentDonePage(),
          'change_pass'        : ( BuildContext context ) => ChangePassPage(),
          'check_code'         : ( BuildContext context ) => CheckCodePage(),
          'set_new_pass'       : ( BuildContext context ) => SetNewPassPage(),
          'choose_branch'      : ( BuildContext context ) => ChooseBranchPage(),
        },
        theme: ThemeData(
          primaryColor: kColorPrimario,
          scaffoldBackgroundColor: Color.fromRGBO(245, 245, 245, 1.0),
        ),
      )
    );
  }
}
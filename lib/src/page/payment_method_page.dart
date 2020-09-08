import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import 'package:flutter_oso_test/src/services/payment_service.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {

  final prefs = UserPreferences();
  final cartsProvider = CartsProvider();

  @override
  void initState() { 
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {

    final amount = ModalRoute.of(context).settings.arguments;

    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Metodo de pago'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView.separated(
          itemBuilder: (context, index) {
            Icon icon;
            Text text;

            switch(index) {
              case 0:
                icon = Icon(Icons.add_circle, color: theme.primaryColor,);
                text = Text('Pagar con una tarjeta nueva');
                break;
              case 1:
                icon = Icon(Icons.compare_arrows, color: theme.primaryColor,);
                text = Text('Pago a contra entrega');
                break;
            }

            return InkWell(
              child: ListTile(
                title: text,
                leading: icon,
                onTap: () {
                  onItemPress(context, index, amount);
                },
              ),
            );
          }, 
          separatorBuilder: (context, index) => Divider(
            color: theme.primaryColor,
          ), 
          itemCount: 2
        ),
      ),
    );
  }

  onItemPress(BuildContext context, int index, String amount) async {

    final total = amount.split('.');
    print('${total[0]}${total[1]}0');

    switch (index) {
      case 0:
        var response = await StripeService.payWithNewCard(
          amount: '${total[0]}${total[1]}0',
          currency: 'mxn'
        );

        if (response.success) {
          await cartsProvider.updateShoppingCart(
            // directionId: null,
            // cartId: prefs.idActiveCart.toString(),
            estado: 'Pagado'
          );
        }

        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(response.message),
            duration: new Duration(milliseconds: response.success == true ? 1200 : 3000),
          ),
        );

        break;
      case 1:
        // Navigator.pushNamed(context, 'cardPage');
        break;
    }
  }
}
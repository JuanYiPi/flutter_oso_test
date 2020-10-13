import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';
// import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import 'package:flutter_oso_test/src/services/payment_service.dart';

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {

  final cartsProvider = CartsProvider();

  @override
  void initState() { 
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {

    final String amount = ModalRoute.of(context).settings.arguments;

    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Método de pago'),
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
              case 2:
                icon = Icon(Icons.store, color: theme.primaryColor,);
                text = Text('Pago en tiendas OXXO');
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
          separatorBuilder: (context, index) => Divider(), 
          itemCount: 3
        ),
      ),
    );
  }

  onItemPress(BuildContext context, int index, String amount) async {

    final total = amount.split('.');
    print('${total[0]}${total[1]}0');

    switch (index) {
      case 0:
        await _payWithCard(total, context);
        break;

      case 1:
        await _payWhenReceive(context);
        break;
      
      case 2:
        Navigator.of(context).pushNamedAndRemoveUntil('oxxo', ModalRoute.withName('home'));
        break;
    }
  }

  Future _payWhenReceive(BuildContext context) async {
    final response = await cartsProvider.updateShoppingCart(
      estado: 'Pendiente de pago',
      payReference: 'No aplica'
    );
    if (response == true) {
      Navigator.of(context).pushNamedAndRemoveUntil('finish', ModalRoute.withName('home'));
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Algo salio mal, intente de nuevo más tarde'),
          duration: new Duration(milliseconds: 3000),
        ),
      );
    }
  }

  Future _payWithCard(List<String> total, BuildContext context) async {
    var response = await StripeService.payWithNewCard(
      amount: '${total[0]}${total[1]}0',
      currency: 'mxn'
    );
    
    if (response.success) {
      await cartsProvider.updateShoppingCart(
        estado: 'Pagado'
      );
      Navigator.of(context).pushNamedAndRemoveUntil('finish', ModalRoute.withName('home'));
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message),
          duration: new Duration(milliseconds: response.success == true ? 1200 : 3000),
        ),
      );
    }
  }
}
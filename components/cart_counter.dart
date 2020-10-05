import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';


class CartCounter extends StatefulWidget {

  final int stock;
  final Product product;

  const CartCounter({@required this.stock, @required this.product});

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {

  @override
  Widget build(BuildContext context) {

    int numOfItems = widget.product.cantidadCompra;

    return Row(
      children: <Widget>[

        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
                widget.product.cantidadCompra = numOfItems;
              });
            }
          },
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
          child: Text(
            numOfItems.toString().padLeft(2, '0'),
            style: Theme.of(context).textTheme.headline6
          ),
        ),

        buildOutlineButton(
          icon: Icons.add,
          press: () {
            if (numOfItems < widget.stock) {
              setState(() {
                numOfItems++;
                widget.product.cantidadCompra = numOfItems;
              });
            }
          }
        )
      ],
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40.0,
      height: 32.0,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
        onPressed: press,
        child: Icon(icon, color: kTextColor,),
      ),
    );
  }

}
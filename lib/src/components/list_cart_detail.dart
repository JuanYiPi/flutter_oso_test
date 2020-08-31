import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/cart_detail_model.dart';
import 'package:http/http.dart' as http;

class ListCartDetail extends StatelessWidget {
  
  final List<CartDetail> cartItems;

  const ListCartDetail({Key key, this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => _cartDetail(context, cartItems[index]),
      itemCount: cartItems.length,
    );
  }

  _cartDetail(BuildContext context, CartDetail cartItem) {

    final cardProduct = Card(
      elevation: 0.0,
      child: Container(
        height: 120.0,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: kDefaultPaddin/2,),
            _buildProductImg(cartItem),
            SizedBox(width: kDefaultPaddin/2,),
            _buildProductText(cartItem),
          ],
        ),
      ),
    );

    return GestureDetector(
      child: cardProduct,
      onTap: () {
        // Navigator.pushNamed(context, 'det_product', arguments: product);
      },
    );
  }

  Widget _buildProductText(CartDetail cartItem) {
    return Flexible(
      // width: screenSize.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // mostrar el nombre del producto
          Text(
            cartItem.descripcion.toLowerCase(),
            style: TextStyle(
              fontSize: 16.0,
              color: kTextColor,
            ),
          ),

          SizedBox(height: 15.0),

          // mostrar el precio del producto
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: (){}, 
                child: Text('Cantidad: ${cartItem.cantidad}', style: textoLight,)
              ),
              Text(
                '\$${cartItem.total}',
                style: priceLight,
              ),
            ],
          ),

          SizedBox(height: 8.0),

        ],
      ),
    );
  }

  ClipRRect _buildProductImg(CartDetail cartItem) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10.0),
      child: FutureBuilder(
        future: _checkUrl(cartItem.getImg()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != 200) {
              return Container(
                child: Image(image: AssetImage('assets/img/no_disponible.jpg')),
                height: 100.0,
                width: 100.0,
              );
            }
            return Container(
              height: 100.0,
              width: 100.0,
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'), 
                image: NetworkImage(cartItem.getImg()),
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Container(
              height: 100.0,
              width: 100.0,
              child: Image(
                image: AssetImage('assets/img/loading.gif'), 
                fit: BoxFit.cover,
              ),
            );
          }
        },
      ),
    );
  }

  Future<int> _checkUrl(String url) async {
    try {
      final response = await http.get(url);
      print(response.statusCode);
      return response.statusCode;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
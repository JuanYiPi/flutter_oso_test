import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/delete_button.dart';
import 'package:flutter_oso_test/src/components/server_image.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';

class FavoriteProductCard extends StatefulWidget {

  final Product product;
  final Function onPress;
  final Function onDelete;
  final Function onDeleteSuccess;

  FavoriteProductCard({
    Key key, 
    this.onPress, 
    this.product, 
    this.onDelete, 
    this.onDeleteSuccess
  }) : super(key: key);

  @override
  _FavoriteProductCardState createState() => _FavoriteProductCardState();
}

class _FavoriteProductCardState extends State<FavoriteProductCard> {

  bool _isLoading;

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final cardProduct = Card(
      elevation: 0.0,
      child: Container(
        padding: EdgeInsets.only(left:5.0),
        height: 120.0,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildProductImg(),
            SizedBox(width: kDefaultPaddin/2,),
            _buildProductText(context),
            _buildIcon(context)
          ],
        ),
      ),
    );

    final gesture = GestureDetector(
      onTap: widget.onPress,
      child: Dismissible(
        direction: DismissDirection.endToStart,
        key: UniqueKey(),
        background: Container(
          padding: EdgeInsets.only(right: 30.0),
          alignment: Alignment.centerRight,
          color: Colors.redAccent, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete, color: Colors.white),
              Text('Eliminar', style: TextStyle(color: Colors.white))
            ],
          )
        ),
        onDismissed: (_) async {
          await this.widget.onDelete();
        },
        child: cardProduct
      )
    );

    return Stack(
      children: [
        gesture,
        _loadingScreen()
      ],
    );
  }

  Widget _loadingScreen() {
    if (_isLoading) {
      return Container(
        height: 120.0,
        color: Colors.white70,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ); 
    } else {
      return Container();
    }
  }

  Widget _buildProductImg() {
    return ServerImage(
      width: 100.0, 
      heigt: 100.0, 
      imageUrl: widget.product.getImg()
    ); 
  }

  Expanded _buildProductText(BuildContext context) {

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // mostrar el nombre del producto
          Text(
            widget.product.descripcion.toLowerCase(),
            style: TextStyle(
              fontSize: 14.0,
              color: kTextColor,
            ),
          ),

          SizedBox(height: 15.0),

          // mostrar el precio del producto
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '\$${widget.product.getPrice()[0]}.', style: price.copyWith(fontSize: 20.0)),
                TextSpan(text: '${widget.product.getPrice()[1]}',style: price.copyWith(fontSize: 15.0)),
              ]
            )
          ),

          SizedBox(height: 8.0),

          Text(
            'Disponibilidad: ${widget.product.stock}',
            style: TextStyle(
              fontSize: 12.0,
              color: kTextGreenColor
            ),
          ),
        ],
      ),
    );
  }

  Column _buildIcon(BuildContext context) {
    return Column(
      children: <Widget>[
        DeleteButton(
          onPress: () async {
            setState(() {_isLoading = true;});
            await widget.onDelete();
            setState(() {_isLoading = false;});
          },
        ) 
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:photo_view/photo_view.dart';


class ImageZoomPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Product product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.clear), onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: PhotoView(
          minScale: 0.5,
          maxScale: 2.0,
          imageProvider: ( product.getImg() != null ) 
          ? NetworkImage(product.getImg())
          : Image.asset('assets/img/no_disponible.jpg')
        )
      ),
    );
  }
}
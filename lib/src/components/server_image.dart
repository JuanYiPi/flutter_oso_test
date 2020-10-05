import 'package:flutter/material.dart';

class ServerImage extends StatelessWidget {

  final double width;
  final double heigt;
  final String errorImagePath;
  final String imageUrl;
  final String placeholder;

  const ServerImage({
    Key key, 
    @required this.width, 
    @required this.heigt, 
    @required this.imageUrl,
    this.errorImagePath = 'assets/img/no_disponible.jpg', 
    this.placeholder = 'assets/img/loading.gif'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10.0),
      child: FadeInImage(
        imageErrorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
          print('Error Handler');
          return Container(
            width: this.width,
            height: this.heigt,
            child: Image.asset(this.errorImagePath),
          );
        },
        placeholder: AssetImage(this.placeholder), 
        image: (this.imageUrl != null)
          ? NetworkImage( this.imageUrl )
          : AssetImage(this.errorImagePath),
        fit: BoxFit.cover,
        height: this.heigt,
        width: this.width,
      ), 
    );
  }
}
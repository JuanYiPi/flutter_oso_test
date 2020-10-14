import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/comment_list.dart';

class CommentBox extends StatelessWidget {

  final List<Comment> comments;

  const CommentBox({
    Key key, 
    @required this.comments
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (this.comments.length == 0) {
      return Container(
        margin: EdgeInsets.only(bottom: 30.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Opiniones sobre el producto', 
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline6.copyWith(color: kTextColor)
              ),
            ),

            Text('Este producto no tiene comentarios todavia')
          ],
        ),
      );
    }

    final lista = List<Widget>.generate(
      (this.comments.length > 3) ? 3 : comments.length, (index) => UserComment(
        rating: comments[index].rating, 
        comment: comments[index].coment
      )
    );

    return Container(
      margin: EdgeInsets.only(bottom: 30.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Opiniones sobre el producto', 
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline6.copyWith(color: kTextColor)
            ),
          ),

          Column(children: lista),

          if (this.comments.length > 3)
          FlatButton(
            textColor: kColorPrimario,
            onPressed: () => Navigator.pushNamed(context, 'comments', arguments: this.comments), 
            child: Text('Ver más')
          )
        ],
      ),
    );
  }
}

class UserComment extends StatelessWidget {

  final int rating;
  final String comment;

  const UserComment({
    Key key, 
    @required this.rating, 
    @required this.comment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          ProductRating(rating: this.rating),
          Container(
            width: double.infinity,
            child: Text(this.comment, textAlign: TextAlign.left,)
          )
        ],
      ),
    );
  }
}

class ProductRating extends StatelessWidget {

  final int rating;

  const ProductRating({
    Key key, 
    @required this.rating
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final puntuacion = List<Widget>.generate(
      this.rating, (index) => Icon(Icons.star, color: Colors.deepPurple[400])
    );

    final fondo = List<Widget>.generate(
      5, (index) => Icon(Icons.star, color: Colors.black12,)
    );

    return Container(
      margin: EdgeInsets.only(bottom: 6.0),
      child: Stack(
        children: [
          Row(
            children: fondo
          ),
          Row(
            children: puntuacion
          ),
        ],
      ),
    );
  }
}
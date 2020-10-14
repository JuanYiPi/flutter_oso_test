import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/comment_box.dart';
import 'package:flutter_oso_test/src/models/comment_list.dart';

class AllCommentsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final List<Comment> comments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Comentarios del producto')
      ),
      body: _body(comments)
    );
  }

  _body(List<Comment> comments) {
    return ListView.builder(
      padding: EdgeInsets.all(20.0),
      itemBuilder: (context, index) => UserComment(
        rating: comments[index].rating, 
        comment: comments[index].coment
      ),
      itemCount: comments.length,
    );
  }
}
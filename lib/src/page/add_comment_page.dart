import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/cart_compuesto.dart';
import 'package:flutter_oso_test/src/providers/products_provider.dart';


class AddCommentPage extends StatefulWidget {

  @override
  _AddCommentPageState createState() => _AddCommentPageState();
}

class _AddCommentPageState extends State<AddCommentPage> {

  int _rating = 0;
  bool _isLoading = false;

  final textController = TextEditingController();
  final productsProvider = ProductsProvider();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final CartDetail product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar una opinión')
      ),
      body: _buildBody(context, product)
    );
  }

  Widget _buildBody(BuildContext context, CartDetail product) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _productRating(),
              _sendButtom(product)
            ],
          ),
        ),
      ),
    ); 
  }

  Widget _productRating() {

    final puntuacion = List<Widget>.generate(
      5, (index) => GestureDetector(
        onTap: () {
          setState(() {
            _rating = index + 1;
          });
        },
        child: Icon(
          Icons.star, 
          color: (index + 1 > _rating) ? Colors.black12 : Colors.deepPurple[400], 
          size: 40.0,
        )
      )
    );

    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                '¿Qué puntuación le darías?', 
                style: Theme.of(context).textTheme.headline6.copyWith(color: kTextColor),
              )
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: puntuacion
              ),
            ),

            if (_rating > 0) Container(
              margin: EdgeInsets.only(top: 20.0),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: '¿Qué te pareció el producto?',
                  border: OutlineInputBorder()
                ),
                controller: textController,
                maxLines: null,
                maxLength: 255,
                textInputAction: TextInputAction.done,
              )
            ),
          ],
        ),
      )
    );
  }

  Widget _sendButtom(CartDetail product) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultRadius)
      ),
      height: 45.0,
      child: RaisedButton(
        color: kColorPrimario,
        textColor: Colors.white,
        elevation: 0.0,
        onPressed: (_isLoading || _rating < 1 || textController.text.length < 10)
          ? null : () => _sendComment(product),
        child: Text('Enviar opinión'),
      ),
    );
  }

  Future _sendComment(CartDetail product) async {
    setState(() {
      _isLoading = true;
    });
    final done = await productsProvider.addComment(
      rating: _rating,
      comment: textController.text,
      productId: product.idProductoCodigo
    );
    setState(() {
      _isLoading = false;
    });
    
    if (done == true) {
      Navigator.pushReplacementNamed(context, 'comment_done');
    } else {
      _mostrarSnackbar('Algo salio mal, inténtelo de nuevo más tarde', Colors.red);
    }
  }

  void _mostrarSnackbar(String text, Color color) {
    final snackbar = SnackBar(
      backgroundColor: color,
      content: Text(text),
      duration: Duration(milliseconds: 2000),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}

// class AddRating extends StatefulWidget {

//   final ValueChanged<int> onChanged;
//   final ValueChanged<String> onCommentChanged;

//   AddRating({
//     Key key, 
//     this.onChanged, 
//     this.onCommentChanged
//   }) : super(
//     key: key
//   );

//   @override
//   _AddRatingState createState() => _AddRatingState();
// }

// class _AddRatingState extends State<AddRating> {

//   int rating = 0;
//   final textController = TextEditingController();
//   final focusNodeText = FocusNode();

//   @override
//   Widget build(BuildContext context) {

//     final puntuacion = List<Widget>.generate(
//       5, (index) => GestureDetector(
//         onTap: () {
//           setState(() {
//             rating = index + 1;
//             widget.onChanged(rating);
//           });
//           FocusScope.of(context).requestFocus(focusNodeText);
//         },
//         child: Icon(
//           Icons.star, 
//           color: (index + 1 > rating) ? Colors.black12 : Colors.deepPurple[400], 
//           size: 40.0,
//         )
//       )
//     );

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20.0),
//       child: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.only(bottom: 10.0),
//             child: Text(
//               '¿Qué puntuación le darías?', 
//               style: Theme.of(context).textTheme.headline6.copyWith(color: kTextColor),
//             )
//           ),
//           Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: puntuacion
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: 20.0),
//             child: TextField(
//               focusNode: focusNodeText,
//               decoration: InputDecoration(
//                 hintText: '¿Qué te pareció el producto?',
//                 border: OutlineInputBorder()
//               ),
//               controller: textController,
//               maxLines: null,
//               maxLength: 150,
//               readOnly: (rating > 0) ? false : true,
//               onChanged: (value) {
//                 widget.onCommentChanged(value);
//               },
//               textInputAction: TextInputAction.done,
//             )
//           ),
//         ],
//       ),
//     );
//   }
// }
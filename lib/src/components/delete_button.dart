import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/providers/favorites_provider.dart';

class DeleteButton extends StatefulWidget {

  final Function onDelete;
  final String productId;

  DeleteButton({
    Key key, 
    this.onDelete, 
    @required this.productId
  }) : super(key: key);

  @override
  _DeleteButtonState createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {

  final favsProvider = FavoritesProvider();
  bool isLoading;

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete, color: Colors.black38,), 
      onPressed: (isLoading) ? null : () async {
        setState(() {
          isLoading = true;
        });
        await favsProvider.deleteFavorite(widget.productId);
        setState(() {
          isLoading = false;
        });
        widget.onDelete();
      }
    );
  }
}
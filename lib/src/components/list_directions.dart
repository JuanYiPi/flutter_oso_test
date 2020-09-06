import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/direction_model.dart';
import 'package:flutter_oso_test/src/providers/directions_provider.dart';

class ListAllDirections extends StatelessWidget {

  final List<Direction> directions;

  final directionsProvider = new DirectionsProvider();
  
  ListAllDirections({@required this.directions});

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      itemBuilder: (context, index) {
        return _catIndividual(context, directions[index]);
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: directions.length
    );
  }

  Widget _catIndividual(BuildContext context, Direction direction) {

    return Dismissible(
      key: UniqueKey(),

      background: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.redAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.delete, color: Colors.white),
            Icon(Icons.delete, color: Colors.white)
          ],
        )
      ),
      onDismissed: (dir) {
        directionsProvider.deleteDirections(direction.id.toString());
      },
      child: ListTile(
        title:  RichText(
          text: TextSpan(
            children: [
              TextSpan(text: '${direction.street}\n', style: Theme.of(context).textTheme.subtitle1),
              TextSpan(text: '${direction.zip} - ${direction.colony} - ${direction.city}\n', style: Theme.of(context).textTheme.subtitle1.copyWith(color: kTextLightColor)),
              TextSpan(text: '${direction.receive} - ${direction.receivePhone}\n', style: Theme.of(context).textTheme.subtitle1.copyWith(color: kTextLightColor)),
            ]
          )
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/direction_model.dart';

class ListAllDirections extends StatelessWidget {

  final List<Direction> directions;

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

    return ListTile(
      title:  RichText(
        text: TextSpan(
          children: [
            TextSpan(text: '${direction.street}\n', style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: '${direction.zip} - ${direction.colony} - ${direction.city}\n', style: Theme.of(context).textTheme.subtitle1.copyWith(color: kTextLightColor)),
            TextSpan(text: '${direction.receive} - ${direction.receivePhone}\n', style: Theme.of(context).textTheme.subtitle1.copyWith(color: kTextLightColor)),
          ]
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/user_model.dart';
import 'package:flutter_oso_test/src/providers/users_providers.dart';


class UserDetPage extends StatefulWidget {
  @override
  _UserDetPageState createState() => _UserDetPageState();
}

class _UserDetPageState extends State<UserDetPage> {

  final usersProviders = UsersProviders();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final int userId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Navigator.pop(context, true);}),
        // centerTitle: true,
        title: Text('Mi cuenta'),
      ),
      body: FutureBuilder(
        future: usersProviders.getUserById(userId.toString()),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return buildBody(snapshot.data, context);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ), 
    );
  }

  Container buildBody(User user, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: double.infinity,
      child: Column(
        children: [
          myData(context),
          Divider(),
          shippingAddresses(),
          Divider(),
          billingData(),
          Divider(),
          changePassword(),
          Divider(),
        ],
      ),
    );
  }

  Widget myData(BuildContext context){

    return ListTile(
      leading: Icon(Icons.person),
      title: Text('Mis datos'),
      trailing: Icon(Icons.chevron_right, color: kColorPrimario),
      onTap: ()=> Navigator.pushNamed(context, 'update_data'),
    );
  }

  Widget shippingAddresses(){
    
    return ListTile(
      leading: Icon(Icons.home),
      title: Text('Mis direcciones de envío'),
      trailing: Icon(Icons.chevron_right, color: kColorPrimario),
      onTap: ()=> Navigator.pushNamed(context, 'shipping_addresses'),
    );
  }

  Widget billingData(){

    return ListTile(
      leading: Icon(Icons.note),
      title: Text('Mis datos de facturación'),
      trailing: Icon(Icons.chevron_right, color: kColorPrimario),
      onTap: (){},
    );
  }

  Widget changePassword(){

    return ListTile(
      leading: Icon(Icons.lock),
      title: Text('Cambiar contraseña'),
      trailing: Icon(Icons.chevron_right, color: kColorPrimario),
      onTap: (){},
    );
  }

}

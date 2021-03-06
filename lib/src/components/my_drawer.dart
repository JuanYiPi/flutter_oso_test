import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class MyDrawer extends StatefulWidget {

  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  final prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child:ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              color: kColorPrimario,
            ),
            child: Stack(
              children: [
                _buildFondo(),
                Center(
                  child: prefs.idUsuario != 0 ?
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.white.withOpacity(0.5),
                    child: Text(prefs.userName.substring(0,2), style: Theme.of(context).textTheme.headline3,),
                  ) : Icon(Icons.person, size: 120.0,color:  Colors.white,)
                )                    
              ],
            ),
            // ),
          ),

          if (prefs.idUsuario != 0) ListTile(
            onTap: ()=> Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false),
            leading: Icon(Icons.home),
            title: Text('Inicio'),
          ),

          if (prefs.idUsuario != 0) ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'favorites');
            },
            leading: Icon(Icons.star),
            title: Text('Favoritos'),
          ),

          if (prefs.idUsuario != 0) ListTile(
            onTap: () => Navigator.pushNamed(context, 'my_shopping'),
            leading: Icon(Icons.shopping_basket),
            title: Text('Mis compras'),
          ),

          if (prefs.idUsuario != 0) ListTile(
            onTap: () => Navigator.pushNamed(context, 'user_det', arguments: prefs.idUsuario),
            leading: Icon(Icons.account_circle,),
            title: Text('Mi cuenta'),
          ),

          if (prefs.idUsuario != 0) ListTile(
            onTap: () {},
            leading: Icon(Icons.notifications),
            title: Text('Notificaciones'),
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: prefs.idUsuario == 0? Text('Iniciar sesión') : Text('Cerrar sesión'),
            onTap: () {
              prefs.rememberMe = false;
              Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
            },
          ),
        ],
      )  
    );
  }

  Widget _buildFondo() {

    final circuloA = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white30,
      ),
      height: 45.0,
      width: 45.0,
    );
    final circuloB = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white30,
      ),
      height: 25.0,
      width: 25.0,
    );
    final circuloC = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white30,
      ),
      height: 125.0,
      width: 125.0,
    );

    return Stack(
      children: [
        Positioned(child: circuloA, left: 20, top: 20,),
        Positioned(child: circuloB, left: 50, top: 50,),
        Positioned(child: circuloB, right: -5, bottom: 50,),
        Positioned(child: circuloC, right: -35, bottom: -60,),
      ],
    );
  }
}
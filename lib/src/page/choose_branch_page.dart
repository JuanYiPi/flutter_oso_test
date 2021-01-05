import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/branches_model.dart';
import 'package:flutter_oso_test/src/providers/branches_provider.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';


class ChooseBranchPage extends StatelessWidget {

  final branchesProvider = BranchesProvider();
  final userPrefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona una tienda'),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  FutureBuilder<Branches> _buildBody() {
    return FutureBuilder(
      future: branchesProvider.getBranches(),
      builder: (BuildContext context, AsyncSnapshot<Branches> snapshot) {

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }

        final branches = snapshot.data;

        return ListView(
          children: [
            _infoText(),
            _buildBranches(context, branches)
          ],
        );
      }
    );
  }

  Container _infoText() {
    return Container(
      alignment: Alignment.center,
      height: 60.0,
      child: Text('Puedes cambiar la sucursal seleccionada después', style: texto, textAlign: TextAlign.center,),
    );
  }

  Widget _buildBranches(BuildContext context, Branches branches) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: branches.data.map((branch) =>
        ListTile(
          title: Text(branch.nombreWeb),
          subtitle: Text(branch.municipio),
          leading: Icon(Icons.store),
          trailing: Icon(Icons.navigate_next),
          onTap: (){
            userPrefs.idBranch = branch.idAlmacen;
            userPrefs.rutaAlmacen = branch.identificadorWeb;
            print(userPrefs.idBranch.toString());
            print(userPrefs.rutaAlmacen);
          },
        )).toList()
      ),
    );
  }

}
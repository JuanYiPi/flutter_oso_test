import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/bloc/provider_bloc.dart';

import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/direction_model.dart';
import 'package:flutter_oso_test/src/providers/directions_provider.dart';

class RegisterAddresses extends StatefulWidget {

  @override
  _RegisterAddressesState createState() => _RegisterAddressesState();
}

final directionsProvider = new DirectionsProvider();

class _RegisterAddressesState extends State<RegisterAddresses> {

  final textControllerNombre            = TextEditingController();
  final textControllerCodigoPostal      = TextEditingController();
  final textControllerPais              = TextEditingController();
  final textControllerEstado            = TextEditingController();
  final textControllerMunicipio         = TextEditingController();
  final textControllerColina            = TextEditingController();
  final textControllerCalle             = TextEditingController();
  final textControllerNomExterior       = TextEditingController();
  final textControllerNomInterior       = TextEditingController();
  final textControllerTelefonoContacto  = TextEditingController();
  final textControllerReferencia        = TextEditingController();

  @override
  void dispose() { 
    textControllerNombre.dispose();
    textControllerCodigoPostal.dispose();
    textControllerPais.dispose();
    textControllerEstado.dispose();
    textControllerMunicipio.dispose();
    textControllerColina.dispose();
    textControllerCalle.dispose();
    textControllerNomExterior.dispose();
    textControllerNomInterior.dispose();
    textControllerTelefonoContacto.dispose();
    textControllerReferencia.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;  
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registrar una dirección de envio'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        child: Column(
          children: <Widget>[
            nombre(bloc),
            SizedBox( height: kDefaultPaddin ),
            codigoPostal(bloc),
            SizedBox( height: kDefaultPaddin ),
            pais(bloc),
            SizedBox( height: kDefaultPaddin ),
            estado(bloc),
            SizedBox( height: kDefaultPaddin ),
            municipio(bloc),
            SizedBox( height: kDefaultPaddin ),
            colonia(bloc),
            SizedBox( height: kDefaultPaddin ),
            calle(bloc),
            SizedBox( height: kDefaultPaddin ),
            nomExterior(bloc),
            SizedBox( height: kDefaultPaddin ),
            nomInterior(),
            SizedBox( height: kDefaultPaddin ),
            telefonoContacto(bloc),
            SizedBox( height: kDefaultPaddin ),
            referencia(),
            SizedBox( height: kDefaultPaddin ),
            guardar(context, size, bloc),
            SizedBox( height: kDefaultPaddin / 2 ),
            cancelar(context, size),
          ],
        ),
      ),
    );
  }

  Widget nombre(Blocs bloc){

    return StreamBuilder(
      stream: bloc.completeNameStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return TextField(
          controller: textControllerNombre,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: 'Nombre y apellido',
            helperText: 'Tal cual figure en el INE o IFE',
            errorText: snapshot.error
          ),
          onChanged: bloc.changeCompleteName,
        );
      },
    );
  }

  Widget codigoPostal(Blocs bloc){

    return StreamBuilder(
      stream: bloc.codigoPostalStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return TextField(
          controller: textControllerCodigoPostal,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Código postal',
            errorText: snapshot.error
          ),
          onChanged: bloc.changeCodigoPostal,
        );
      },
    );
  }

  Widget pais(Blocs bloc){

    return StreamBuilder(
      stream: bloc.paisStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return TextField(
          controller: textControllerPais,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: 'Pais',
          ),
          onChanged: bloc.changePais,
        );
      },
    );
  }

  Widget estado(Blocs bloc){

    return StreamBuilder(
      stream: bloc.estadoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return TextField(
          controller: textControllerEstado,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: 'Estado',
          ),
          onChanged: bloc.changeEstado,
        );
      },
    );
  }

  Widget municipio(Blocs bloc){

    return StreamBuilder(
      stream: bloc.municipioStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return TextField(
          controller: textControllerMunicipio,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: 'Delegación / Municipio',
          ),
          onChanged: bloc.changeMunicipio,
        );
      },
    );     
  }

  Widget colonia(Blocs bloc){

    return StreamBuilder(
      stream: bloc.coloniaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
      
        return TextField(
          controller: textControllerColina,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: 'Colonia',
          ),
          onChanged: bloc.changeColonia,
        );
      },
    );
  }

  Widget calle(Blocs bloc){

    return StreamBuilder(
      stream: bloc.calleStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return TextField(
          controller: textControllerCalle,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: 'Calle',
          ),
          onChanged: bloc.changeCalle,
        );
      },
    );   
  }

  Widget nomExterior(Blocs bloc){

    return StreamBuilder(
      stream: bloc.numeroExteriorStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return TextField(
          controller: textControllerNomExterior,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Número exterior',
          ),
          onChanged: bloc.changeNumeroExterior,
        );
      },
    );
  }

  Widget nomInterior(){

    return TextField(
      controller: textControllerNomInterior,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'N° interior / Depto (opcional)',
      ),
    );
  }

  Widget telefonoContacto(Blocs bloc){

    return StreamBuilder(
      stream: bloc.telefonoContactoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return TextField(
          controller: textControllerTelefonoContacto,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Teléfono de contacto',
            hintText: 'Ej: 222 1234567',
            helperText: 'Llamarán a este número si hay algún problema en el envío',
            errorText: snapshot.error
          ),
          onChanged: bloc.changeTelefonoContacto,
        );
      },
    );
  }

  Widget referencia(){

     return TextField(
      controller: textControllerReferencia,
      textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
        labelText: 'Referencia',
      ),
    );
  }  

  Widget guardar( BuildContext context, Size size, Blocs bloc){

    return StreamBuilder(
      stream: bloc.formValiedStreamDirecciones,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return Container(

          height: 45.0,
          width: size.width * 0.6,
          child: RaisedButton(
          
            child: Text('Guardar'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? (){
              _addNewDirection(context);
            } : null
          ),
        );
      },
    );

    
  }

  cancelar(BuildContext context, Size size) {

    return Container(

      height: 45.0,
      width: size.width * 0.6,
      child: RaisedButton(
      
        child: Text('Cancelar'),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: ()=>Navigator.pop(context),
      ),
    );
  }

  void _addNewDirection(BuildContext context) async {

    final direction = new Direction(
      type: 1,
      userId: 15,
      receive: textControllerNombre.text,
      receivePhone: textControllerTelefonoContacto.text,
      street: textControllerCalle.text,
      numberExt: textControllerNomExterior.text,
      numberInt: textControllerNomInterior.text,
      zip: int.parse(textControllerCodigoPostal.text),
      colony: textControllerColina.text,
      city: textControllerMunicipio.text,
      state: textControllerEstado.text,
      country: textControllerPais.text,
      reference: textControllerReferencia.text,
    );

    var response = await directionsProvider.addNewDirection(direction);

    if ( response is Direction ) {
      textControllerNombre.clear();
      textControllerCodigoPostal.clear();
      textControllerPais.clear();
      textControllerEstado.clear();
      textControllerMunicipio.clear();
      textControllerColina.clear();
      textControllerCalle.clear();
      textControllerNomExterior.clear();
      textControllerNomInterior.clear();
      textControllerTelefonoContacto.clear();
      textControllerReferencia.clear();
      return Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Icon(Icons.warning, size: 35.0, color: Colors.red),
          content: Text('error: $response'),
        ),
        barrierDismissible: true,
      );
    }

  }
}
import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/direction_model.dart';
import 'package:flutter_oso_test/src/providers/directions_provider.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class UpdateAddress extends StatefulWidget {

  @override
  _UpdateAddressState createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {

  final directionsProvider = new DirectionsProvider();
  final prefs = UserPreferences();

  String receive;
  String zip;
  String country;
  String state;
  String city;
  String colony;
  String street;
  String numberExt;
  String numberInt;
  String receivePhone;
  String reference;

  @override
  Widget build(BuildContext context) {

    final direction = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;  
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Modificar la dirección de envio'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        child: Column(
          children: <Widget>[
            nombre(direction),
            SizedBox( height: kDefaultPaddin ),
            telefonoContacto(direction),
            SizedBox( height: kDefaultPaddin ),
            calle(direction),
            SizedBox( height: kDefaultPaddin ), 
            nomExterior(direction),
            SizedBox( height: kDefaultPaddin ),
            nomInterior(direction),
            SizedBox( height: kDefaultPaddin ),
            colonia(direction),
            SizedBox( height: kDefaultPaddin ),
            codigoPostal(direction),
            SizedBox( height: kDefaultPaddin ),
            municipio(direction),
            SizedBox( height: kDefaultPaddin ),           
            estado(direction),
            SizedBox( height: kDefaultPaddin ),
            pais(direction),
            SizedBox( height: kDefaultPaddin ),
            referencia(direction),
            SizedBox( height: kDefaultPaddin ),
            guardar(context, size, direction),
            SizedBox( height: kDefaultPaddin / 2 ),
            cancelar(context, size),
          ],
        ),
      ),
    );
  }

  Widget nombre(Direction direction){
    return TextFormField(
      initialValue: direction.receive,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: 'Nombre y apellido de quien recibe',
        helperText: 'Tal cual se muestra en el INE',
      ),
      onChanged: (value)=> receive = value,
    );
      
  }

  Widget codigoPostal(Direction direction){
    return TextFormField(
      initialValue: direction.zip.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Código postal',
      ),
      onChanged: (value)=> zip = value
    );
      
  }

  Widget pais(Direction direction){
    return TextFormField(
      initialValue: direction.country,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: 'Pais',
      ),
      onChanged: (value)=> country = value
    );
  }

  Widget estado(Direction direction){
    return TextFormField(
      initialValue: direction.state,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: 'Estado',
      ),
      onChanged: (value)=> state = value
    );
  }

  Widget municipio(Direction direction){
    return TextFormField(
      initialValue: direction.city,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Delegación / Municipio',
      ),
      onChanged: (value)=> city = value
    );  
  }

  Widget colonia(Direction direction){   
    return TextFormField(
      initialValue: direction.colony,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: 'Colonia',
      ),
      onChanged: (value)=> colony = value
    );
  }

  Widget calle(Direction direction){
    return TextFormField(
      initialValue: direction.street,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: 'Calle',
      ),
      onChanged: (value)=> street = value
    );
  }

  Widget nomExterior(Direction direction){
    return TextFormField(
      initialValue: direction.numberExt,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Número exterior',
      ),
      onChanged: (value)=> numberExt = value
    );
  }

  Widget nomInterior(Direction direction){
    return TextFormField(
      initialValue: direction.numberInt,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'N° interior / Depto (opcional)',
      ),
      onChanged: (value)=> numberInt = value
    );
  }

  Widget telefonoContacto(Direction direction){
    return TextFormField(
      initialValue: direction.receivePhone,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Teléfono de contacto',
        hintText: 'Ej: 222 1234567',
        helperText: 'Llamarán a este número si hay algún problema en el envío',
      ),
      onChanged: (value)=> receivePhone = value
    );
  }

  Widget referencia(Direction direction){
    return TextFormField(
      initialValue: direction.reference,
      textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
        labelText: 'Referencia',
      ),
      onChanged: (value)=> reference = value
    );
  }  

  Widget guardar( BuildContext context, Size size, Direction direction ){
    return Container(
      height: 45.0,
      width: size.width * 0.6,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kDefaultRadius)),
        child: Text('Modificar'),
        color: kColorSecundario,
        textColor: Colors.white,
        onPressed: (){
          _updateDirection(context, direction.id);
        }
      ),
    );    
  }

  cancelar(BuildContext context, Size size) {

    return Container(

      height: 45.0,
      width: size.width * 0.6,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kDefaultRadius)),
        child: Text('Cancelar'),
        color: kColorSecundario,
        textColor: Colors.white,
        onPressed: ()=>Navigator.pop(context),
      ),
    );
  }

  void _updateDirection(BuildContext context, int id) async {

    Direction newDirection = new Direction(
      id: id,
      receive: receive != null ? receive : null,
      zip: zip != null ? int.parse(zip) : null,
      country: country != null ? country : null,
      state: state != null ? state : null,
      city: city != null ? city : null,
      colony: colony != null ? colony : null,
      street: street != null ? street : null,
      numberExt: numberExt != null ? numberExt : null,
      numberInt: numberInt != null ? numberInt : null,
      receivePhone: receivePhone != null ? receivePhone : null,
      reference: reference != null ? reference : null,
    );

    print(newDirection);

    var response = await directionsProvider.updateDirection(direccion: newDirection);

    if ( response is Direction ){
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
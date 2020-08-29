import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/bloc/provider_bloc.dart';

class RegisterAddresses extends StatelessWidget {

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
            SizedBox( height: 30.0 ),
            codigoPostal(bloc),
            SizedBox( height: 30.0 ),
            pais(bloc),
            SizedBox( height: 30.0 ),
            estado(bloc),
            SizedBox( height: 30.0 ),
            municipio(bloc),
            SizedBox( height: 30.0 ),
            colonia(bloc),
            SizedBox( height: 30.0 ),
            calle(bloc),
            SizedBox( height: 30.0 ),
            nomExterior(bloc),
            SizedBox( height: 30.0 ),
            nomInterior(),
            SizedBox( height: 30.0 ),
            telefonoContacto(bloc),
            SizedBox( height: 30.0 ),
            referencia(),
            SizedBox( height: 30.0 ),
            guardar(context, size, bloc),
            SizedBox( height: 15.0 ),
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
            onPressed: snapshot.hasData ? (){} : null
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
}
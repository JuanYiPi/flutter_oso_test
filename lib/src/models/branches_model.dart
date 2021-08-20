// To parse this JSON data, do
//
//     final branches = branchesFromJson(jsonString);

import 'dart:convert';

Branches branchesFromJson(String str) => Branches.fromJson(json.decode(str));

String branchesToJson(Branches data) => json.encode(data.toJson());

class Branches {
    Branches({
        this.data,
    });

    List<Branch> data;

    factory Branches.fromJson(Map<String, dynamic> json) => Branches(
        data: List<Branch>.from(json["data"].map((x) => Branch.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Branch {
    Branch({
        this.idAlmacen,
        this.razonSocial,
        this.alias,
        this.rfc,
        this.telefono,
        this.calle,
        this.numExt,
        this.numInt,
        this.colonia,
        this.localidad,
        this.referencia,
        this.municipio,
        this.entidad,
        this.pais,
        this.cp,
        this.estadoWeb,
        this.identificadorWeb,
        this.nombreWeb,
        this.fechaModificacion,
    });

    int idAlmacen;
    String razonSocial;
    String alias;
    String rfc;
    String telefono;
    String calle;
    String numExt;
    String numInt;
    String colonia;
    String localidad;
    String referencia;
    String municipio;
    String entidad;
    String pais;
    String cp;
    String estadoWeb;
    String identificadorWeb;
    String nombreWeb;
    DateTime fechaModificacion;

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        idAlmacen: json["IdAlmacen"],
        razonSocial: json["RazonSocial"],
        alias: json["Alias"],
        rfc: json["RFC"],
        telefono: json["Telefono"],
        calle: json["Calle"],
        numExt: json["NumExt"],
        numInt: json["NumInt"],
        colonia: json["Colonia"],
        localidad: json["Localidad"],
        referencia: json["Referencia"],
        municipio: json["Municipio"],
        entidad: json["Entidad"],
        pais: json["Pais"],
        cp: json["CP"],
        estadoWeb: json["EstadoWeb"],
        identificadorWeb: json["IdentificadorWeb"],
        nombreWeb: json["NombreWeb"],
        fechaModificacion: DateTime.parse(json["FechaModificacion"]),
    );

    Map<String, dynamic> toJson() => {
        "IdAlmacen": idAlmacen,
        "RazonSocial": razonSocial,
        "Alias": alias,
        "RFC": rfc,
        "Telefono": telefono,
        "Calle": calle,
        "NumExt": numExt,
        "NumInt": numInt,
        "Colonia": colonia,
        "Localidad": localidad,
        "Referencia": referencia,
        "Municipio": municipio,
        "Entidad": entidad,
        "Pais": pais,
        "CP": cp,
        "EstadoWeb": estadoWeb,
        "IdentificadorWeb": identificadorWeb,
        "NombreWeb": nombreWeb,
        "FechaModificacion": fechaModificacion.toIso8601String(),
    };
}

import 'package:flutter/foundation.dart';
import 'package:open_hospital/models/medicalTypeDTO.dart';
import 'package:http/http.dart' as http;

class Medical {
  int? code;
  String? prodCode;
  MedicalTypeDTO? typeDTO;
  String? description;
  double? initialQuantity;
  int? pcsperpk;
  double? inqty;
  double? outqty;
  double? minqty;

  Medical({
    this.code,
    this.prodCode,
    Map<String, dynamic>? typeDTO,
    this.description,
    this.initialQuantity,
    this.pcsperpk,
    this.inqty,
    this.outqty,
    this.minqty,
  }) {
    if (typeDTO != null) {
      List l = typeDTO.values.toList();
      var m = MedicalTypeDTO(code: l[0], description: l[1]);
      this.typeDTO = m;
    }
  }
  factory Medical.fromJson(Map<String, dynamic> json) {
    return Medical(
      code: json['code'],
      prodCode: json['prod_code'],
      typeDTO: json['type'],
      description: json['description'],
      initialQuantity: json['initialqty'],
      pcsperpk: json['pcsperpck'],
      inqty: json['inqty'],
      outqty: json['outqty'],
      minqty: json['minqty'],
    );
  }
  @override
  String toString() {
    return this.description.toString();
  }

  String toTest() {
    return this.code.toString() +
        " " +
        this.prodCode.toString() +
        " " +
        this.typeDTO!.toMap().toString() +
        " " +
        this.description.toString() +
        " " +
        this.initialQuantity.toString() +
        " " +
        this.pcsperpk.toString() +
        " " +
        this.inqty.toString() +
        " " +
        this.outqty.toString() +
        " " +
        this.minqty.toString();
  }

  bool contains(String query) {
    if (this.toString().toLowerCase().contains(query.toLowerCase()))
      return true;
    else
      return false;
  }
}

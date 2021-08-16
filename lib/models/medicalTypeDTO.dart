import 'package:open_hospital/widgets/Pharmacy/api_connection_type.dart';
import 'package:flutter/material.dart';

class MedicalTypeDTO {
  String? code;
  String? description;
  static List? _typeDTO;
  MedicalTypeDTO({this.code, this.description});

  factory MedicalTypeDTO.fromJson(Map<String, dynamic> json) {
    //PROBLEMA QUI.. QUalunque altra azione dentro un factory non fa eseguire la sezione successiva
    /*final m = MedicalTypeDTO(
      code: json['code'],
      description: json['description'],
    );
    addToTypeList(m); // ritornando m crea un errrore di return*/
    return MedicalTypeDTO(
      code: json['code'],
      description: json['description'],
    );
  }
  @override
  String toString() {
    return this.description.toString();
  }

  static void addToTypeList(MedicalTypeDTO n) {
    _typeDTO!.add(n);
  }

  static List? returnTypeList() {
    return _typeDTO;
  }

  static void setList(List<MedicalTypeDTO> l) {
    _typeDTO = l;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> m = {
      'code': this.code,
      'description': this.description
    };
    return m;
  }

  String toMapString() {
    return "{\"code\":" +
        this.code.toString() +
        ", \"description\": " +
        this.description.toString() +
        "}";
  }
}

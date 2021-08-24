import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_hospital/models/medical.dart';
import 'package:open_hospital/models/medicalTypeDTO.dart';

final _base = "http://localhost:8080/oh-api/medicaltypes";
final Uri _tokenURL = Uri.parse(_base);
Map<String, String> header = {};
void setHeaderPharmacy(String token) {
  String auth = "Bearer " + token;
  header = {
    "accept": "application/json; charset=UTF-8",
    "content-type": "application/json",
    'authorization': auth,
  };
}

List<MedicalTypeDTO> medicalsTypeFromJson(String str) {
  final parsed = jsonDecode(str).cast<Map<String, dynamic>>();
  return parsed
      .map<MedicalTypeDTO>((json) => MedicalTypeDTO.fromJson(json))
      .toList();
}

Future<List<MedicalTypeDTO>> fetchMedicalType(http.Client client) async {
  //print(_tokenURL);
  List<MedicalTypeDTO> m = [];
  try {
    final http.Response response = await http.get(
      _tokenURL,
      headers: header,
    );
    if (response.statusCode == 200) {
      List<MedicalTypeDTO> l = medicalsTypeFromJson(response.body);
      MedicalTypeDTO.setList(l);
      //Aggiungo tutti gli elementi che mi ritornano in una lista
      return l;
    } else {
      print(response.headers);
      //print(jsonDecode(response.body));
      throw Exception(json.decode(response.body));
    }
  } on SocketException catch (e) {
    return m;
  }
}

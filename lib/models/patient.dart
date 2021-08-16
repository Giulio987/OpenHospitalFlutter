import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/Patients/api_connection.dart';

class Patient {
  final int? code;
  final String? firstName;
  final String? secondName;
  final int? birthDate;
  final int? age;
  final String? agetype;
  final String? sex;
  final String? address;
  final String? city;
  final String? nextKin;
  final String? telephone;
  final String? note;
  final String? mother_name;
  final String? mother;
  final String? father_name;
  final String? father;
  final String? bloodType;
  final String? hasInsurance;
  final String? parentTogether;
  final String? taxCode;
  final double? height;
  final double? weight;
  final int? lock;
  final String? blobPhoto;
  final String? hasCode;

  Patient({
    this.code,
    @required this.firstName,
    @required this.secondName,
    @required this.birthDate,
    @required this.age,
    @required this.agetype,
    @required this.sex,
    this.address,
    @required this.city,
    this.nextKin,
    this.telephone,
    this.note,
    this.mother_name,
    this.mother,
    this.father_name,
    this.father,
    @required this.bloodType,
    this.hasInsurance,
    this.parentTogether,
    this.taxCode,
    this.height,
    this.weight,
    this.lock,
    this.blobPhoto,
    this.hasCode,
  });
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      code: json['code'],
      firstName: json['firstName'],
      secondName: json['secondName'],
      birthDate: json['birthDate'],
      age: json['age'],
      agetype: json['agetype'],
      sex: json['sex'],
      address: json['address'],
      city: json['city'],
      nextKin: json['nextKin'],
      telephone: json['telephone'],
      note: json['note'],
      mother_name: json['mother_name'],
      mother: json['mother'],
      father_name: json['father_name'],
      father: json['father'],
      bloodType: json['bloodType'],
      hasInsurance: json['hasInsurance'],
      parentTogether: json['parentTogether'],
      taxCode: json['taxCode'],
      height: json['height'],
      weight: json['weight'],
      lock: json['lock'],
      blobPhoto: json['blobPhoto'],
      hasCode: json['hasCode'],
    );
  }
  @override
  String toString() {
    return this.firstName.toString() + " " + this.secondName.toString();
  }
}

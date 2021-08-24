import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../models/patient.dart';

//ONLY VM
//Platform.isAndroid
//  ? "http://10.0.2.2:8080/oh-api/patients"
final _base = "http://localhost:8080/oh-api/patients";
final Uri _tokenURL = Uri.parse(_base);
Map<String, String> header = {};
void setHeaderPatient(String token) {
  String auth = "Bearer " + token;
  header = {
    "accept": "application/json; charset=UTF-8",
    "content-type": "application/json",
    'authorization': auth,
  };
}

Future<int> createPatient(Patient p) async {
  //print(_tokenURL);
  try {
    final http.Response response = await http.post(
      _tokenURL,
      headers: header,
      body: jsonEncode(<String, dynamic>{
        'code': p.code,
        'firstName': p.firstName,
        'secondName': p.secondName,
        'birthDate': p.birthDate,
        'age': p.age,
        'agetype': p.agetype,
        'sex': p.sex,
        'address': p.address,
        'city': p.city,
        'nextKin': p.nextKin,
        'telephone': p.telephone,
        'note': p.note,
        'mother_name': p.mother_name,
        'mother': p.mother,
        'father_name': p.father_name,
        'father': p.father,
        'bloodType': p.bloodType,
        'hasInsurance': p.hasInsurance,
        'parentTogether': p.parentTogether,
        'taxCode': p.taxCode,
        'height': p.height,
        'weight': p.weight,
        'lock': p.lock,
        'blobPhoto': p.blobPhoto,
        'hasCode': p.hasCode,
      }),
    );
    return response.statusCode;
  } on SocketException catch (e) {
    return 404;
  }
}

void updatePatient(Patient p) async {
  final _patientToUpdate = _tokenURL.toString() + "/" + p.code.toString();
  //print(_patientToUpdate);
  final http.Response response = await http.put(
    Uri.parse(_patientToUpdate),
    headers: header,
    body: jsonEncode(<String, dynamic>{
      //'code': p.code,
      'firstName': p.firstName,
      'secondName': p.secondName,
      'birthDate': p.birthDate,
      'age': p.age,
      'agetype': p.agetype,
      'sex': p.sex,
      'address': p.address,
      'city': p.city,
      //'nextKin': p.nextKin,
      'telephone': p.telephone,
      'note': p.note,
      'mother_name': p.mother_name,
      'mother': p.mother,
      'father_name': p.father_name,
      'father': p.father,
      'bloodType': p.bloodType,
      'hasInsurance': p.hasInsurance,
      'parentTogether': p.parentTogether,
      'taxCode': p.taxCode,
      'height': p.height,
      'weight': p.weight,
      //'lock': p.lock,
      'blobPhoto': p.blobPhoto,
      //'hasCode': p.hasCode,
    }),
  );
  if (response.statusCode == 201) {
    //print(json.decode(response.body).toString());
    //QUANDO FUNZIONERA DA SISTEMARE
  } else {
    print(response.headers);
    //print(jsonDecode(response.body));
    throw Exception(json.decode(response.body));
  }
}

Future<int> deletePatient(String code) async {
  final patientToDelete = _base + "/" + code;
  try {
    final http.Response response = await http.delete(
      Uri.parse(patientToDelete),
      headers: header,
    );
    return response.statusCode;
  } on SocketException catch (e) {
    return 404;
  }
}

List<Patient> patientsFromJson(String str) {
  final parsed = jsonDecode(str).cast<Map<String, dynamic>>();
  return parsed.map<Patient>((json) => Patient.fromJson(json)).toList();
}
//List<Patient>.from(json.decode(str).map((x) => Patient.fromJson(x)));

Future<List<Patient>> fetchPatients(http.Client client) async {
  //print(_tokenURL);
  //print(header);
  List<Patient> m = [];
  try {
    final http.Response response = await http.get(
      _tokenURL,
      headers: header,
    );
    if (response.statusCode == 200) {
      return patientsFromJson(response.body);
    } else {
      print(response.headers);
      print(response.body);
      throw Exception(); //managed on the main page
    }
  } on SocketException catch (e) {
    return m;
  }
}

Future<Patient> fetchPatient(http.Client client, String code) async {
  String _singlePatient = _tokenURL.toString() + "/" + code;
  //print(_singlePatient);
  var p = Patient(
      firstName: "",
      secondName: "",
      birthDate: null,
      age: null,
      agetype: null,
      sex: null,
      city: null,
      bloodType: null);
  try {
    final http.Response response = await http.get(
      Uri.parse(_singlePatient),
      headers: header,
    );
    try {
      if (response.statusCode == 200) {
        return Patient.fromJson(jsonDecode(response.body));
      } else {
        print(response.headers);
        //print(jsonDecode(response.body));
        return p;
      }
    } on FormatException catch (ex) {
      return p;
    }
  } on SocketException catch (e) {
    return p;
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_hospital/models/medical.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

//ONLY FOR VIRTUAL DEVICE
//change for native development
final _base = "http://192.168.1.106:8080/oh-api/medicals?ignore_similar=false";
final Uri _tokenURL = Uri.parse(_base);
Map<String, String> header = {};
void setHeaderType(String token) {
  String auth = "Bearer " + token;
  header = {
    "accept": "application/json; charset=UTF-8",
    "content-type": "application/json",
    'authorization': auth,
  };
}

Future<int> createMedical(Medical m) async {
  print(_tokenURL);
  final http.Response response = await http.post(
    _tokenURL,
    headers: header,
    body: jsonEncode(<String, dynamic>{
      'code': m.code,
      'prod_code': m.prodCode,
      'type': m.typeDTO!.toMap(),
      'description': m.description,
      'initialqty': m.initialQuantity,
      'pcsperpck': m.pcsperpk,
      'inqty': m.inqty,
      'outqty': m.outqty,
      'minqty': m.minqty
    }),
  );
  if (response.statusCode == 201) {
    return response.statusCode;
  } else {
    print(response.headers);
    print(jsonDecode(response.body));
    throw Exception(json.decode(response.body));
  }
}

Future<int> updateMedical(Medical m) async {
  //DA VEDERE BENE
  final _medicalToUpdate = _base.toString();
  final dir = await getTemporaryDirectory();
  var file = File("${dir.path}/medicals.json");

  final http.Response response = await http.put(
    Uri.parse(_medicalToUpdate),
    headers: header,
    body: jsonEncode(<String, dynamic>{
      'code': m.code,
      'prod_code': m.prodCode,
      'type': m.typeDTO!.toMap(),
      'description': m.description,
      'initialqty': m.initialQuantity,
      'pcsperpck': m.pcsperpk,
      'inqty': m.inqty,
      'outqty': m.outqty,
      'minqty': m.minqty
    }),
  );
  //Update Cache
  final http.Response responseForUpdate = await http.get(
    _tokenURL,
    headers: header,
  );
  file.writeAsString(responseForUpdate.body);
  print(response.body + "\n");
  return response.statusCode;

  // throw Exception();
}

Future<int> deleteMedical(String code) async {
  final medicalToDelete = "http://localhost:8080/oh-api/medicals/" + code;
  final dir = await getTemporaryDirectory();
  var file = File("${dir.path}/medicals.json");
  final http.Response response;
  // online delete
  try {
    response = await http.delete(
      Uri.parse(medicalToDelete),
      headers: header,
    );
    //Update Cache
    final http.Response responseForUpdate = await http.get(
      _tokenURL,
      headers: header,
    );
    file.writeAsString(responseForUpdate.body);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      print(response.headers);
      //print(jsonDecode(response.body));
      return response.statusCode;
    }
  } on SocketException catch (e) {
    return 404;
  }
}

List<Medical> medicalsFromJson(String str) {
  final parsed = jsonDecode(str).cast<Map<String, dynamic>>();
  return parsed.map<Medical>((json) => Medical.fromJson(json)).toList();
}
//List<Medical>.from(json.decode(str).map((x) => Medical.fromJson(x)));

Future<List<Medical>> fetchMedicals(http.Client client) async {
  //CACHE LOCALE
  final dir = await getTemporaryDirectory();
  List<Medical> m = [];
  var file = File("${dir.path}/medicals.json");
  final http.Response response;
  if (await file.exists() && file.readAsStringSync() != "") {
    return medicalsFromJson(file.readAsStringSync());
  } else {
    try {
      response = await http.get(
        _tokenURL,
        headers: header,
      );

      file.writeAsString(response.body);
      if (response.statusCode == 200) {
        return medicalsFromJson(response.body);
      } else {
        print(response.headers);
        print(jsonDecode(response.body));
        throw Exception(json.decode(response.body));
      }
    } on SocketException catch (e) {
      return m;
    }
    //throw Exception();
  }
}

Future<Medical>? fetchMedical(http.Client client, String code) async {
  String _singleMedical = "http://localhost:8080/oh-api/medicals/" + code;
  var m = Medical();
  //print(_singleMedical);
  try {
    final http.Response response = await http.get(
      Uri.parse(_singleMedical),
      headers: header,
    );

    if (response.statusCode == 200) {
      return Medical.fromJson(jsonDecode(response.body));
    } else {
      print(response.headers);
      //print(jsonDecode(response.body));

      return m;
    }
  } on SocketException catch (e) {
    return m;
  }
}

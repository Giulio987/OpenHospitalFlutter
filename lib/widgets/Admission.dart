import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:open_hospital/widgets/Patients/api_connection.dart';
import '../models/patient.dart';
import 'Patients/NewPatient.dart';
import 'Patients/PatientPage.dart';
import 'Patients/ModifyPatient.dart';

class AdmissionPatient extends StatefulWidget {
  const AdmissionPatient({Key? key}) : super(key: key);

  @override
  _AdmissionPatientState createState() => _AdmissionPatientState();
}

class _AdmissionPatientState extends State<AdmissionPatient> {
  late Future<List<Patient>> futurePatient;
  final codeController = TextEditingController();
  final firstNameController = TextEditingController();
  final secondaNameController = TextEditingController();
  final birthDateController = TextEditingController();
  final ageController = TextEditingController();
  final agetypeController = TextEditingController();
  final sexController = TextEditingController();
  final cityController = TextEditingController();
  final bloodTypeController = TextEditingController();
  final addressController = TextEditingController();
  final telephoneController = TextEditingController();
  final noteController = TextEditingController();
  final motherNameController = TextEditingController();
  final motherController = TextEditingController();
  final fatherNameController = TextEditingController();
  final fatherController = TextEditingController();
  final hasInsuranceController = TextEditingController();
  final parentTogetherController = TextEditingController();
  final taxCodeController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final blobController = TextEditingController();

  /*@override
  void initState() {
    super.initState();
    futurePatient = fetchPatient(http.Client());
  }*/

  //CREAZIONE NUOVO PAZIENTE
  void _newPatient(
      String? firstName,
      String? secondName,
      String? birthDate,
      String? age,
      String? agetype,
      String? sex,
      String? city,
      String? bloodType,
      String? address,
      //String? nextKin,
      String? telephone,
      String? note,
      String? motherName,
      String? mother,
      String? fatherName,
      String? father,
      String? hasInsurance,
      String? parentTogether,
      String? taxCode,
      String? height,
      String? weight,
      String? blob) async {
    //NUMERICAL CONTROLS
    if (age.toString().isEmpty) {
      age = "0";
    }
    if (birthDate.toString().isEmpty) {
      birthDate = "0";
    }
    if (height.toString().isEmpty) {
      height = "0";
    }
    if (weight.toString().isEmpty) {
      weight = "0";
    }

    final pat = Patient(
        firstName: firstName,
        secondName: secondName,
        birthDate: int.parse(birthDate.toString()),
        age: int.parse(age.toString()),
        agetype: agetype,
        sex: sex,
        city: city,
        bloodType: bloodType,
        address: address,
        //nextKin: nextKin,
        telephone: telephone,
        note: note,
        mother_name: motherName,
        mother: mother,
        father_name: fatherName,
        father: father,
        hasInsurance: hasInsurance,
        parentTogether: parentTogether,
        taxCode: taxCode,
        height: double.parse(height.toString()),
        weight: double.parse(weight.toString()),
        blobPhoto: blob);
    int response = await createPatient(pat);
    if (response == 201) {
      Navigator.of(context)
          .pop(); //automatically closes when insertion is finished
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => AdmissionPatient()));
    } else if (response == 404) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Connection Error"),
            content: new Text("Unable to add patient"),
          );
        },
      );
      //In base al messaggio posso mostrare altro

    }
  }

//APPARE LA BARRA SOTTO
  void _startNewPatient(BuildContext cntx) {
    showModalBottomSheet(
      context: cntx,
      builder: (bctx) {
        return GestureDetector(
          child: NewPatient(_newPatient),
          onTap: () {},
          behavior: HitTestBehavior
              .opaque, //Cattura l'evento e impedisce che qualcun altro lo possa usare
        );
      },
    );
  }

  //UPDATE PAZIENTE
  void submitUpdate(
      int? code,
      String? firstName,
      String? secondName,
      String? birthDate,
      String? age,
      String? agetype,
      String? sex,
      String? city,
      String? bloodType,
      String? address,
      String? telephone,
      String? note,
      String? motherName,
      String? mother,
      String? fatherName,
      String? father,
      String? hasInsurance,
      String? parentTogether,
      String? taxCode,
      String? height,
      String? weight,
      String? blob) {
    //Update of a new patient
    if (age.toString().isEmpty) {
      age = "0";
    }
    if (birthDate.toString().isEmpty) {
      birthDate = "0";
    }
    if (height.toString().isEmpty) {
      height = "0";
    }
    if (weight.toString().isEmpty) {
      weight = "0";
    }
    final pat = Patient(
        code: code,
        firstName: firstName,
        secondName: secondName,
        birthDate: int.parse(birthDate.toString()),
        age: int.parse(age.toString()),
        agetype: agetype,
        sex: sex,
        city: city,
        bloodType: bloodType,
        address: address,
        telephone: telephone,
        note: note,
        mother_name: motherName,
        mother: mother,
        father_name: fatherName,
        father: father,
        hasInsurance: hasInsurance,
        parentTogether: parentTogether,
        taxCode: taxCode,
        height: double.parse(height.toString()),
        weight: double.parse(weight.toString()),
        blobPhoto: blob);
    updatePatient(pat);
  }

  void _modifyPatient(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bctx) {
        return ModifyPatient(update: submitUpdate);
      },
    );
  }

  void submitDelete() async {
    int status = await deletePatient(codeController.text);
    if (status == 200) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdmissionPatient()));
    } else if (status == 404) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Connection Error"),
            content: new Text("Unable to delete patient"),
          );
        },
      );
    }
  }

  void _deletePatient(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bctx) {
        return GestureDetector(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    labelText: 'Patient code that will be deleted'),
                controller: codeController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) =>
                    submitDelete(), // prendo un argomento ma che non userò mai
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              Container(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[800])),
                  onPressed: submitDelete,
                  child: Text(
                    'Delete Patient data',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
          onTap: () {},
          behavior: HitTestBehavior
              .opaque, //Cattura l'evento e impedisce che qualcun altro lo possa usare
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Browser"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            FutureBuilder<List<Patient>>(
              future: fetchPatients(http.Client()),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null || snapshot.data.isEmpty) {
                  return Text(
                    "Failed to retrieve patient data",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return PatientList(patient: snapshot.data!);
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "There are no patients registered currently",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(10.0)),
                Container(
                  width: 0.4 * deviceWidth,
                  height: 0.08 * deviceHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[800])),
                    onPressed: () => _startNewPatient(context),
                    child: Text(
                      "New Patient",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Container(
                  width: 0.4 * deviceWidth,
                  height: 0.08 * deviceHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[800])),
                    onPressed: () => _modifyPatient(context),
                    child: Text(
                      "Modify Patient",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Container(
                  width: 0.4 * deviceWidth,
                  height: 0.08 * deviceHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[800])),
                    onPressed: () => _deletePatient(context),
                    child: Text(
                      "Delete Patient",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PatientList extends StatelessWidget {
  final List<Patient> patient;

  PatientList({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: patient.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(
              patient[index].toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            leading: Text(
              "N°" + patient[index].code.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => PatientPage(
                      patient: patient[index],
                    ),
                  ));
            },
          ),
        );
      },
    );
  }
}

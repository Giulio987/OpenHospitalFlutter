import 'package:flutter/material.dart';
import 'api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:open_hospital/models/patient.dart';

class ModifyPatient extends StatefulWidget {
  final Function? update;
  ModifyPatient({Key? key, this.update}) : super(key: key);

  @override
  _ModifyPatientState createState() => _ModifyPatientState();
}

class _ModifyPatientState extends State<ModifyPatient> {
  final codeController = TextEditingController();
  final firstNameController = TextEditingController();
  final secondaNameController = TextEditingController();
  final birthDateController = TextEditingController();
  final ageController = TextEditingController();
  final agetypeController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final telephoneController = TextEditingController();
  final noteController = TextEditingController();
  final motherNameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final taxCodeController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final blobController = TextEditingController();
  String sexDropDown = "";
  String motherDropDown = "";
  String fatherDropDown = "";
  String bloodTypeDropDown = "";
  String hasInsuranceDropDown = "";
  String parentTogetherDropDown = "";

  void submitgetPat() {
    bool onlyOnce = true;
    Navigator.of(context).pop();
    showModalBottomSheet(
      context: context,
      builder: (bctx) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter mystate) {
          double deviceWidth = MediaQuery.of(context).size.width;
          double deviceHeight = MediaQuery.of(context).size.height;
          return GestureDetector(
            child: FutureBuilder<Patient>(
              future: fetchPatient(http.Client(), codeController.text),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data.code == null) {
                  //Navigator.of(context).pop();
                  return Container(
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      "Impossible retrieve Patient",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )),
                  );
                } else if (snapshot.hasData) {
                  codeController.text = snapshot.data!.code.toString();
                  firstNameController.text =
                      snapshot.data!.firstName.toString();
                  secondaNameController.text =
                      snapshot.data!.secondName.toString();
                  birthDateController.text =
                      snapshot.data!.birthDate.toString();
                  ageController.text = snapshot.data!.age.toString();
                  agetypeController.text = snapshot.data!.agetype.toString();

                  cityController.text = snapshot.data!.city.toString();
                  addressController.text = snapshot.data!.address.toString();
                  telephoneController.text =
                      snapshot.data!.telephone.toString();
                  noteController.text = snapshot.data!.note.toString();
                  motherNameController.text =
                      snapshot.data!.mother_name.toString();

                  fatherNameController.text =
                      snapshot.data!.father_name.toString();

                  taxCodeController.text = snapshot.data!.taxCode.toString();
                  heightController.text = snapshot.data!.height.toString();
                  weightController.text = snapshot.data!.weight.toString();
                  blobController.text = snapshot.data!.blobPhoto.toString();
                  if (onlyOnce) {
                    sexDropDown = snapshot.data!.sex.toString();
                    motherDropDown = snapshot.data!.mother.toString();
                    fatherDropDown = snapshot.data!.father.toString();
                    bloodTypeDropDown = snapshot.data!.bloodType.toString();
                    hasInsuranceDropDown =
                        snapshot.data!.hasInsurance.toString();
                    parentTogetherDropDown =
                        snapshot.data!.parentTogether.toString();
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Text(
                          "Modify Patient Data: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "First Name:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Flexible(
                              child: TextField(
                                controller: firstNameController,
                                onSubmitted: (_) => submitData(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Second Name:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Flexible(
                              child: TextField(
                                controller: secondaNameController,
                                onSubmitted: (_) => submitData(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Birth Date",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Flexible(
                              child: TextField(
                                controller: birthDateController,
                                onSubmitted: (_) => submitData(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Age:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Flexible(
                              child: TextField(
                                controller: ageController,
                                onSubmitted: (_) => submitData(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Agetype:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Flexible(
                              child: TextField(
                                controller: agetypeController,
                                onSubmitted: (_) => submitData(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Sex:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                            ),
                            DropdownButton<String>(
                              value: sexDropDown,
                              onChanged: (String? newValue) {
                                mystate(() {
                                  sexDropDown = newValue!;
                                  onlyOnce = false;
                                });
                              },
                              items: <String>[
                                'M',
                                'F'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "City:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Flexible(
                              child: TextField(
                                controller: cityController,
                                onSubmitted: (_) => submitData(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Telephone:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Flexible(
                              child: TextField(
                                controller: telephoneController,
                                onSubmitted: (_) => submitData(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Note:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Flexible(
                              child: TextField(
                                controller: noteController,
                                onSubmitted: (_) => submitData(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Mother Name:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Flexible(
                              child: TextField(
                                controller: motherNameController,
                                onSubmitted: (_) => submitData(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Mother: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                            ),
                            DropdownButton<String>(
                              value: motherDropDown,
                              onChanged: (String? newValue) {
                                mystate(() {
                                  motherDropDown = newValue!;
                                  onlyOnce = false;
                                });
                              },
                              items: <String>[
                                'D',
                                'A'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Father Name:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Flexible(
                              child: TextField(
                                controller: fatherNameController,
                                onSubmitted: (_) => submitData(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Father: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                            ),
                            DropdownButton<String>(
                              value: fatherDropDown,
                              onChanged: (String? newValue) {
                                //
                                mystate(() {
                                  fatherDropDown = newValue!;
                                  onlyOnce = false;
                                });
                              },
                              items: <String>[
                                'D',
                                'A'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Blood Type: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                            ),
                            DropdownButton<String>(
                              value: bloodTypeDropDown,
                              onChanged: (String? newValue) {
                                mystate(() {
                                  bloodTypeDropDown = newValue!;
                                  onlyOnce = false;
                                });
                              },
                              items: <String>[
                                '0-',
                                '0+',
                                'A-',
                                'A+',
                                'B-',
                                'B+',
                                'AB-',
                                'AB+'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Has Insurance: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                            ),
                            DropdownButton<String>(
                              value: hasInsuranceDropDown,
                              onChanged: (String? newValue) {
                                mystate(() {
                                  hasInsuranceDropDown = newValue!;
                                  onlyOnce = false;
                                });
                              },
                              items: <String>[
                                'Y',
                                'N'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Parent Together: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                            ),
                            DropdownButton<String>(
                              value: parentTogetherDropDown,
                              onChanged: (String? newValue) {
                                mystate(() {
                                  parentTogetherDropDown = newValue!;
                                  onlyOnce = false;
                                });
                              },
                              items: <String>[
                                'Y',
                                'N'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Tax Code:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Flexible(
                              child: TextField(
                                controller: taxCodeController,
                                onSubmitted: (_) => submitData(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Height:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Flexible(
                              child: TextField(
                                controller: heightController,
                                onSubmitted: (_) => submitData(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Weight:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Flexible(
                              child: TextField(
                                controller: weightController,
                                onSubmitted: (_) => submitData(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Blob:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Flexible(
                              child: TextField(
                                controller: blobController,
                                onSubmitted: (_) => submitData(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Container(
                          width: 200,
                          height: 60,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red[800])),
                            onPressed: submitData,
                            child: Text(
                              "Modify Patient",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
            onTap: () {},
            behavior: HitTestBehavior
                .opaque, //Cattura l'evento e impedisce che qualcun altro lo possa usare
          );
        });
      },
    );
  }

  void submitData() {
    final code = int.parse(codeController.text);
    final firstName = firstNameController.text;
    final secondName = secondaNameController.text;
    final birthDate = birthDateController.text;
    final age = ageController.text;
    final agetype = agetypeController.text;
    final sex = sexDropDown;
    final address = addressController.text;
    final city = cityController.text;
    final telephone = telephoneController.text;
    final note = noteController.text;
    final mother_name = motherNameController.text;
    final mother = motherDropDown;
    final father_name = fatherNameController.text;
    final father = fatherDropDown;
    final bloodType = bloodTypeDropDown;
    final hasInsurance = hasInsuranceDropDown;
    final parentToghether = parentTogetherDropDown;
    final taxCode = taxCodeController.text;
    final height = heightController.text;
    final weight = weightController.text;
    final blob = blobController.text;

    if (firstName.isEmpty || secondName.isEmpty) {
      return;
    }
    widget.update!(
        code,
        firstName,
        secondName,
        birthDate,
        age,
        agetype,
        sex,
        city,
        bloodType,
        address,
        telephone,
        note,
        mother_name,
        mother,
        father_name,
        father,
        hasInsurance,
        parentToghether,
        taxCode,
        height,
        weight,
        blob);
    Navigator.of(context).pop(); //chiude automaticamente quando aggiunto
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          TextField(
            decoration:
                InputDecoration(labelText: 'Codice paziente da Aggiornare'),
            controller: codeController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitgetPat(),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Container(
            width: 200,
            height: 60,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red[800])),
              onPressed: submitgetPat,
              child: Text(
                'Retrieve Paziente',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              /*style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.blue)),*/
            ),
          )
        ],
      ),
      onTap: () {},
      behavior: HitTestBehavior
          .opaque, //Cattura l'evento e impedisce che qualcun altro lo possa usare
    );
  }
}

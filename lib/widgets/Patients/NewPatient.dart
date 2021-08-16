import 'package:flutter/material.dart';
import 'package:open_hospital/widgets/Admission.dart';

class NewPatient extends StatefulWidget {
  final Function newPat;
  NewPatient(this.newPat);

  @override
  _NewPatientState createState() => _NewPatientState();
}

class _NewPatientState extends State<NewPatient> {
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

  void submitData() {
    final firstName = firstNameController.text;
    final secondName = secondaNameController.text;
    final birthDate = birthDateController.text;
    final age = ageController.text;
    final agetype = agetypeController.text;
    final sex = sexDropDown;
    final city = cityController.text;
    final bloodType = bloodTypeDropDown;
    final address = addressController.text;
    final telephone = telephoneController.text;
    final note = noteController.text;
    final motherName = motherNameController.text;
    final mother = motherDropDown;
    final fatherName = fatherNameController.text;
    final father = fatherDropDown;
    final hasInsurance = hasInsuranceDropDown;
    final parentTogheter = parentTogetherDropDown;
    final taxCode = taxCodeController.text;
    final height = heightController.text;
    final weight = weightController.text;
    final blob = weightController.text;
    // at least these two fields to create a patient
    if (firstName.isEmpty || secondName.isEmpty) {
      return;
    }
    widget.newPat(
      // even if it's in another class I can access it with widget.
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
      motherName,
      mother,
      fatherName,
      father,
      hasInsurance,
      parentTogheter,
      taxCode,
      height,
      weight,
      blob,
    );
  }

  String sexDropDown = 'M';
  String motherDropDown = "A";
  String fatherDropDown = "A";
  String bloodTypeDropDown = "0-";
  String hasInsuranceDropDown = "Y";
  String parentTogetherDropDown = "Y";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Enter the new patient information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: firstNameController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Surname'),
                  controller: secondaNameController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) =>
                      submitData(), // take an argument that never be used
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'birthdate'),
                  controller: birthDateController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'age'),
                  controller: ageController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'agety'),
                  controller: agetypeController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => submitData(),
                ),
                Row(
                  children: [
                    Text("Sex:"),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                    ),
                    DropdownButton<String>(
                      value: sexDropDown,
                      onChanged: (String? newValue) {
                        setState(() {
                          sexDropDown = newValue!;
                        });
                      },
                      items: <String>['M', 'F']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'city'),
                  controller: cityController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => submitData(),
                ),
                Row(
                  children: [
                    Text("Blood Type:"),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                    ),
                    DropdownButton<String>(
                      value: bloodTypeDropDown,
                      onChanged: (String? newValue) {
                        setState(() {
                          bloodTypeDropDown = newValue!;
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
                TextField(
                  decoration: InputDecoration(labelText: 'address'),
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'telephone'),
                  controller: telephoneController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'motherName'),
                  controller: motherNameController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => submitData(),
                ),
                Row(
                  children: [
                    Text("Mother:"),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                    ),
                    DropdownButton<String>(
                      value: motherDropDown,
                      onChanged: (String? newValue) {
                        setState(() {
                          motherDropDown = newValue!;
                        });
                      },
                      items: <String>['D', 'A']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'fatherName'),
                  controller: fatherNameController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => submitData(),
                ),
                Row(
                  children: [
                    Text("Father:"),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                    ),
                    DropdownButton<String>(
                      value: fatherDropDown,
                      onChanged: (String? newValue) {
                        setState(() {
                          fatherDropDown = newValue!;
                        });
                      },
                      items: <String>['D', 'A']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Has Insurance:"),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                    ),
                    DropdownButton<String>(
                      value: hasInsuranceDropDown,
                      onChanged: (String? newValue) {
                        setState(() {
                          hasInsuranceDropDown = newValue!;
                        });
                      },
                      items: <String>['Y', 'N']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Parent Together:"),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                    ),
                    DropdownButton<String>(
                      value: parentTogetherDropDown,
                      onChanged: (String? newValue) {
                        setState(() {
                          parentTogetherDropDown = newValue!;
                        });
                      },
                      items: <String>['Y', 'N']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'taxCode'),
                  controller: taxCodeController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'height'),
                  controller: heightController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'weight'),
                  controller: weightController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'blob'),
                  controller: blobController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => submitData(),
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
                      'Add New Patient Data',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    /*style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.blue)),*/
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:open_hospital/widgets/Patients/api_connection.dart';
import 'package:open_hospital/models/patient.dart';
import 'package:open_hospital/widgets/Admission.dart';

class PatientPage extends StatelessWidget {
  final Patient? patient;
  PatientPage({this.patient});

  void submitDelete(BuildContext context) {
    deletePatient(patient!.code.toString());
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdmissionPatient(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    //print(deviceWidth);
    return Scaffold(
      appBar: AppBar(
        title: Text("Paziente " + patient!.code.toString()),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            deviceWidth > 600
                ? LargeScreenDataList(patient: patient)
                //data columns and row adapting for small screen size
                : SmallScreenDataList(patient: patient),
            Padding(padding: EdgeInsets.all(20.0)),
            Center(
              child: Container(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[800])),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("Do you really want delete the patient?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            submitDelete(context);
                            Navigator.of(context).pop();
                          },
                          child: Text("Yes"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("No"),
                        ),
                      ],
                    ),
                  ),
                  child: Text(
                    "Delete Patient data",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(5.0))
          ],
        ),
      ),
    );
  }
}

class LargeScreenDataList extends StatelessWidget {
  final Patient? patient;
  const LargeScreenDataList({Key? key, this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                "Code",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Name",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Surname",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Age",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Sex",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "City",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Blood t.",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Telephone",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Note",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Mother",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Father",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Tax Code",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Height",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Weight",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
          rows: [
            DataRow(cells: [
              DataCell(
                Center(
                  child: Text(
                    patient!.code.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    patient!.firstName.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    patient!.secondName.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    patient!.age.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    patient!.sex.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    patient!.city.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    patient!.bloodType.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    patient!.telephone.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    patient!.note.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    patient!.mother.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    patient!.father.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    patient!.taxCode.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    patient!.height.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    patient!.weight.toString(),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

class SmallScreenDataList extends StatelessWidget {
  final Patient? patient;
  const SmallScreenDataList({Key? key, this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text("INFORMAZIONI")),
              DataColumn(label: Text(" ")),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Code",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(patient!.code.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(patient!.firstName.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Surname",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(patient!.secondName.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Birth Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(patient!.birthDate.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Sex",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(patient!.sex.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Address",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(patient!.address.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "City",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(patient!.city.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Telephone",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(patient!.telephone.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Mother Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(patient!.mother_name.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Note",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(patient!.note.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Mother",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(patient!.mother.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Father Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(patient!.father.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Tax code",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(patient!.taxCode.toString()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

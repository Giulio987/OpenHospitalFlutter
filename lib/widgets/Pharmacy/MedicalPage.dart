import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:open_hospital/models/medical.dart';
import 'package:open_hospital/widgets/Admission.dart';
import 'package:open_hospital/widgets/Pharmacy/Pharmaceuticals.dart';
import 'package:open_hospital/widgets/Pharmacy/api_connection.dart';

class MedicalPage extends StatelessWidget {
  final Medical? med;
  MedicalPage({this.med});

  void submitDelete(BuildContext context) {
    deleteMedical(med!.code.toString());
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Pharmaceuticals(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    //print(deviceWidth);
    return Scaffold(
      appBar: AppBar(
        title: Text("Medicinale " + med!.code.toString()),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            deviceWidth > 800
                ? LargeScreenDataList(med: med)
                //data columns and row adapting for small screen size
                : SmallScreenDataList(med: med),
            Padding(padding: EdgeInsets.all(20.0)),
            Center(
              child: Container(
                width: 200,
                height: 70,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[800])),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("Do you really want to delete the patient?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            submitDelete(context);
                            Navigator.of(context).pop();
                          },
                          child: Text("Si"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("No"),
                        ),
                      ],
                    ),
                  ),
                  child: Text("Delete Medical Data"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LargeScreenDataList extends StatelessWidget {
  final Medical? med;
  const LargeScreenDataList({Key? key, this.med}) : super(key: key);

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
                "Product Code",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Descripton",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Initial Qty",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "InQty",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "MinQty",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "OutQty",
                style: TextStyle(fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                "Pieces per Packet",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
          rows: [
            DataRow(cells: [
              DataCell(
                Center(
                  child: Text(
                    med!.code.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    med!.prodCode.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    med!.description.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    med!.initialQuantity.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    med!.inqty.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    med!.minqty.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    med!.outqty.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    med!.pcsperpk.toString(),
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
  final Medical? med;
  const SmallScreenDataList({Key? key, this.med}) : super(key: key);

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
                    Text(med!.code.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Product Code",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(med!.prodCode.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Initial Quantity",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(med!.initialQuantity.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Description",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(med!.description.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Inqty",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(med!.inqty.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Minqty",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(med!.minqty.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Outqty",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(med!.outqty.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Pieces Per Pack",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(med!.pcsperpk.toString()),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      "Product Code",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(med!.prodCode.toString()),
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

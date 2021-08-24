import 'package:flutter/material.dart';
import 'package:open_hospital/models/medicalTypeDTO.dart';
import 'package:open_hospital/widgets/Pharmacy/Pharmaceuticals.dart';
import 'package:open_hospital/widgets/Pharmacy/api_connection_type.dart';
import 'package:http/http.dart' as http;

class NewMedical extends StatefulWidget {
  final Function newMed;
  NewMedical(this.newMed);

  @override
  _NewMedicalState createState() => _NewMedicalState();
}

class _NewMedicalState extends State<NewMedical> {
  String dropdownValue = 'Chemical';
  final prodCodeController = TextEditingController();
  final descCotroller = TextEditingController();
  final pPPktController = TextEditingController();
  final criticalController = TextEditingController();

  void submitData() {
    final prodCode = prodCodeController.text;
    final desc = descCotroller.text;
    final pPPkt = int.parse(pPPktController.text);
    final minqty = double.parse(criticalController.text);
    int code = 1;
    double inqty = 0;
    double outqty = 0;
    double initialqty = 0;
    widget.newMed(
      //anche se è in un'altra classe posso accedervi con widget.
      prodCode,
      dropdownValue,
      desc,
      pPPkt,
      minqty,
      code,
      inqty,
      outqty,
      initialqty,
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    //double deviceHeight = MediaQuery.of(context).size.height;
    //fetchMedicalType(http.Client());
    return deviceWidth > 800
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      width: (deviceWidth / 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Insert Type",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          FutureBuilder(
                            future: fetchMedicalType(http.Client()),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null ||
                                  snapshot.data.isEmpty) {
                                return Text(
                                  "Unable to retrieve all Medical Types",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                );
                              }
                              if (snapshot.hasData) {
                                return Container(
                                  width: (deviceWidth / 2) * 0.9,
                                  child: DropdownButton<String>(
                                    hint: Text(dropdownValue),
                                    items: snapshot.data
                                        .map<DropdownMenuItem<String>>((item) {
                                      return DropdownMenuItem<String>(
                                        value: item.toString(),
                                        child: Text(item.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownValue = value.toString();
                                        //print(value.toString());
                                      });
                                    },
                                  ),
                                );
                              } else {
                                return Container(
                                  child: Center(
                                    child: Text(
                                      'Loading...',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          Padding(padding: EdgeInsets.all(5.0)),
                          Text(
                            "Insert product code",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: (deviceWidth / 2) * 0.9,
                            child: TextField(
                              decoration:
                                  InputDecoration(labelText: 'prod. code'),
                              controller: prodCodeController,
                              onSubmitted: (_) => submitData(),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5.0)),
                          Text(
                            "Insert Description",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: (deviceWidth / 2) * 0.9,
                            child: TextField(
                              decoration:
                                  InputDecoration(labelText: 'Description'),
                              controller: descCotroller,
                              onSubmitted: (_) => submitData(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: (deviceWidth / 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Insert Pieces Per Packet",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: (deviceWidth / 2) * 0.9,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: 'Pieces Per Packet'),
                              controller: pPPktController,
                              onSubmitted: (_) => submitData(),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(10.0)),
                          Text(
                            "Insert Critical Level",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: (deviceWidth / 2) * 0.9,
                            child: TextField(
                              decoration:
                                  InputDecoration(labelText: 'Critical Level'),
                              controller: criticalController,
                              onSubmitted: (_) => submitData(),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              Container(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: submitData,
                  child: Text(
                    "Create New Medical",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[800])),
                ),
              )
            ],
          )
        //SMALL
        : Container(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Text(
                    "Insert Type",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder(
                    future: fetchMedicalType(http.Client()),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: deviceWidth * 0.9,
                          child: DropdownButton<String>(
                            hint: Text(dropdownValue),
                            items: snapshot.data
                                .map<DropdownMenuItem<String>>((item) {
                              return DropdownMenuItem<String>(
                                value: item.toString(),
                                child: Text(item.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                dropdownValue = value.toString();
                                //print(value.toString());
                              });
                            },
                          ),
                        );
                      } else {
                        return Container(
                          child: Center(
                            child: Text(
                              'Loading...',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Text(
                    "Insert product code",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: deviceWidth * 0.9,
                    child: TextField(
                      decoration: InputDecoration(labelText: 'prod. code'),
                      controller: prodCodeController,
                      onSubmitted: (_) => submitData(),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Text(
                    "Insert Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: deviceWidth * 0.9,
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Description'),
                      controller: descCotroller,
                      onSubmitted: (_) => submitData(),
                    ),
                  ),
                  Text(
                    "Insert Pieces Per Packet",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: deviceWidth * 0.9,
                    child: TextField(
                      decoration:
                          InputDecoration(labelText: 'Pieces Per Packet'),
                      controller: pPPktController,
                      onSubmitted: (_) => submitData(),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10.0)),
                  Text(
                    "Insert Critical Level",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: deviceWidth * 0.9,
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Critical Level'),
                      controller: criticalController,
                      onSubmitted: (_) => submitData(),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(28.0)),
                  Container(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: submitData,
                      child: Text("Create New Medical"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red[800])),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

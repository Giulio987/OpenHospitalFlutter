import 'package:flutter/material.dart';
import 'package:open_hospital/models/medical.dart';
import 'package:open_hospital/widgets/Pharmacy/api_connection.dart';
import 'package:open_hospital/widgets/Pharmacy/api_connection_type.dart';
import 'package:http/http.dart' as http;
import 'package:open_hospital/models/medicalTypeDTO.dart';

//Pagina solo per richiedere il codice evitabile se si seleziona la riga dalla pagina della lista
class ModifyMedicalInput extends StatefulWidget {
  ModifyMedicalInput({Key? key}) : super(key: key);

  @override
  _ModifyMedicalInputState createState() => _ModifyMedicalInputState();
}

class _ModifyMedicalInputState extends State<ModifyMedicalInput> {
  bool setCode = false;

  final codeController = TextEditingController();

  void setTrue() {
    setState(() {
      setCode = true;
    });
  }

  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    if (setCode == false)
      return Center(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Text("Insert the Medical Code",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Container(
                  width: deviceWidth * 0.9,
                  child: TextField(
                      cursorColor: Colors.red.shade800,
                      autofocus: true,
                      decoration: InputDecoration(labelText: 'Code'),
                      controller: codeController,
                      onSubmitted: (_) => setTrue),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                ),
                Container(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red[800])),
                      onPressed: setTrue,
                      child: Text(
                        "Send",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          ),
        ),
      );
    else
      return ModifyMedical(
        code: int.parse(
          codeController.text,
        ),
      );
  }
}

class ModifyMedical extends StatefulWidget {
  final int? code;
  final Function? updateMed;
  const ModifyMedical({Key? key, this.code, this.updateMed}) : super(key: key);

  @override
  _ModifyMedicalState createState() => _ModifyMedicalState();
}

class _ModifyMedicalState extends State<ModifyMedical> {
  final codeController = TextEditingController();
  final prodCodeController = TextEditingController();
  final descCotroller = TextEditingController();
  final pPPktController = TextEditingController();
  final criticalController = TextEditingController();
  final inqtyController = TextEditingController();
  final outqtyController = TextEditingController();
  final minqtyController = TextEditingController();
  String dropdownValue = 'Chemical';

  //SEND UPDATE DATA
  void submitData() async {
    final String? prodCode = prodCodeController.text;
    final String? desc = descCotroller.text;
    final int? pPPkt = int.parse(pPPktController.text);
    final double? critical =
        double.parse(criticalController.text); // per ora è intiialqty
    final int? code = int.parse(codeController.text);
    final double? inqty = double.parse(inqtyController.text);
    final double? outqty = double.parse(outqtyController.text);
    final double? minqty = double.parse(minqtyController.text);
    List? l = MedicalTypeDTO.returnTypeList();
    MedicalTypeDTO? med;
    l!.forEach((element) {
      if (element.toString() == dropdownValue) {
        med = element;
      }
    });
    //print(l);
    //print(med.toString());
    final m = Medical(
        code: code,
        prodCode: prodCode,
        description: desc,
        pcsperpk: pPPkt,
        initialQuantity: critical,
        inqty: inqty,
        outqty: outqty,
        minqty: minqty,
        typeDTO: med!.toMap());
    int res = await updateMedical(m);
    if (res == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Medicinal Updated"),
            content: new Text("Good"),
          );
        },
      );
      //In base al messaggio posso mostrare altro
    }
    if (res == 500 || res == 400) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Internal server problem"),
            content: new Text("The resource is probably already in use"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      child: FutureBuilder<Medical>(
        future: fetchMedical(http.Client(), widget.code.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            codeController.text = snapshot.data!.code.toString();
            prodCodeController.text = snapshot.data!.prodCode.toString();
            descCotroller.text = snapshot.data!.description.toString();
            pPPktController.text = snapshot.data!.pcsperpk.toString();
            criticalController.text = snapshot.data!.initialQuantity.toString();
            inqtyController.text = snapshot.data!.inqty.toString();
            outqtyController.text = snapshot.data!.outqty.toString();
            minqtyController.text = snapshot.data!.minqty.toString();
            dropdownValue = snapshot.data!.typeDTO.toString();
            if (codeController.text == "null" &&
                prodCodeController.text == "null" &&
                descCotroller.text == "null" &&
                pPPktController.text == "null" &&
                criticalController.text == "null" &&
                inqtyController.text == "null" &&
                outqtyController.text == "null" &&
                minqtyController.text == "null") {
              return ErrorPage();
            } else
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: deviceWidth / 2,
                        child: Column(
                          children: [
                            Container(
                              width: (deviceWidth / 2) * 0.9,
                              child: TextField(
                                decoration:
                                    InputDecoration(labelText: 'Product Code'),
                                controller: prodCodeController,
                                onSubmitted: (_) => submitData(),
                              ),
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
                            Container(
                              width: (deviceWidth / 2) * 0.9,
                              child: TextField(
                                decoration: InputDecoration(labelText: 'Code'),
                                controller: codeController,
                                onSubmitted: (_) => submitData(),
                              ),
                            ),
                            Container(
                              width: (deviceWidth / 2) * 0.9,
                              child: TextField(
                                decoration: InputDecoration(
                                    labelText: 'Output Quantity'),
                                controller: outqtyController,
                                onSubmitted: (_) => submitData(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: deviceWidth / 2,
                        child: Column(
                          children: [
                            TextField(
                              decoration:
                                  InputDecoration(labelText: 'description'),
                              controller: descCotroller,
                              onSubmitted: (_) => submitData(),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'critical/INITIALQTY'),
                              controller: criticalController,
                              onSubmitted: (_) => submitData(),
                            ),
                            TextField(
                              decoration: InputDecoration(labelText: 'inqty'),
                              controller: inqtyController,
                              onSubmitted: (_) => submitData(),
                            ),
                            TextField(
                              decoration: InputDecoration(labelText: 'minqty'),
                              controller: minqtyController,
                              onSubmitted: (_) => submitData(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        FutureBuilder(
                          future: fetchMedicalType(http.Client()),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                child: DropdownButton<String>(
                                  hint: Text(dropdownValue),
                                  items: snapshot.data
                                      .map<DropdownMenuItem<String>>((item) {
                                    return DropdownMenuItem<String>(
                                      value: item.toString(),
                                      child: Text(item.toString()),
                                    );
                                  }).toList(),
                                  onChanged: null,
                                ),
                              );
                            } else {
                              return Container(
                                child: Center(
                                  child: Text('Loading...'),
                                ),
                              );
                            }
                          },
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Container(
                          width: (deviceWidth / 2) * 0.4,
                          child: ElevatedButton(
                            onPressed: submitData,
                            child: Text(
                              "Aggiorna",
                              style: TextStyle(fontSize: 18),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.red.shade800)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
          } else if (snapshot.hasError) {
            return ErrorPage();
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.not_interested,
            size: 50,
          ),
          Text(
            "Il medicinale non esiste o non è disponibile",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

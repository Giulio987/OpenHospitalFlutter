import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:open_hospital/models/medicalTypeDTO.dart';
import 'package:open_hospital/widgets/Pharmacy/api_connection.dart';
import '../../models/medical.dart';
import 'package:http/http.dart' as http;
import 'NewMedical.dart';
import '../../models/medicalTypeDTO.dart';
import 'ModifyMedical.dart';
import 'MedicalPage.dart';

class Pharmaceuticals extends StatefulWidget {
  const Pharmaceuticals({Key? key}) : super(key: key);

  @override
  _PharmaceuticalsState createState() => _PharmaceuticalsState();
}

class _PharmaceuticalsState extends State<Pharmaceuticals> {
  late Future<List<Medical>> futureMedical;
  List<Medical> medicals = [];
  //NAVIGATION BOTTOM BAR
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _newMedical(
    String? prodcode,
    String? type,
    String? desc,
    int? pPPkt,
    double? minqty,
    int? code,
    double? inqty,
    double? outqty,
    double? initialqty,
  ) async {
    //print("CIAO");
    List? l = MedicalTypeDTO.returnTypeList();
    MedicalTypeDTO? m;
    l!.forEach((element) {
      if (element.toString() == type) {
        m = element;
      }
    });
    //print(l);
    print(m.toString());
    //Essendo il codice la prima lettera del tpo medico

    final med = Medical(
      prodCode: prodcode,
      typeDTO: m!.toMap(),
      description: desc,
      pcsperpk: pPPkt,
      initialQuantity: initialqty,
      code: code,
      inqty: inqty,
      outqty: outqty,
      minqty: minqty,
    );
    //MOSTRO il messaggio che è andato tutto bene
    int status = await createMedical(med);
    if (status == 201) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Medical Added"),
            content: new Text("Ok"),
          );
        },
      );
      //In base al messaggio posso mostrare altro
    }
  }

  static List<Widget> _widgetOptions = <Widget>[
    MedicalsList(),
    MedicalsList(),
    ModifyMedicalInput(),
    DeleteMedical()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pharmaceutical Browsing"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        //backgroundColor: Colors.black,
        //fixedColor: Colors.red,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'All Medicals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'New Medical',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.healing),
            label: 'Modify Medical',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete Medical',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: _selectedIndex != 1
            ? _widgetOptions.elementAt(_selectedIndex)
            : NewMedical(
                _newMedical,
              ),
      ),
    );
  }
}

class MedicalsList extends StatefulWidget {
  MedicalsList({Key? key}) : super(key: key);

  @override
  _MedicalsListState createState() => _MedicalsListState();
}

class _MedicalsListState extends State<MedicalsList> {
  List<Medical> med = [];
  List<Medical> medDuplicated = [];
  //bool delete = false;
  //bool modify = false;
  final editingController = TextEditingController();
  bool alreadyDownloaded = false;
  /* void setDelete() {
    setState(() {
      delete = true;
    });
  }

  void setModify() {
    setState(() {
      modify = true;
    });
  }
*/

  void filterSearchResults(String query) {
    List<Medical> searchList = [];
    searchList.addAll(med);
    if (query.isNotEmpty) {
      List<Medical> listData = [];
      searchList.forEach((item) {
        if (item.contains(query)) {
          listData.add(item);
        }
      });
      setState(() {
        med.clear();
        med.addAll(listData);
      });
      return;
    } else {
      setState(() {
        med.clear();
        med.addAll(medDuplicated);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /*if (delete) {
      return DeleteMedical();
    } else if (modify) {
      return ModifyMedical();
    } else*/
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(5.0)),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: editingController,
                  onChanged: (value) {
                    filterSearchResults(editingController.text);
                  },
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Padding(padding: EdgeInsets.all(3.0)),
              /*Container(
                width: 100,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red.shade800)),
                  onPressed: 
                  child: Text("Search"),
                ),
              ),*/
            ],
          ),
          Padding(padding: EdgeInsets.all(5.0)),
          !alreadyDownloaded
              ? FutureBuilder<List<Medical>>(
                  future: fetchMedicals(http.Client()),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null || snapshot.data.isEmpty) {
                      // it's possible to insert a circular progress indicator and after 5 seconds show the text
                      return Container(
                        child: Center(
                          child: Text(
                            "Unable to retrieve Medicals",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      med.addAll(snapshot.data);
                      medDuplicated.addAll(snapshot.data);
                      alreadyDownloaded = true;
                      return ListView.builder(
                        //reverse: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: med.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          //med.add(med[index]);
                          return Card(
                            child: ListTile(
                              title: Text(
                                med[index].toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              leading: Text(
                                med[index].code.toString(),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MedicalPage(
                                            med: med[index],
                                          ))),
                              /*onTap: () => PopupMenuButton(
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry>[
                              const PopupMenuItem(
                                value: 1,
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem(
                                value: 0,
                                child: Text('Delete'),
                              ),
                            ],
                            onSelected: (result) {
                              if (result == 0) {
                                setDelete();
                              } else if (result == 1) {
                                setModify();
                              }
                            },
                            child: FlutterLogo(),
                          ),*/
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Al momento non sono registrati farmaci\n" +
                              snapshot.error.toString(),
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                )
              : ListView.builder(
                  //reverse: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: med.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    //med.add(med[index]);
                    return Card(
                      child: ListTile(
                        title: Text(
                          med[index].toString(),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        leading: Text(
                          med[index].code.toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicalPage(
                                      med: med[index],
                                    ))),
                        /*onTap: () => PopupMenuButton(
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry>[
                              const PopupMenuItem(
                                value: 1,
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem(
                                value: 0,
                                child: Text('Delete'),
                              ),
                            ],
                            onSelected: (result) {
                              if (result == 0) {
                                setDelete();
                              } else if (result == 1) {
                                setModify();
                              }
                            },
                            child: FlutterLogo(),
                          ),*/
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

class DeleteMedical extends StatelessWidget {
  final codeController = TextEditingController();
  //final String? codeRecived;
  DeleteMedical({
    Key? key,
  }) : super(key: key);
  void submitDelete(BuildContext context) async {
    int status = await deleteMedical(codeController.text);
    Navigator.of(context).pop();
    if (status == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Medicinal Deleted"),
            content: new Text("Everything went fine"),
          );
        },
      );
    } else if (status == 404) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Connection Error"),
            content: new Text("Unable to retrieve data"),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Unknown Error"),
            content: new Text("Unable to retrieve data"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    /* if (codeRecived!.isNotEmpty) {
      codeController.text = codeRecived.toString();
    }*/
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text("Enter the code of the medicinal that will be deleted",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.all(10.0)),
              Container(
                width: deviceWidth * 0.9,
                child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Code',
                    ),
                    controller: codeController,
                    onSubmitted: (_) => submitDelete),
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              Container(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red.shade800)),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("Do you really want to delete the data?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            submitDelete(context);
                            //Navigator.of(context).pop();
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
                    "Delete Medical Data",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

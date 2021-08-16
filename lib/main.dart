import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_hospital/widgets/Pharmacy.dart';
import 'package:open_hospital/widgets/Admission.dart';
import 'package:open_hospital/widgets/OPD.dart';
import 'package:open_hospital/widgets/Pharmacy/Pharmaceuticals.dart';
import 'widgets/Patients/api_connection.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.red.shade800),
    title: "Open Hospital",
    debugShowCheckedModeBanner: false,
    home: HomePage("Open Hospital"),
    //debugShowCheckedModeBanner: false, //per rimuovere la scritta debug
  ));
}

class HomePage extends StatefulWidget {
  final String title;
  HomePage(this.title);
  @override
  HomePageState createState() => HomePageState();
}

var scaffoldKey = GlobalKey<ScaffoldState>();

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    //getJson();
    //getData();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        /*leading: IconButton(
          icon: Icon(Icons.medical_services),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),*/
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Image.asset("images/logo.png"),
              /*Text(
                widget.title,
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),*/
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                child: Column(
              children: [
                Container(height: 120, child: Image.asset("images/logo.png")),
                Text("You are administrator")
              ],
            )),
            Card(
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Admission/Patient"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdmissionPatient(),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.local_pharmacy_rounded),
                title: Text("Pharmaceuticals"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pharmaceuticals(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      body:
          //Device width Adaptation
          deviceWidth > 1060
              ?
              //Large Screen
              Container(
                  width: double.infinity,
                  //margin:
                  //EdgeInsets.symmetric(horizontal: 0.05 * deviceWidth), //adaptive app
                  child: Row(
                    children: [
                      Container(
                        width: deviceWidth / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 0.2 * deviceWidth,
                                  height: 0.08 * deviceHeight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[800])),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Opd()));
                                    },
                                    child: Text(
                                      "OPD",
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 0.2 * deviceWidth,
                                  height: 0.08 * deviceHeight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[800])),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AdmissionPatient(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Admission/Patient",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 0.2 * deviceWidth,
                                  height: 0.08 * deviceHeight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[800])),
                                    onPressed: () {},
                                    child: Text(
                                      "Laboratory",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 0.2 * deviceWidth,
                                  height: 0.08 * deviceHeight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[800])),
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Pharmacy())),
                                    child: Text(
                                      "Pharmacy",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 0.2 * deviceWidth,
                                  height: 0.08 * deviceHeight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[800])),
                                    onPressed: () {},
                                    child: Text(
                                      "Patients Vaccines",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: deviceWidth / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 0.2 * deviceWidth,
                                  height: 0.08 * deviceHeight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[800])),
                                    onPressed: () {},
                                    child: Text(
                                      "Accounting",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 0.2 * deviceWidth,
                                  height: 0.08 * deviceHeight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[800])),
                                    onPressed: () {},
                                    child: Text(
                                      "Statistics",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 0.2 * deviceWidth,
                                  height: 0.08 * deviceHeight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[800])),
                                    onPressed: () {},
                                    child: Text(
                                      "Printing",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 0.2 * deviceWidth,
                                  height: 0.08 * deviceHeight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[800])),
                                    onPressed: () {},
                                    child: Text(
                                      "General Data",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 0.2 * deviceWidth,
                                  height: 0.08 * deviceHeight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[800])),
                                    onPressed: () {},
                                    child: Text(
                                      "Help",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              //Small Devices
              : SmallDevicesContainer(),
    );
  }
}

class SmallDevicesContainer extends StatelessWidget {
  const SmallDevicesContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      //margin:
      //EdgeInsets.symmetric(horizontal: 0.05 * deviceWidth), //adaptive app
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 0.5 * deviceWidth,
                  height: 0.08 * deviceHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[800])),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Opd()));
                    },
                    child: Text(
                      "OPD",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 0.5 * deviceWidth,
                  height: 0.08 * deviceHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[800])),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdmissionPatient(),
                        ),
                      );
                    },
                    child: Text(
                      "Patient",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 0.5 * deviceWidth,
                  height: 0.08 * deviceHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[800])),
                    onPressed: () {},
                    child: Text(
                      "Laboratory",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 0.5 * deviceWidth,
                  height: 0.08 * deviceHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[800])),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Pharmacy())),
                    child: Text(
                      "Pharmacy",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 0.5 * deviceWidth,
                  height: 0.08 * deviceHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[800])),
                    onPressed: () {},
                    child: Text(
                      "Patients Vaccines",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 0.5 * deviceWidth,
                  height: 0.08 * deviceHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[800])),
                    onPressed: () {},
                    child: Text(
                      "Accounting",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 0.5 * deviceWidth,
                  height: 0.08 * deviceHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[800])),
                    onPressed: () {},
                    child: Text(
                      "Statistics",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 0.5 * deviceWidth,
                  height: 0.08 * deviceHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[800])),
                    onPressed: () {},
                    child: Text(
                      "Printing",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 0.5 * deviceWidth,
                  height: 0.08 * deviceHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[800])),
                    onPressed: () {},
                    child: Text(
                      "General Data",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 0.5 * deviceWidth,
                  height: 0.08 * deviceHeight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[800])),
                    onPressed: () {},
                    child: Text(
                      "Help",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

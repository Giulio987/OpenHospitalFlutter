import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_hospital/widgets/Pharmacy.dart';
import 'package:open_hospital/widgets/Admission.dart';
import 'package:open_hospital/widgets/Pharmacy/Pharmaceuticals.dart';
import 'widgets/Patients/api_connection.dart';
import 'apiLogin.dart';
import './widgets/Patients/api_connection.dart';
import './widgets/Pharmacy/api_connection.dart';
import './widgets/Pharmacy/api_connection_type.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.red.shade800),
    title: "Open Hospital",
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
    //debugShowCheckedModeBanner: false, //per rimuovere la scritta debug
  ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  Map<String, dynamic> credentials = {};

  void login() async {
    credentials =
        await tryLogin(userNameController.text, passwordController.text);
    if (credentials.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Wrong Credentials"),
            content: new Text("Try again"),
          );
        },
      );
    } else {
      setHeaderPatient(credentials['token']);
      setHeaderPharmacy(credentials['token']);
      setHeaderType(credentials['token']);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage("Open Hospital", credentials['displayName'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: Image.asset(
                "images/logo.png",
                fit: BoxFit.fill,
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Container(
              width: 300,
              child: TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your username'),
                keyboardType: TextInputType.text,
                controller: userNameController,
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Container(
              width: 300,
              child: TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your password'),
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            ElevatedButton(
              onPressed: login,
              child: Text(
                "Enter",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.red.shade800)),
            ),
          ],
        ),
      ),
    ));
  }
}

class HomePage extends StatefulWidget {
  final String title;
  final String displayName;
  HomePage(this.title, this.displayName);
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
                Text("You are logged as " + widget.displayName)
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
                                    onPressed: () {},
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
                    onPressed: () {},
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

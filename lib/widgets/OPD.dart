import 'package:flutter/material.dart';

class Opd extends StatefulWidget {
  @override
  _OpdState createState() => _OpdState();
}

class _OpdState extends State<Opd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "OPD",
          //textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        child: Text(
          "OPD",
        ),
      ),
    );
  }
}

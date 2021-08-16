import 'package:flutter/material.dart';
import 'package:open_hospital/widgets/Pharmacy/Pharmaceuticals.dart';

class Pharmacy extends StatelessWidget {
  const Pharmacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pharmacy"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(10.0)),
            Container(
              width:
                  deviceWidth < 900 ? (deviceWidth * 0.5) : (deviceWidth * 0.3),
              height: 0.1 * deviceHeight,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.red[800])),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Pharmaceuticals())),
                child: Text(
                  "Pharmaceuticals",
                  style: deviceWidth < 900
                      ? TextStyle(fontSize: 17)
                      : TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Container(
              width:
                  deviceWidth < 900 ? (deviceWidth * 0.5) : (deviceWidth * 0.3),
              height: 0.1 * deviceHeight,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.red[800])),
                onPressed: () {},
                child: Text(
                  "Pharmaceutical Stock",
                  style: deviceWidth < 900
                      ? TextStyle(fontSize: 17)
                      : TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Container(
              width:
                  deviceWidth < 900 ? (deviceWidth * 0.5) : (deviceWidth * 0.3),
              height: 0.1 * deviceHeight,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.red[800])),
                onPressed: () {},
                child: Text(
                  "Pharmaceutical Stock Ward",
                  style: deviceWidth < 900
                      ? TextStyle(fontSize: 17)
                      : TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

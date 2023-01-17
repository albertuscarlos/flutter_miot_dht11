import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final databaseReference = FirebaseDatabase.instance.ref();
final dataTemperature = databaseReference.child("temperature");
final dataHumidity = databaseReference.child("humidity");

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#4d74ed"),
          title: const Center(
            child: Text("Living Room Monitoring IOT"),
          ),
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("images/background_app.png"),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Card(
              color: Colors.blueAccent.shade200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: 300,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Temperatur Ruangan :",
                      style: TextStyle(fontSize: 16, color: HexColor("ffffff")),
                    ),
                    StreamBuilder(
                      stream: dataTemperature.onValue,
                      builder: ((BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "${snapshot.data.snapshot.value.toString()} \u2103",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                              color: HexColor("ffffff"),
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.greenAccent.shade700,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: 300,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Kelembapan Ruangan :",
                      style: TextStyle(fontSize: 16, color: HexColor("ffffff")),
                    ),
                    StreamBuilder(
                      stream: dataHumidity.onValue,
                      builder: ((context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "${snapshot.data.snapshot.value.toString()} %",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                              color: HexColor("ffffff"),
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

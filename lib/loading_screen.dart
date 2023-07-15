import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'stats.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({ this.city});
  
  final city;
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

int check = 0; //toggle to test error dialog

class _LoadingScreenState extends State<LoadingScreen> {
  dynamic suv = 0;
  dynamic sedan = 0;
  dynamic mini = 0;
  dynamic active = 0;
  dynamic cabs = 0;
  dynamic drivers = 0;
  List _allResults = [];
  getCollectionStream() async {
    var data = await FirebaseFirestore.instance
        .collection('Stats')
        .orderBy('City')
        .get();
    print(data);
    setState(() {
      _allResults = data.docs;
    });

    for (var snapShot in data.docs) {
      print(widget.city);
      if (snapShot['City'].toString().toLowerCase() ==
          widget.city.toString().toLowerCase())
      // if(snapShot['City'].toString().toLowerCase()=='mumbai')
      {
        drivers = snapShot['Drivers'];
        cabs = snapShot['Cabs'];
        mini = snapShot['Mini'];
        sedan = snapShot['Sedan'];
        suv = snapShot['SUV'];
        active = snapShot['Active Rides'];
        print(drivers);
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getScreen();
    getCollectionStream(); // Call your async function here
  }

  void getScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => Stats(city: widget.city,cabs:cabs,mini: mini,active: active,sedan: sedan,suv: suv,drivers: drivers,)));
  }

  @override
  Widget build(BuildContext context) {
    // var spinKit = SpinKitWanderingCubes(color: Colors.black, size: 50.0);
    var spinKit = const SpinKitDualRing(
      color: Color(0xFF09648C),
      size: 150.0,
      lineWidth: 20,
    );

    return Scaffold(
      body: Center(
        child: spinKit,
      ),
    );
  }
}

void displayErrorDialog(BuildContext context, String text, String errorCode,
    dynamic destinationPage) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: const Text(
          "Error!",
          style: TextStyle(color: Colors.red),
        ),
        content: Text("$text\n\nError code: $errorCode"),
        actions: [
          TextButton(
            child: const Text("Retry"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => destinationPage));
            },
          ),
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.popUntil(
                  context, (Route<dynamic> route) => route.isFirst);
            },
          )
        ]),
  );
  // check = 0;
}

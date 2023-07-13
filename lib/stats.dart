import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets.dart';

class Stats extends StatefulWidget {
  Stats({super.key, required this.city});
  dynamic city;
  static String id = "stats_screen";
  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  dynamic suv;
  dynamic sedan;
  dynamic mini;
  dynamic active;
  dynamic cabs;
  dynamic drivers;
  String collectionName = 'Stats';

// String documentId = widget.city;
  Stream<DocumentSnapshot> getDocumentStream(
      String collectionName, String documentId) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(collectionName);
    DocumentReference documentRef = collectionRef.doc(documentId);

    return documentRef.snapshots();
  }

// Listen to changes in the document stream

  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> documentStream =
        getDocumentStream(collectionName, widget.city);
    StreamSubscription<DocumentSnapshot> subscription =
        documentStream.listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> fields = snapshot.data() as Map<String, dynamic>;
        setState(() {
                  cabs = fields['Cabs'];
        drivers = fields['Drivers'];
        mini = fields["Mini"];
        sedan = fields["Sedan"];
        suv = fields["SUV"];
        active = fields["Active Rides"];
        });

        print(cabs);
      } else {
        // Document does not exist
      }
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: ScreenUtil().setHeight(60),
        // toolbarHeight: (60),
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 0,
        title: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: ScreenUtil().setHeight(36),
            width: ScreenUtil().setWidth(120),
            child: Row(
              children: [
                Text('Cab',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(25))),
                Text('Wala',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(9, 100, 140, 1),
                        fontSize: ScreenUtil().setSp(25)))
              ],
            )),
        // fontSize: (30)))),

        actions: [
          Padding(
            padding:
                // EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                const EdgeInsets.symmetric(horizontal: (20)),
            child: SvgPicture.asset("images/profile.svg"),
          )
        ],
      ),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: ScreenUtil().setHeight(150),
                width: ScreenUtil().setWidth(160),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFC5E2F2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset("images/cabs.svg"),
                    Center(
                        child: Text(cabs.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ScreenUtil().setSp(24),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1F9D9D),
                            )))
                  ],
                ),
              ),
              Container(
                height: ScreenUtil().setHeight(150),
                width: ScreenUtil().setWidth(160),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFC5E2F2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset("images/driverbig.svg"),
                    Center(
                        child: Text(drivers.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ScreenUtil().setSp(24),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1F9D9D),
                            )))
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: ScreenUtil().setHeight(120),
                width: ScreenUtil().setWidth(120),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: const Color(0xFFC5E2F2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                        child: Text("Mini",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ScreenUtil().setSp(25),
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF09648C),
                            ))),
                    Center(
                        child: Text(mini.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ScreenUtil().setSp(24),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1F9D9D),
                            )))
                  ],
                ),
              ),
              Container(
                height: ScreenUtil().setHeight(120),
                width: ScreenUtil().setWidth(120),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: const Color(0xFFC5E2F2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                        child: Text("Sedan",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ScreenUtil().setSp(25),
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF09648C),
                            ))),
                    Center(
                        child: Text(sedan.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ScreenUtil().setSp(24),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1F9D9D),
                            )))
                  ],
                ),
              ),
              Container(
                height: ScreenUtil().setHeight(120),
                width: ScreenUtil().setWidth(120),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: const Color(0xFFC5E2F2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                        child: Text("SUV",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ScreenUtil().setSp(25),
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF09648C),
                            ))),
                    Center(
                        child: Text(suv.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ScreenUtil().setSp(24),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1F9D9D),
                            )))
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: ScreenUtil().setHeight(253),
            width: ScreenUtil().setWidth(334),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFC5E2F2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: Text("Active Cab Rides",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ScreenUtil().setSp(25),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF09648C),
                        ))),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset("images/road.svg"),
                      Center(
                          child: Text(active.toString(),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ScreenUtil().setSp(40),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1F9D9D),
                              )))
                    ])
              ],
            ),
          ),
        ]),
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavBar(0, 0, 1, context),
    );
  }
}

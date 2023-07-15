import 'dart:async';
import 'package:animated_number/animated_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets.dart';

class Stats extends StatefulWidget {
  dynamic city;
  dynamic cabs;
  dynamic suv;
  dynamic sedan ;
  dynamic mini ;
  dynamic active ;
  dynamic drivers ;
  Stats({super.key, required this.city, required this.cabs,required this.drivers,required this.mini,required this.sedan,required this.suv,required this.active});
  static String id = "stats_screen";
  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  // dynamic city;
  // dynamic suv = 0;
  // dynamic sedan = 0;
  // dynamic mini = 0;
  // dynamic active = 0;
  // // dynamic cabs = 0;
  // dynamic drivers = 0;
  String collectionName = 'Stats';

  List _allResults = [];
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
   // Call your async function here
  }

  @override
  Widget build(BuildContext context) {
    print(widget.city);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: ScreenUtil().setHeight(60),
        // toolbarHeight: (60),
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 0,
        title: InkWell(
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: ScreenUtil().setHeight(36),
              width: ScreenUtil().setWidth(120),
              child: SvgPicture.asset("images/backbutton.svg")),
              onTap: () => Navigator.of(context).pop(),
        ),
        // fontSize: (30)))),

        actions: [
          Padding(
            padding:
                // EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                const EdgeInsets.symmetric(horizontal: (20)),
            child: SvgPicture.asset("images/stats-appbar.svg"),
                // width: ScreenUtil().setWidth(24),
                // height: ScreenUtil().setHeight(30)),
          )
        ],
      ),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: ScreenUtil().setHeight(44),
                  width: ScreenUtil().setWidth(29),
                  child: Image.asset("images/location.png")),
              Text(widget.city,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: ScreenUtil().setSp(26),
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF09648C)))
            ],
          ),
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
                        child: AnimatedNumber(duration: const Duration(seconds: 2),startValue: 0,endValue:widget.cabs,isFloatingPoint: false, style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ScreenUtil().setSp(25),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1F9D9D),
                              ) ,),
                      ),
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
                        child: AnimatedNumber(duration: const Duration(seconds: 2),startValue: 0,endValue:widget.drivers,isFloatingPoint: false, style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ScreenUtil().setSp(25),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1F9D9D),
                              ) ,),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: ScreenUtil().setHeight(160),
            width: ScreenUtil().setWidth(334),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFC5E2F2)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                          child: Text("Mini",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ScreenUtil().setSp(24),
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF09648C),
                              ))),
                      SizedBox(
                          width: ScreenUtil().setWidth(85),
                          height: ScreenUtil().setHeight(72),
                          child: Image.asset("images/mini.png")),
                      Center(
                        child: AnimatedNumber(duration: const Duration(seconds: 2),startValue: 0,endValue:widget.mini,isFloatingPoint: false, style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ScreenUtil().setSp(25),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1F9D9D),
                              ) ,),
                      ),
                          // child: Text(widget.mini.toString(),
                              
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                          child: Text("Sedan",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ScreenUtil().setSp(24),
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF09648C),
                              ))),
                      SizedBox(
                          width: ScreenUtil().setWidth(85),
                          height: ScreenUtil().setHeight(72),
                          child: Image.asset("images/sedan.png")),
                      Center(
                        child: AnimatedNumber(duration: const Duration(seconds: 2),startValue: 0,endValue:widget.sedan,isFloatingPoint: false, style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ScreenUtil().setSp(25),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1F9D9D),
                              ) ,),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                          child: Text("SUV",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ScreenUtil().setSp(24),
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF09648C),
                              ))),
                      SizedBox(
                          width: ScreenUtil().setWidth(85),
                          height: ScreenUtil().setHeight(72),
                          child: Image.asset("images/suv.png")),
                      Center(
                        child: AnimatedNumber(duration: const Duration(seconds: 2),startValue: 0,endValue:widget.suv,isFloatingPoint: false, style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ScreenUtil().setSp(25),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1F9D9D),
                              ) ,),
                      ),
                    ],
                  ),
                ]),
          ),
          Container(
            height: ScreenUtil().setHeight(235),
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
                        child: AnimatedNumber(duration: const Duration(seconds: 2),startValue: 0,endValue:widget.active,isFloatingPoint: false, style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ScreenUtil().setSp(28),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1F9D9D),
                              ) ,),
                      ),
                    ])
              ],
            ),
          ),
        ]),
      ),
      // extendBody: true,
      bottomNavigationBar: BottomNavBar(0, 0, 1, context),
    );
  }
}

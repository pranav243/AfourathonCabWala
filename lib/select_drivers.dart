import 'package:cabwala/searchbar.dart';
import 'package:cabwala/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectDrivers extends StatefulWidget {
  static String id = 'SelectDrivers_screen';
  const SelectDrivers({super.key});

  @override
  State<SelectDrivers> createState() => _SelectDriversState();
}

class _SelectDriversState extends State<SelectDrivers> {
  final _firestore = FirebaseFirestore.instance;
  List<Widget> DriversWidget = [];
  @override
  void initState() {
    super.initState();
    getMessagesStream();
  }

  void getMessagesStream() async {
    await for (var snapshot in _firestore.collection("Drivers").snapshots()) {
      for (var Driver in snapshot.docs) {
        Widget widget = DriverCard(const Color(0xFFC5E2F2), Driver);
        DriversWidget.add(widget);
      }
    }
  }

  Widget DriverCard(color, Driver) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.only(left: 20,right: 20,top:10,bottom:10),
      height: ScreenUtil().setHeight(60),
      width: ScreenUtil().setWidth(312),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text(Driver.data()['Name'],style: const TextStyle(
                    color: Color(0xFF09648C),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,)),
                    ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text(Driver.data()['Hometown'],style: TextStyle(
      color: const Color(0xFF333434),
      fontSize: ScreenUtil().setSp(15),
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ))],
          ),
      ]),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: regularAppBar(context),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SearchBarWidget(searchfor: 'Drivers'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                children: DriversWidget,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(0, 0, context),
    );
  }
}

import 'package:cabwala/searchbar.dart';
import 'package:cabwala/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectCabs extends StatefulWidget {
  static String id = 'Selectcabs_screen';
  const SelectCabs({super.key});

  @override
  State<SelectCabs> createState() => _SelectCabsState();
}

class _SelectCabsState extends State<SelectCabs> {
  final _firestore = FirebaseFirestore.instance;
  List<Widget> cabsWidget = [];
  @override
  void initState() {
    super.initState();
    getMessagesStream();
  }

  void getMessagesStream() async {
    await for (var snapshot in _firestore.collection("Cabs").snapshots()) {
      for (var cab in snapshot.docs) {
        Widget widget = cabCard(const Color(0xFFC5E2F2), cab);
        cabsWidget.add(widget);
      }
    }
  }

  Widget cabCard(color, cab) {
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
            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Text(cab.data()['Model'],style: const TextStyle(
                    color: Color(0xFF09648C),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,)),
                    Container(
                      width:48,
                      height:16,
                  decoration: ShapeDecoration(
                      color: const Color(0xFFEAF7FF),
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                      ),),
                child: Center(child:Text(cab.data()['Type'],style: const TextStyle(
                    color: Color(0xFF09648C),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,)),
              ))]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text(cab.data()['Location'],style: TextStyle(
      color: const Color(0xFF333434),
      fontSize: ScreenUtil().setSp(15),
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ),),
                          // SizedBox(width: 200,),
            Text(cab.data()['RegNumber'],style: TextStyle(
        color: const Color(0xFF333434),
        fontSize: ScreenUtil().setSp(12),
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
            SearchBarWidget(searchfor: 'Cabs'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                children: cabsWidget,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(0, 0, context),
    );
  }
}

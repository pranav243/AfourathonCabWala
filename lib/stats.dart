import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Stats extends StatefulWidget {
  Stats(
      {super.key,
      required this.cabs,
      required this.drivers,
      required this.mini,
      required this.sedan,
      required this.suv,
      required this.active});
 int cabs=0;
 int drivers=0;
 int mini=0;
 int suv=0;
 int sedan=0;
 int active=0;
  static String id = "stats_screen";
  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
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
            // height: (36),
            // width: (120),
            child:  Row(
              children: [Text('Cab',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(25))),
                      Text('Wala',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(9, 100, 140, 1),
                      fontSize: ScreenUtil().setSp(25)))],
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
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
            Container(
                height: ScreenUtil().setHeight(150),
                width: ScreenUtil().setWidth(160),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFC5E2F2)),
                    child: Column(children: [SvgPicture.asset("images/cabs.svg"),Center(child: Text(widget.cabs.toString(),style:TextStyle(fontFamily: 'Poppins',fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600,color: Color(0xFF1F9D9D),)))],mainAxisAlignment:MainAxisAlignment.spaceEvenly ,),),
                    Container(
                height: ScreenUtil().setHeight(150),
                width: ScreenUtil().setWidth(160),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFC5E2F2)),
                    child: Column(children: [SvgPicture.asset("images/driverbig.svg"),Center(child: Text(widget.drivers.toString(),style:TextStyle(fontFamily: 'Poppins',fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600,color: Color(0xFF1F9D9D),)))],mainAxisAlignment:MainAxisAlignment.spaceEvenly ,),),
          
          ],),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
            Container(
                height: ScreenUtil().setHeight(120),
                width: ScreenUtil().setWidth(120),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Color(0xFFC5E2F2)),
                    child: Column(children: [Center(child: Text("Mini",style:TextStyle(fontFamily: 'Poppins',fontSize: ScreenUtil().setSp(25),fontWeight: FontWeight.w800,color: Color(0xFF09648C),))),Center(child: Text(widget.mini.toString(),style:TextStyle(fontFamily: 'Poppins',fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600,color: Color(0xFF1F9D9D),)))],mainAxisAlignment:MainAxisAlignment.spaceEvenly ,),),
                     Container(
                height: ScreenUtil().setHeight(120),
                width: ScreenUtil().setWidth(120),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Color(0xFFC5E2F2)),
                    child: Column(children: [Center(child: Text("Sedan",style:TextStyle(fontFamily: 'Poppins',fontSize: ScreenUtil().setSp(25),fontWeight: FontWeight.w800,color: Color(0xFF09648C),))),Center(child: Text(widget.sedan.toString(),style:TextStyle(fontFamily: 'Poppins',fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600,color: Color(0xFF1F9D9D),)))],mainAxisAlignment:MainAxisAlignment.spaceEvenly ,),),
                   Container(
                height: ScreenUtil().setHeight(120),
                width: ScreenUtil().setWidth(120),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Color(0xFFC5E2F2)),
                    child: Column(children: [Center(child: Text("SUV",style:TextStyle(fontFamily: 'Poppins',fontSize: ScreenUtil().setSp(25),fontWeight: FontWeight.w800,color: Color(0xFF09648C),))),Center(child: Text(widget.suv.toString(),style:TextStyle(fontFamily: 'Poppins',fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600,color: Color(0xFF1F9D9D),)))],mainAxisAlignment:MainAxisAlignment.spaceEvenly ,),),
                
          ],
          ),
          Container(
                height: ScreenUtil().setHeight(253),
                width: ScreenUtil().setWidth(334),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFC5E2F2)),
                    child: Column(children: [Center(child: Text("Active Cab Rides",style:TextStyle(fontFamily: 'Poppins',fontSize: ScreenUtil().setSp(25),fontWeight: FontWeight.w800,color: Color(0xFF09648C),))),Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [SvgPicture.asset("images/road.svg"),Center(child: Text(widget.active.toString(),style:TextStyle(fontFamily: 'Poppins',fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.w600,color: Color(0xFF1F9D9D),)))])],mainAxisAlignment:MainAxisAlignment.spaceEvenly ,),),
                    
        ]),
      ),
    );
  }
}
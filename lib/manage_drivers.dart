import 'package:cabwala/add_driver.dart';
import 'package:cabwala/search_drivers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cabwala/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverManager extends StatefulWidget {
  static String id = 'drivermanager_screen';

  const DriverManager({super.key});

  @override
  State<DriverManager> createState() => _DriverManagerState();
}

class _DriverManagerState extends State<DriverManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: regularAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddDriver(),
                    ));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.only(left: 20),
                height: ScreenUtil().setHeight(74),
                width: ScreenUtil().setWidth(312),
                // height: (74),
                // width: (312),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(39, 149, 208, 0.27),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      SvgPicture.asset("images/ellipse.svg"),
                      SvgPicture.asset("images/plus.svg")
                    ]),
                    const SizedBox(
                      width: 15,
                    ),
                    TitleWidget("Add Driver", "Register a new driver"),
                    const SizedBox(
                      width: 80,
                    ),
                    SvgPicture.asset("images/rightarrow.svg")
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchDrivers()));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(left: 20),
                height: ScreenUtil().setHeight(74),
                width: ScreenUtil().setWidth(312),
                // height: (74),
                // width: (312),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(39, 149, 208, 0.27),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      SvgPicture.asset("images/ellipse.svg"),
                      SvgPicture.asset("images/list.svg")
                    ]),
                    const SizedBox(
                      width: 15,
                    ),
                    TitleWidget("Driver Details", "Search/Edit/Remove Drivers"),
                    const SizedBox(
                      width: 50,
                    ),
                    SvgPicture.asset("images/rightarrow.svg")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavBar(0, 0, 0, context),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  static String id = 'home_screen';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        // toolbarHeight: ScreenUtil().setHeight(60),
        toolbarHeight: (60),
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 0,
        title: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            // height: ScreenUtil().setHeight(36),
            // width: ScreenUtil().setWidth(120),
            height: (36),
            width: (120),
            child: const Text('CabWala',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    // fontSize: ScreenUtil().setSp(30)))),
                    fontSize: (30)))),

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 15),
              // padding: EdgeInsets.all(ScreenUtil().setHeight(3)),
              // height: ScreenUtil().setHeight(74),
              // width: ScreenUtil().setWidth(312),
              height: (74),
              width: (312),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(39, 149, 208, 0.27),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(alignment: Alignment.center, children: [
                    SvgPicture.asset("images/ellipse.svg"),
                    SvgPicture.asset("images/driver.svg")
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Manage Drivers",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 0.5),
                      ),
                      SizedBox(
                        // height: ScreenUtil().setHeight(3),
                        height: (3),
                      ),
                      Text("Add/Delete/Update Drivers",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              letterSpacing: 0.5))
                    ],
                  ),
                  SvgPicture.asset("images/rightarrow.svg")
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              // padding: EdgeInsets.all(ScreenUtil().setHeight(3)),
              // height: ScreenUtil().setHeight(74),
              // width: ScreenUtil().setWidth(312),
              height: (74),
              width: (312),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(39, 149, 208, 0.27),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(alignment: Alignment.center, children: [
                    SvgPicture.asset("images/ellipse.svg"),
                    SvgPicture.asset("images/cab.svg")
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Manage Cabs",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 0.5),
                      ),
                      SizedBox(
                        // height: ScreenUtil().setHeight(3),
                        height: (3),
                      ),
                      Text("Add/Delete/Update Cabs",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              letterSpacing: 0.5))
                    ],
                  ),
                  SvgPicture.asset("images/rightarrow.svg")
                ],
              ),
            )
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(9, 100, 140, 1),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavBarHome(1),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset("images/profileset.svg"),
                  label: 'profileSettings')
            ]),
      ),
      // )
    );
  }
}

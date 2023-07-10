import 'package:cabwala/add_manager.dart';
// import 'package:cabwala/list_managers.dart';
import 'package:cabwala/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cabwala/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:cabwala/list_drivers.dart';

class Managers extends StatefulWidget {
  static String id = 'Managers_screen';

  const Managers({super.key});

  @override
  State<Managers> createState() => _ManagersState();
}

class _ManagersState extends State<Managers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: regularAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () => Navigator.pushNamed(context, AddManager.id),
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
                      SvgPicture.asset("images/plus.svg")
                    ]),
                    const SizedBox(
                      width: 20,
                    ),
                    TitleWidget("Add Manager", "Register a new manager"),
                    const SizedBox(
                      width: 80,
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
      bottomNavigationBar: BottomNavBar(0, 0, context),
    );
  }
}

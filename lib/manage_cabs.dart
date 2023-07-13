import 'package:cabwala/add_cab.dart';
import 'package:cabwala/search_cabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cabwala/widgets.dart';
import 'list_cabs.dart';
import 'searchbar.dart';

class CabManager extends StatefulWidget {
  static String id = 'CabManager_screen';

  const CabManager({super.key});

  @override
  State<CabManager> createState() => _CabManagerState();
}

class _CabManagerState extends State<CabManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: regularAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () => Navigator.pushNamed(context, AddCab.id),
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.only(left: 20),
                // height: ScreenUtil().setHeight(74),
                // width: ScreenUtil().setWidth(312),
                height: (74),
                width: (312),
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
                    TitleWidget("Add Cab", "Register a new cab"),
                    const SizedBox(
                      width: 80,
                    ),
                    SvgPicture.asset("images/rightarrow.svg")
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, SearchCabs.id),
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(left: 20),
                // height: ScreenUtil().setHeight(74),
                // width: ScreenUtil().setWidth(312),
                height: (74),
                width: (312),
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
                    TitleWidget("Cab Details", "Search/Edit/Remove Cabs"),
                    const SizedBox(
                      width: 50,
                    ),
                    SvgPicture.asset("images/rightarrow.svg")
                  ],
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(top: 12),
            //   child: SearchBarWidget(),
            // ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavBar(0, 0, 0,context),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        toolbarHeight: ScreenUtil().setHeight(60),
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 0,
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: ScreenUtil().setHeight(36),
              width: ScreenUtil().setWidth(120),
              child: Text.rich(
                // "Cab",
                // style: TextStyle(
                //     color: Colors.black, fontSize: ScreenUtil().setSp(30)),
                TextSpan(
                    text: 'Cab',
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(30)),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Wala',
                          style: TextStyle(
                              color: Color.fromARGB(1, 9, 100, 140),
                              fontSize: ScreenUtil().setSp(30)))
                    ]),
              )),
        ]),
        actions: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: SvgPicture.asset("images/profile.svg"),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      bottomNavigationBar: Text("Bottombar"),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

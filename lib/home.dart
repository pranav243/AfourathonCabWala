import 'package:cabwala/manage_drivers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login.dart';
import 'manage_cabs.dart';
import 'widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  static String id = 'home_screen';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> showLogoutAlert() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("Do you want to logout?"),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF09648C)), // Set the background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Set the text color
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    // Add more style properties as needed
                  ),
                  onPressed: logoutUser,
                  child: const Text("Yes")),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF09648C)), // Set the background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Set the text color
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    // Add more style properties as needed
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No")),
            ],
          );
        });
  }

  void logoutUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    print('User logged out');

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));

    User? user = auth.currentUser;

    if (user != null) {
      // User is logged in
      String uid = user.uid;
      String email = user.email!;
      // Access other user properties as needed
      print('User is logged in. UID: $uid, Email: $email');
    } else {
      // No user is currently logged in
      print('No user is currently logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: ScreenUtil().setHeight(60),
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
                        fontSize: ScreenUtil().setSp(27))),
                Text('Wala',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(9, 100, 140, 1),
                        fontSize: ScreenUtil().setSp(27)))
              ],
            )),
        actions: [
          GestureDetector(
            onTap: showLogoutAlert,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: (20)),
              child: SvgPicture.asset("images/logout.svg"),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () => Navigator.pushNamed(context, DriverManager.id),
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(left: 20),
                height: ScreenUtil().setHeight(74),
                width: ScreenUtil().setWidth(312),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(39, 149, 208, 0.27),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      SvgPicture.asset("images/ellipse.svg"),
                      SvgPicture.asset("images/driver.svg")
                    ]),
                    SizedBox(
                      width: ScreenUtil().setWidth(15),
                    ),
                    TitleWidget("Manage Drivers", "Add/Delete/Update Drivers"),
                    SizedBox(
                      width: ScreenUtil().setWidth(40),
                    ),
                    SvgPicture.asset("images/rightarrow.svg")
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, CabManager.id),
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                height: ScreenUtil().setHeight(74),
                width: ScreenUtil().setWidth(312),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(39, 149, 208, 0.27),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      SvgPicture.asset("images/ellipse.svg"),
                      SvgPicture.asset("images/cab.svg")
                    ]),
                    SizedBox(
                      width: ScreenUtil().setWidth(15),
                    ),
                    TitleWidget("Manage Cabs", "Add/Delete/Update Cabs"),
                    SizedBox(
                      width: ScreenUtil().setWidth(50),
                    ),
                    SvgPicture.asset("images/rightarrow.svg")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavBar(1, 0, 0, context),
      // )
    );
  }
}

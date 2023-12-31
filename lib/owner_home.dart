import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login.dart';
import 'widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cabwala/add_manager.dart';

class OwnerHome extends StatefulWidget {
  static String id = 'owner_OwnerHome';

  const OwnerHome({super.key});

  @override
  State<OwnerHome> createState() => _OwnerHomeState();
}

class _OwnerHomeState extends State<OwnerHome> {
  Future<void> showLogoutAlert() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: const Text(""),
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
        // fontSize: (30)))),

        actions: [
          GestureDetector(
            onTap: showLogoutAlert,
            child: Padding(
              padding:
                  // EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                  const EdgeInsets.symmetric(horizontal: (20)),
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
              onTap: () => Navigator.pushNamed(context, AddManager.id),
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
                      SvgPicture.asset("images/driver.svg")
                    ]),
                    const SizedBox(
                      width: 12,
                    ),
                    TitleWidget("Add Managers", "Authorize Manager Email IDs"),
                    const SizedBox(
                      width: 50,
                    ),
                    SvgPicture.asset("images/rightarrow.svg")
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavBar(1, 0, 0, context),
      // )
    );
  }
}

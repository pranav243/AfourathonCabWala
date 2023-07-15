import 'package:cabwala/loading_screen.dart';
import 'package:cabwala/stats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'login.dart';
import 'widgets.dart';

class StatsSearch extends StatefulWidget {
  const StatsSearch({super.key});
  static String id = "stats_search_screen";

  @override
  State<StatsSearch> createState() => _StatsSearchState();
}

class _StatsSearchState extends State<StatsSearch> {
       Future<void> showLogoutAlert() async {
    showDialog(context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            // title: const Text(""),
            content: const Text("Do you want to logout?"),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF09648C)), // Set the background color
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the text color
                 overlayColor: MaterialStateProperty.all<Color>(Colors.white),
                // Add more style properties as needed
                ),
                onPressed: logoutUser,
              child: const Text("Yes")),
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF09648C)), // Set the background color
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the text color
                 overlayColor: MaterialStateProperty.all<Color>(Colors.white),
                // Add more style properties as needed
                ),onPressed: (){
                Navigator.of(context).pop();
              }, child: const Text("No")),
            ],
          );
        }
    );
  }

  void logoutUser() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  await auth.signOut();
  print('User logged out');

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => const Login()));

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
  dynamic type;
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
            onTap:showLogoutAlert,
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
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(60),
            width: ScreenUtil().setWidth(308),
            child: DropdownButtonFormField(
              isDense: false,
              hint: const Text("Choose City"),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: const [
                DropdownMenuItem(
                  value: 'Bangalore',
                  child: Text("Bangalore, Karnataka"),
                ),
                DropdownMenuItem(
                  value: 'Chennai',
                  child: Text("Chennai, Tamil Nadu"),
                ),
                DropdownMenuItem(
                  value: 'Hyderabad',
                  child: Text("Hyderabad, Telangana"),
                ),
                DropdownMenuItem(
                  value: 'Mumbai',
                  child: Text("Mumbai, Maharashtra"),
                ),
                DropdownMenuItem(
                  value: 'New Delhi',
                  child: Text("New Delhi, Delhi"),
                ),
                DropdownMenuItem(
                  value: 'Pune',
                  child: Text("Pune, Maharashtra"),
                )
              ],
              onChanged: (String? value) {
                type = value!;
              },
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(51, 52, 52, 1)),
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromRGBO(196, 196, 196, 1)),
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          Stack(alignment: Alignment.center, children: [
            Positioned(child: Image.asset("images/maps-stats.png")),
            InkWell(
              onTap: (){ 
                if(type==null)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please choose a city.",
                            style:TextStyle(color: Colors.red,
                            fontWeight: FontWeight.w500)),
                    backgroundColor: Color(0xFFEAF7FF),
                    elevation: 10)); 
                }
                else
                {
                  // Navigator.pushNamed(context, Stats.id,
                  //     arguments: {'city': type!.toString()});
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoadingScreen(city: type,),
                      ),
                    );
                }
              },
              child: Container(
                width: ScreenUtil().setWidth(180),
                height: ScreenUtil().setHeight(47),
                decoration: ShapeDecoration(
                  color: const Color(0xFFEAF7FF),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 2.50,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF09648C),
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Go to Statistics',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF09648C),
                      fontSize: ScreenUtil().setSp(16),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ],
      )),
      extendBody: true,
      bottomNavigationBar: BottomNavBar(0, 0, 1, context),
    );
  }
}
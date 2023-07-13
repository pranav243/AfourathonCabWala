import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cabwala/widgets.dart';
import 'owner_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerLogin extends StatefulWidget {
  const OwnerLogin({super.key});
  static String id = "owner_login_screen";

  @override
  State<OwnerLogin> createState() => _OwnerLoginState();
}

class _OwnerLoginState extends State<OwnerLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  Future<bool> checkValueExists(String collectionPath, String fieldName, dynamic value) async {
  final QuerySnapshot snapshot = await FirebaseFirestore.instance
    .collection(collectionPath)
    .where(fieldName, isEqualTo: value)
    .limit(1)
    .get();

  return snapshot.size > 0;
}
  Future<void> invalidPassword() async {
    showDialog(context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: const Text("Wrong Password !",
            style: TextStyle(
              color: Colors.red,),
              ),
            content: const Text("Password is incorrect."),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF09648C)), // Set the background color
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the text color
                 overlayColor: MaterialStateProperty.all<Color>(Colors.white),
                // Add more style properties as needed
                ),onPressed: (){
                Navigator.of(context).pop();
              }, child: const Text("OK")),
            ],
          );
        }
    );
  }

Future<void> notRegistered() async {
    showDialog(context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: const Text("Not an Owner"),
            content: const Text("This email ID is not a registered owner."),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF09648C)), // Set the background color
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the text color
                 overlayColor: MaterialStateProperty.all<Color>(Colors.white),
                // Add more style properties as needed
                ),onPressed: (){
                Navigator.of(context).pop();
              }, child: const Text("OK")),
            ],
          );
        }
    );
  }

void handleCheckValue() async {
    bool exists = await checkValueExists("Owners","Email ID",_email);
    if (exists) {
       _auth.signInWithEmailAndPassword(email: _email, password: _password).then((value) {
        // print("Signed in");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const OwnerHome()));
      },).onError((error, stackTrace) {
        invalidPassword();
        // print("ERROR ${error.toString()}");
      });
      // Value exists
      // print('You are not an owner');
    } 
    else {
      notRegistered();
      // Value does not exist
      // print('Value does not exist in the collection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 50),
              Image.asset(
                'images/icon.png',
                width: ScreenUtil().setWidth(46),
                height: ScreenUtil().setHeight(69),
              ),
              SvgPicture.asset(
                'images/applogo.svg',
                width: ScreenUtil().setWidth(248),
                height: ScreenUtil().setHeight(69),
              ),
              const SizedBox(width: 50),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(25),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(25),
            width: ScreenUtil().setWidth(133),
            child: Text("Log in to continue",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(14),
                    color: const Color(0xFF9098B1))),
          ),
          InputBox("Email ID", TextInputType.emailAddress),
          InputBox("Password", TextInputType.text),
          InkWell(
            onTap: handleCheckValue ,
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(308),
              height: ScreenUtil().setHeight(47),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(9, 100, 140, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: const Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      )),
    );
  }

  //  Column InputBox(title, keyboardType) {
  Column InputBox(title, keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(title),
        SizedBox(
          height: 46.79,
          width: 307.91,
          child: TextField(
            obscureText: title == "Password" ? true : false,
            onChanged: (value) {
              if (title == 'Password') {
                _password = value;
              } else if (title == 'Email ID') {
                _email = value;
              }
            },
            autocorrect: false,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: keyboardType,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(51, 52, 52, 1)),
            decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Color.fromRGBO(196, 196, 196, 1)),
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}

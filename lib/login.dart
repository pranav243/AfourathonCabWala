import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cabwala/widgets.dart';
import 'package:cabwala/register.dart';
import 'owner_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';


class Login extends StatefulWidget {
  const Login({super.key});
  static String id = "login_screen";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

Future<void> notRegistered() async {
    showDialog(context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: const Text("Account does not exist"),
            content: const Text("Create a new manager account."),
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

void _login() async {
  
      bool exists = await checkValueExists('Managers', 'Email ID', _email);
      if(exists)
      {
      invalidPassword();
      }
      // final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      //   email: _email,
      //   password: _password,
      // );
      // Login successful, do something
      else 
      {
      notRegistered();
      // print('Error: $e');
      print('Error: You are not registered as owner');
      // Login failed, show error message
      }
    
}
// void accountexists() async {
  
//       bool exists = await checkValueExists('Managers', 'Email ID', _email);
//       if(exists)
//       {
//         QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('your_collection')
//         .where('field_name', isEqualTo: 'desired_field_value')
//         .get();

//         String documentId = snapshot.docs[0].id;

//         DocumentReference documentRef = FirebaseFirestore.instance.collection('your_collection').doc(documentId);
//         DocumentSnapshot snapshot1 = await documentRef.get();
//         if (snapshot1.exists) {
//         Map<String, dynamic> data = snapshot1.data();
//         }
//       }
//       // final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//       //   email: _email,
//       //   password: _password,
//       // );
//       // Login successful, do something
//       else 
//       {
//       notRegistered();
//       // print('Error: $e');
//       print('Error: You are not registered as owner');
//       // Login failed, show error message
//       }
    
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            onTap: ()=>{
              _auth.signInWithEmailAndPassword(email: _email, password: _password).then((value) {
                print("Logged in");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Home()));
              },).onError((error, stackTrace) {
                _login();
                print("ERROR ${error.toString()}");
            })
            },
            // onTap: _login,
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
          SizedBox(
            height: ScreenUtil().setHeight(16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(
                    color: const Color.fromRGBO(144, 152, 177, 1),
                    fontSize: ScreenUtil().setSp(12),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Register()));
                },
                child: Text(
                  " Create new account",
                  style: TextStyle(
                      color: const Color(0xFF09648C),
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                ),
              )
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OwnerLogin()));
              },
              child: Text(
                'Login as Owner',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF09648C),
                  fontSize: ScreenUtil().setSp(16),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              )),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cabwala/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static String id = "register_screen";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _name = '';
  String _contact = '';

  Future<Map<String, dynamic>> checkValueExists(String collectionPath, String fieldName, String valueToCheck) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(collectionPath)
        .where(fieldName, isEqualTo: valueToCheck)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final documentId = snapshot.docs[0].id;
      return {'exists': true, 'documentId': documentId};
    } else {
      return {'exists': false, 'documentId': null};
    }
  }

  //   Future<void> addField() async {
  //   final DocumentReference documentRef = FirebaseFirestore.instance
  //       .collection(collectionPath)
  //       .doc(documentId);

  //   try {
  //     await documentRef.update({
  //       fieldName: fieldValue,
  //     });
  //     print('Field added successfully');
  //   } catch (e) {
  //     print('Error adding field: $e');
  //   }
  // }

  // Future<bool> checkValueExists(String collection, String field, String value) async {
  //   final QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection(collection)
  //       .where(field, isEqualTo: value)
  //       .limit(1)
  //       .get();

  //   return snapshot.docs.isNotEmpty;
  // }
    void handleCheckValue() async {
    Map<String,dynamic> val = await checkValueExists("Managers","Email ID",_email);
    if (val['exists']) {
      
       _auth.createUserWithEmailAndPassword(email: _email, password: _password).then((value) {
        final DocumentReference documentRef = FirebaseFirestore.instance
        .collection('Managers')
        .doc(val['documentId']);
        documentRef.update({
        "Contact": _contact.toString(),
        "Name": _name,
      });
        print("Created new account");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Home()));
      },).onError((error, stackTrace) {print("ERROR ${error.toString()}");
      });
      // Value exists
      print('You are not a manager');
    } 
    else {
      // Value does not exist
      print('Value does not exist in the collection');
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
                width: 46,
                height: 69,
              ),
              SvgPicture.asset(
                'images/applogo.svg',
                width: 248,
                height: 69,
              ),
              SizedBox(width: 50),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(25),
          ),
          InputBox("Name", TextInputType.name),
          InputBox("Contact", TextInputType.phone),
          InputBox("Email ID", TextInputType.emailAddress),
          InputBox("Password", TextInputType.text),
          InkWell(
            onTap:handleCheckValue,
            // onTap: ()=>{

            //   _auth.createUserWithEmailAndPassword(email: _email, password: _password).then((value) {
            //     print("Created new account");
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const Home()));
            //   },).onError((error, stackTrace) {print("ERROR ${error.toString()}");
            //   })
            // }, 
            child: Container(
              alignment: Alignment.center,
              width: 307.91,
              height: 46.79,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(9, 100, 140, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: const Text(
                "Register",
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
                "Waiting for owner to approve request",
                style: TextStyle(
                    color: const Color.fromRGBO(144, 152, 177, 1),
                    fontSize: ScreenUtil().setSp(12),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5),
              ),
            ],
          )
        ],
      )),
    );
  }

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
              } else if (title == 'Name') {
                _name = value;
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

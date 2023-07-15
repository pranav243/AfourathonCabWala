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

  final TextEditingController _controller = TextEditingController(text: '+91 ');

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

Future<void> notAuthorized() async {
    showDialog(context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: const Text("Unauthorized Email ID !"),
            content: const Text("You are not authorized to be a manager."),
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
                ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Welcome to CabWala.',
                            style:TextStyle(color: Color(0xFF09648C),
                            fontWeight: FontWeight.w500)),
                            backgroundColor: Color(0xFFEAF7FF),
                            elevation: 10));
      },).onError((error, stackTrace) {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Welcome to CabWala'),));
        notAuthorized();
        print("ERROR ${error.toString()}");
      });
      // Value exists
      print('You are not a manager');
    } 
    else {
      notAuthorized();
      // Value does not exist
      print('Value does not exist in the collection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: 30,
          // ),
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
              const SizedBox(width: 50),
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
                "Sign Up",
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
                "Only authorized email IDs can register",
                style: TextStyle(
                    color: const Color.fromRGBO(144, 152, 177, 1),
                    fontSize: ScreenUtil().setSp(12),
                    fontWeight: FontWeight.w500,
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
          height: 40,
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
              else if (title == 'Contact') {
                _contact = value;
              }
            },
            autocorrect: false,
            controller: title=='Contact'?_controller:null,
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
          height: 10,
        )
      ],
    );
  }
}

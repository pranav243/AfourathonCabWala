import 'package:cabwala/manage_drivers.dart';
import 'package:cabwala/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDriver extends StatefulWidget {
  static String id = "adddriver_screen";
  dynamic driverId;
  AddDriver({super.key});

  @override
  State<AddDriver> createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {
  final _firestore = FirebaseFirestore.instance;

//   Future<String> getDriverId() async {
//   CollectionReference collectionRef =_firestore.collection('Drivers');
//   QuerySnapshot querySnapshot = await collectionRef.get();
//   CollectionReference collectionRef2 =_firestore.collection('Deleted Drivers');
//   QuerySnapshot querySnapshot2 = await collectionRef2.get();
//   int driverCount = querySnapshot.size;
//   int deletedDriverCount = querySnapshot2.size;
//   String drivers="d${driverCount+deletedDriverCount}";
//   return drivers;
// }
// String? getTotalDocumentsCount() {
//   CollectionReference collectionRef =FirebaseFirestore.instance.collection('Drivers');
//   CollectionReference collectionRef2 =FirebaseFirestore.instance.collection('Deleted Drivers');

//   int totalDocumentsCount = 0;
//   int totalDocumentsCount2 = 0;

//   collectionRef.snapshots().listen((QuerySnapshot querySnapshot) {
//     totalDocumentsCount = querySnapshot.size;
//   });
//   collectionRef2.snapshots().listen((QuerySnapshot querySnapshot2) {
//     totalDocumentsCount2 = querySnapshot2.size;
//   });

//   String drivers="d${totalDocumentsCount+totalDocumentsCount2}";
//   return drivers;
// }

  String email = '';
  String name = '';
  String contact = '';
  String home = '';
  String linkedTo = '';
  String driverId = '';
  

  // @override
  // void initState() {
  //   driverID=widget.driverId;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: regularAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset("images/ellipse2.svg"),
                SvgPicture.asset("images/driverbig.svg")
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            // Text("Driver ID : $driverID",
            // style: TextStyle(color:const Color.fromRGBO(9, 100, 140, 1),  ),),
            InputBox("Name", TextInputType.name),
            InputBox("Contact", TextInputType.phone),
            InputBox("Email ID", TextInputType.emailAddress),
            InputBox("Hometown", TextInputType.name),
            InkWell(
              onTap: () {
                _firestore.collection("Drivers").add({
                  'Driver ID':"d-${home.substring(0,2)}-${contact.substring(contact.length - 4)}",
                  'Contact': contact,
                  'Email ID': email,
                  'Hometown': home,
                  'Name': name,
                  'Linked': false,
                  'Cab Linked':linkedTo
                });
                Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DriverManager()));
                ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Added a new driver.",
                            style:TextStyle(color: Color(0xFF09648C),
                            fontWeight: FontWeight.w500)),
                            backgroundColor: Color(0xFFEAF7FF),
                            elevation: 10));
              },
              child: Container(
                alignment: Alignment.center,
                width: 307.91,
                height: 46.79,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(9, 100, 140, 1),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  "Add Driver",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavBar(0, 0, 0, context),
    );
  }

  // ignore: non_constant_identifier_names
  Column InputBox(title, keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(title),
        SizedBox(
          height: 46.79,
          width: 307.91,
          child: TextField(
            onChanged: (value) {
              if (title == 'Name') {
                name = value;
              } else if (title == "Contact") {
                contact = value;
              } else if (title == 'Email ID') {
                email = value;
              } else if (title == 'Hometown') {
                home = value;
              }
              // driverId = "d-${home.substring(0,3)}-${contact.substring(contact.length - 4)}";
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
    // ignore: non_constant_identifier_names
    Column FixedBox(title,hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(title),
        const SizedBox(
          height: 46.79,
          width: 307.91,
          child: TextField(
            enabled:false,
            autocorrect: false,
            textAlignVertical: TextAlignVertical.center,
            // keyboardType: keyboardType,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(51, 52, 52, 1)),
            decoration: InputDecoration(
                // hintText: hint,
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

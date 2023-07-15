import 'package:cabwala/manage_drivers.dart';
import 'package:cabwala/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AddDriver extends StatefulWidget {
  static String id = "adddriver_screen";
  dynamic driverId;
  AddDriver({super.key});

  @override
  State<AddDriver> createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _controller = TextEditingController(text: '+91 ');

  String email = '';
  String name = '';
  String contact = '';
  String home = '';
  String linkedTo = '';
  String driverId = '';

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
            SizedBox(
              height: ScreenUtil().setHeight(16),
            ),
            // Text("Driver ID : $driverID",
            // style: TextStyle(color:const Color.fromRGBO(9, 100, 140, 1),  ),),
            InputBox("Name", TextInputType.name),
            InputBox("Contact", TextInputType.phone),
            InputBox("Email ID", TextInputType.emailAddress),
            Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            InputTitle("Location"),
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
                  home = value!;
                },
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(51, 52, 52, 1)),
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromRGBO(196, 196, 196, 1)),
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),const SizedBox(
                height: 20,
              )],),
            InkWell(
              onTap: () {
                if(contact==''||email==''||home==''||name=='')
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all fields.",
                            style:TextStyle(color: Colors.red,
                            fontWeight: FontWeight.w400)),
                    backgroundColor: Color(0xFFEAF7FF),
                    elevation: 10));
                }
                else
                {
                _firestore.collection("Drivers").add({
                  'Driver ID':
                      "d-${home.substring(0, 3).toLowerCase()}-${contact.substring(contact.length - 4)}",
                  'Contact': contact,
                  'Email ID': email,
                  'Hometown': home,
                  'Name': name,
                  'Linked': false,
                  'Cab Linked': linkedTo
                });
                var docRef = _firestore.collection('Stats').doc(home);
                docRef.update(
                  {"Drivers": FieldValue.increment(1),
                  "Active Rides": FieldValue.increment(1),},
                );
                Navigator.pushReplacement(
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
              }
              },
              child: Container(
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(60),
                width: ScreenUtil().setWidth(308),
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
      // bottomNavigationBar: BottomNavBar(0, 0, 0, context),
    );
  }

  // ignore: non_constant_identifier_names
  Column InputBox(title, keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(title),
        SizedBox(
          height: ScreenUtil().setHeight(60),
          width: ScreenUtil().setWidth(308),
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
            controller: title=='Contact'?_controller:null,
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
          height: 12,
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Column FixedBox(title, hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(title),
        const SizedBox(
          height: 46.79,
          width: 307.91,
          child: TextField(
            enabled: false,
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
          height: 12,
        )
      ],
    );
  }
}

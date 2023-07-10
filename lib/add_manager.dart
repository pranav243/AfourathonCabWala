import 'package:cabwala/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddManager extends StatefulWidget {
  static String id = "AddManager";
  const AddManager({super.key});

  @override
  State<AddManager> createState() => _AddManagerState();
}

class _AddManagerState extends State<AddManager> {
  final _firestore = FirebaseFirestore.instance;
  String email = '';
  String name = '';
  dynamic contact = '';
  // String home = '';
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
              height: 5,
            ),
            // InputBox("Name", TextInputType.name),
            // InputBox("Contact", TextInputType.phone),
            InputBox("Email ID", TextInputType.emailAddress),
            // InputBox("Hometown", TextInputType.name),
            InkWell(
              onTap: () {
                _firestore.collection("Managers").add({
                  'Contact': contact,
                  'Email ID': email,
                  // 'Hometown': home,
                  'Name': name
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: 307.91,
                height: 46.79,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(9, 100, 140, 1),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  "Add Manager",
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
      bottomNavigationBar: BottomNavBar(0, 0, context),
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
            onChanged: (value) {
              if (title == 'Name') {
                name = value;
              } else if (title == "Contact") {
                contact = value;
              } else if (title == 'Email ID') {
                email = value;
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
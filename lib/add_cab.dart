import 'package:cabwala/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'manage_cabs.dart';

class AddCab extends StatefulWidget {
  static String id = "addCab_screen";
  const AddCab({super.key});

  @override
  State<AddCab> createState() => _AddCabState();
}

class _AddCabState extends State<AddCab> {
  final _firestore = FirebaseFirestore.instance;

  String regno = '', model = '', colour = '', type = '',location='';
  String linkedTo = '';
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
                SvgPicture.asset("images/cabbig.svg")
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            InputBox("Registration Number", TextInputType.name),
            InputBox("Model", TextInputType.name),
            InputBox("Colour", TextInputType.name),
            InputBox("Location", TextInputType.name),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              InputTitle("Cab Type"),
              SizedBox(
                  height: 46.79,
                  width: 307.91,
                  child: DropdownButtonFormField(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: const [
                      DropdownMenuItem(
                        value: 'Mini',
                        child: Text("Mini"),
                      ),
                      DropdownMenuItem(
                        value: 'Sedan',
                        child: Text("Sedan"),
                      ),
                      DropdownMenuItem(
                        value: 'SUV',
                        child: Text("SUV"),
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
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(196, 196, 196, 1)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  )),
              const SizedBox(
                height: 20,
              )
            ]),
            InkWell(
              onTap: () {
                _firestore.collection("Cabs").add({
                  'Colour': colour,
                  'Model': model,
                  'RegNumber': regno,
                  'Location': location,
                  'Type': type,
                  'Linked': false,
                  'Driver Linked':linkedTo,
                });
                Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CabManager()));
                ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Added a new cab.",
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
                  "Add Cab",
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
      // bottomNavigationBar: BottomNavBar(0, 0, context),
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
              if (title == 'Registration Number') {
                regno = value;
              } else if (title == "Model") {
                model = value;
              } else if (title == 'Colour') {
                colour = value;
              } else if (title == 'Cab Type') {
                type = value;
              } else if (title == 'Location') {
                location = value;
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

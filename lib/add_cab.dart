import 'package:cabwala/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  location = value!;
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              InputTitle("Cab Type"),
              SizedBox(
              height: ScreenUtil().setHeight(60),
              width: ScreenUtil().setWidth(308),
                  child: DropdownButtonFormField(
                    hint: Text("Choose Cab Type"),
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
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
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
                if(colour==''||model==''||regno==''||type==''||location=='')
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
                _firestore.collection("Cabs").add({
                  'Colour': colour,
                  'Model': model,
                  'RegNumber': regno,
                  'Location': location,
                  'Type': type,
                  'Linked': false,
                  'Driver Linked':linkedTo,
                });
                var docRef = _firestore.collection('Stats').doc(location);
                docRef.update({"Cabs": FieldValue.increment(1),});
                if(type=='Mini')
                {docRef.update({"Mini": FieldValue.increment(1),});}
                else if(type=='Sedan')
                {docRef.update({"Sedan": FieldValue.increment(1),});}
                else if(type=='SUV')
                {docRef.update({"SUV": FieldValue.increment(1),});}
                
                Navigator.pushReplacement(
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
              }
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
      // bottomNavigationBar: BottomNavBar(0, 0, 0, context),
    );
  }

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
          height: 12,
        )
      ],
    );
  }
}

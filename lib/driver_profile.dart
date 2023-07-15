import 'package:cabwala/search_drivers.dart';
import 'package:cabwala/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DriverProfile extends StatefulWidget {
  static String id = "DriverProfile_screen";
  dynamic docId;
  dynamic driverId;
  dynamic name;
  dynamic contact;
  dynamic location;
  dynamic emailId;

  DriverProfile(
      {super.key,
      required this.docId,
      required this.driverId,
      required this.name,
      required this.contact,
      required this.location,
      required this.emailId});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  final _firestore = FirebaseFirestore.instance;

  String? ic1, ic2, ic3, ic4, ic5, ic6;

  Future<void> showRemoveAlert() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Remove Driver ?"),
            content: const Text("This will delete the driver data."),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFE86666)), // Set the background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Set the text color
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    // Add more style properties as needed
                  ),
                  onPressed: () {
                    _firestore.collection("Drivers").doc(ic1).delete();
                    _firestore.collection("Deleted Drivers").add({
                      'Contact': widget.contact,
                      'Email ID': widget.emailId,
                      'Hometown': widget.location,
                      'Name': widget.name,
                    });
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchDrivers()));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Deleted driver from database.',
                            style: TextStyle(
                                color: Color(0xFF09648C),
                                fontWeight: FontWeight.w500)),
                        backgroundColor: Color(0xFFEAF7FF),
                        elevation: 10));
                  },
                  child: const Text("Delete")),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF09648C)), // Set the background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Set the text color
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    // Add more style properties as needed
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
            ],
          );
        });
  }

  Future<void> showEditAlert() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Change Driver Details ?"),
            content:
                const Text("Are you sure you want to edit driver details?"),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF09648C)), // Set the background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Set the text color
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.white),

                    // Add more style properties as needed
                  ),
                  onPressed: () {
                    _firestore.collection("Drivers").doc(ic1).update({
                      'Contact': contact != "" ? contact : ic4,
                      'Name': name != "" ? name : ic3,
                      'Driver ID': driverId != "" ? driverId : ic2,
                      'Hometown': location != "" ? location : ic5,
                      'Email ID': emailId != "" ? emailId : ic6,
                    });
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchDrivers()));
                  },
                  child: const Text("Yes")),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF09648C)), // Set the background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Set the text color
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    // Add more style properties as needed
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No")),
            ],
          );
        });
  }

  @override
  void initState() {
    ic1 = widget.docId;
    ic2 = widget.driverId;
    ic3 = widget.name;
    ic4 = widget.contact;
    ic5 = widget.location;
    ic6 = widget.emailId;
  }

  final TextEditingController _initialController1 = TextEditingController();
  final TextEditingController _initialController2 = TextEditingController();
  final TextEditingController _initialController3 = TextEditingController();
  final TextEditingController _initialController4 = TextEditingController();

  @override
  void dispose() {
    _initialController1.dispose();
    _initialController2.dispose();
    _initialController3.dispose();
    _initialController4.dispose();
    super.dispose();
  }

  String driverId = '', name = '', contact = '', emailId = '', location = '';
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
            Text(
              "DriverID : $ic2",
              style: const TextStyle(color: Color(0xFF09648C)),
            ),
            const SizedBox(
              height: 16,
            ),
            InputBox("Name | $ic3", "Name", TextInputType.name),
            InputBox("Email ID | $ic6", "Email ID", TextInputType.emailAddress),
            InputBox("Contact | $ic4", "Contact", TextInputType.phone),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DetailTitle("Hometown | $ic5"),
              SizedBox(
                  height: ScreenUtil().setHeight(38),
                  width: ScreenUtil().setWidth(308),
                  child: DropdownButtonFormField(
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
                        fontWeight: FontWeight.w400, color: Color(0xFF09648C)),
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
              onTap: showEditAlert,
              child: Container(
                alignment: Alignment.center,
                width: 307.91,
                height: 46.79,
                decoration: BoxDecoration(
                    color: const Color(0xFF09648C),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: showRemoveAlert,
              child: Container(
                alignment: Alignment.center,
                width: 307.91,
                height: 46.79,
                decoration: BoxDecoration(
                    color: const Color(0xFFE86666),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  "Remove Driver",
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
    );
  }

  Column InputBox(title, key, keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailTitle(title),
        SizedBox(
          height: 38,
          width: 307.91,
          child: TextField(
            controller: key == 'Name'
                ? _initialController1
                : (key == 'Email ID'
                    ? _initialController2
                    : (key == 'Contact'
                        ? _initialController3
                        : (key == 'Location'
                            ? _initialController4
                            : _initialController4))),
            onChanged: (value) {
              if (key == 'Driver ID') {
                driverId = value;
              } else if (key == "Name") {
                name = value;
              } else if (key == 'Contact') {
                contact = value;
              } else if (key == 'Email ID') {
                emailId = value;
              } else if (key == 'Location') {
                location = value;
              }
            },
            autocorrect: false,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: keyboardType,
            style: const TextStyle(
                fontWeight: FontWeight.w400, color: Color(0xFF09648C)),
            decoration: const InputDecoration(
                hintText: "Edit Detail",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Color.fromRGBO(196, 196, 196, 1)),
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

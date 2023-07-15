import 'package:cabwala/search_cabs.dart';
import 'package:cabwala/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CabProfile extends StatefulWidget {
  static String id = "CabProfile_screen";
  dynamic docId;
  dynamic regnumber;
  dynamic model;
  dynamic colour;
  dynamic location;
  dynamic type;

  CabProfile({super.key,required this.docId,required this.regnumber,required this.model,required this.colour,required this.location,required this.type});
  
  @override
  State<CabProfile> createState() => _CabProfileState();
}

class _CabProfileState extends State<CabProfile> {
  final _firestore = FirebaseFirestore.instance;
  // DocumentReference documentRef = FirebaseFirestore.instance.collection('Cabs').doc(CabProfile.docId);
  // CabProfile cb =CabProfile();
  String? ic1,ic2,ic3,ic4,ic5,ic6;

   Future<void> showRemoveAlert() async {
    showDialog(context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: const Text("Remove Cab ?"),
            content: const Text("This will delete the cab data."),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFE86666)), // Set the background color
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the text color
                 overlayColor: MaterialStateProperty.all<Color>(Colors.white),
                // Add more style properties as needed
                ),
                onPressed: (){
                _firestore.collection("Cabs").doc(ic1).delete();
                _firestore.collection("Deleted Cabs").add({
                  'Colour': widget.colour,
                  'Model': widget.model,
                  'RegNumber': widget.regnumber,
                  'Location': widget.location,
                  'Type': widget.type,
                });
                // Navigator.pop(context);
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchCabs()));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Deleted cab from database.',
                            style:TextStyle(color: Color(0xFF09648C),
                            fontWeight: FontWeight.w500)),
                            backgroundColor: Color(0xFFEAF7FF),
                            elevation: 10));
                  }, 
              child: const Text("Delete")),
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF09648C)), // Set the background color
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the text color
                 overlayColor: MaterialStateProperty.all<Color>(Colors.white),
                // Add more style properties as needed
                ),onPressed: (){
                Navigator.of(context).pop();
              }, child: const Text("Cancel")),
            ],
          );
        }
    );
  }
     Future<void> showEditAlert() async {
    showDialog(context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: const Text("Change Cab Details ?"),
            content: const Text("Are you sure you want to edit cab details?"),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF09648C)), // Set the background color
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the text color
                 overlayColor: MaterialStateProperty.all<Color>(Colors.white),

                // Add more style properties as needed
                ),
                onPressed: (){
                // Navigator.pop(context);
                _firestore.collection("Cabs").doc(ic1).update({
                  'Colour': colour!=""?colour:ic4,
                  'Model': model!=""?model:ic3,
                  'RegNumber': regno!=""?regno:ic2,
                  'Location': location!=""?location:ic5,
                  'Type': type!=""?type:ic6,
                });
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchCabs()));
                // Navigator.pop(context);
                // int count = 0;
                // Navigator.of(context).popUntil((_) => count++ >= 2);
              }, child: const Text("Yes")),
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF09648C)), // Set the background color
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the text color
                 overlayColor: MaterialStateProperty.all<Color>(Colors.white),
                // Add more style properties as needed
                ),
                onPressed: (){
                Navigator.of(context).pop();
              }, child: const Text("No")),
            ],
          );
        }
    );
  }

  @override
  void initState() {
    ic1=widget.docId;
    ic2=widget.regnumber;
    ic3=widget.model;
    ic4=widget.colour;
    ic5=widget.location;
    ic6=widget.type;
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

  String regno = '', model = '', colour = '', type = '',location='';
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
            InputBox("Registration Number | $ic2","Registration Number", TextInputType.name),
            InputBox("Model | $ic3","Model", TextInputType.name),
            InputBox("Colour | $ic4","Colour", TextInputType.name),
            // InputBox("Location", TextInputType.name),
            // InputBox("Location | $ic5","Location",TextInputType.name),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DetailTitle("Location | $ic5"),
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DetailTitle("Cab Type | $ic6"),
              SizedBox(
                  height: 38,
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
                        color: Color(0xFF09648C)),
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
              // onTap: () {
              //   _firestore.collection("Cabs").doc(ic1).delete();
              // },
              child: Container(
                alignment: Alignment.center,
                width: 307.91,
                height: 46.79,
                decoration: BoxDecoration(
                    color: const Color(0xFFE86666),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  "Remove Cab",
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

  Column InputBox(title, key, keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailTitle(title),
        SizedBox(
          height: 38,
          width: 307.91,
          child: TextField(
          controller : key=='Registration Number'?_initialController1:(key=='Model'?_initialController2:(key=='Colour'?_initialController3:(key=='Location'?_initialController4:_initialController4))) ,
            onChanged: (value) {
              if (key == 'Registration Number') {
                regno = value;
              } else if (key == "Model") {
                model = value;
              } else if (key == 'Colour') {
                colour = value;
              } else if (key == 'Cab Type') {
                type = value;
              } else if (key == 'Location') {
                location = value;
              }
            },
            autocorrect: false,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: keyboardType,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Color(0xFF09648C)),
            decoration: const InputDecoration(
                hintText:"Edit Detail",
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
        // Text('${ic1}'),
      ],
    );
  }

  // Column FixedBox(title,key) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       InputTitle(title),
  //       SizedBox(
  //         height: 46.79,
  //         width: 307.91,
  //         child: TextFormField(
  //           enabled:false,
  //           onChanged: (value) {
  //             if (key == 'Registration Number') {
  //               regno = value;
  //             } else if (key == "Model") {
  //               model = value;
  //             } else if (key == 'Colour') {
  //               colour = value;
  //             } else if (key == 'Cab Type') {
  //               type = value;
  //             } else if (key == 'Location') {
  //               location = value;
  //             }
  //           },
  //           autocorrect: false,
  //           textAlignVertical: TextAlignVertical.center,
  //           // keyboardType: keyboardType,
  //           style: const TextStyle(
  //               fontWeight: FontWeight.w400,
  //               color: Color.fromRGBO(51, 52, 52, 1)),
  //           decoration: const InputDecoration(
  //               hintText: "Kanpur",
  //               contentPadding:
  //                   EdgeInsets.symmetric(vertical: 5, horizontal: 15),
  //               border: OutlineInputBorder(
  //                   borderSide: BorderSide(
  //                       width: 1, color: Color.fromRGBO(196, 196, 196, 1)),
  //                   borderRadius: BorderRadius.all(Radius.circular(10)))),
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 20,
  //       )
  //     ],
  //   );
  // }
}


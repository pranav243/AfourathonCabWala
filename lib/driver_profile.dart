import 'package:cabwala/search_cabs.dart';
import 'package:cabwala/search_drivers.dart';
import 'package:cabwala/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DriverProfile extends StatefulWidget {
  static String id = "DriverProfile_screen";
  dynamic docId;
  dynamic driverId;
  dynamic name;
  dynamic contact;
  dynamic location;
  dynamic emailId;

  DriverProfile({super.key,required this.docId,required this.driverId,required this.name,required this.contact,required this.location,required this.emailId});
  
  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  final _firestore = FirebaseFirestore.instance;
  // DocumentReference documentRef = FirebaseFirestore.instance.collection('Cabs').doc(DriverProfile.docId);
  // DriverProfile cb =DriverProfile();
  String? ic1,ic2,ic3,ic4,ic5,ic6;

   Future<void> showRemoveAlert() async {
    showDialog(context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: const Text("Remove Driver ?"),
            content: const Text("This will delete the driver data."),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFE86666)), // Set the background color
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the text color
                 overlayColor: MaterialStateProperty.all<Color>(Colors.white),
                // Add more style properties as needed
                ),
                onPressed: (){
                _firestore.collection("Drivers").doc(ic1).delete();
                // Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchDrivers()));
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
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF09648C)), // Set the background color
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
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF09648C)), // Set the background color
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the text color
                 overlayColor: MaterialStateProperty.all<Color>(Colors.white),

                // Add more style properties as needed
                ),
                onPressed: (){
                // Navigator.pop(context);
                _firestore.collection("Drivers").doc(ic1).update({
                  'Contact': contact!=""?contact:ic4,
                  'Name': name!=""?name:ic3,
                  'RegNumber': driverId!=""?driverId:ic2,
                  'Location': location!=""?location:ic5,
                  'Type': emailId!=""?emailId:ic6,
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchDrivers()));
              }, child: const Text("Yes")),
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF09648C)), // Set the background color
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
    ic2=widget.driverId;
    ic3=widget.name;
    ic4=widget.contact;
    ic5=widget.location;
    ic6=widget.emailId;
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

  String driverId = '', name = '', contact = '', emailId = '',location='';
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
            // FixedBox("DriverID | $ic2","Driver ID", TextInputType.name),
            Text("DriverID : $ic2",
            style: TextStyle(color:Color(0xFF09648C) ),),
            const SizedBox(
              height: 16,
            ),
            InputBox("Name | $ic3","Name", TextInputType.name),
            InputBox("Email ID | $ic6","Email ID", TextInputType.emailAddress),
            InputBox("Contact | $ic4","Contact", TextInputType.phone),
            // InputBox("Location", TextInputType.name),
            InputBox("Hometown | $ic5","Location",TextInputType.name),
            // Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //   DetailTitle("Cab Type | $ic6"),
            //   SizedBox(
            //       height: 38,
            //       width: 307.91,
            //       child: DropdownButtonFormField(
            //         icon: const Icon(Icons.keyboard_arrow_down),
            //         items: const [
            //           DropdownMenuItem(
            //             value: 'Mini',
            //             child: Text("Mini"),
            //           ),
            //           DropdownMenuItem(
            //             value: 'Sedan',
            //             child: Text("Sedan"),
            //           ),
            //           DropdownMenuItem(
            //             value: 'SUV',
            //             child: Text("SUV"),
            //           )
            //         ],
            //         onChanged: (String? value) {
            //           type = value!;
            //         },
            //         style: const TextStyle(
            //             fontWeight: FontWeight.w400,
            //             color: Color(0xFF09648C)),
            //         decoration: const InputDecoration(
            //             contentPadding:
            //                 EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            //             border: OutlineInputBorder(
            //                 borderSide: BorderSide(
            //                     width: 1,
            //                     color: Color.fromRGBO(196, 196, 196, 1)),
            //                 borderRadius:
            //                     BorderRadius.all(Radius.circular(10)))),
            //       )),
            //   const SizedBox(
            //     height: 20,
            //   )
            // ]),
            InkWell(
              onTap: showEditAlert,
              // splashColor: Colors.amber,
              // onTap: () {
                // _firestore.collection("Cabs").doc(ic1).update({
                //   'Colour': colour!=""?colour:ic4,
                //   'Model': model!=""?model:ic3,
                //   'RegNumber': regno!=""?regno:ic2,
                //   'Location': location!=""?location:ic5,
                //   'Type': type!=""?type:ic6,
                // });
              // },
              child: Container(
                alignment: Alignment.center,
                width: 307.91,
                height: 46.79,
                decoration: BoxDecoration(
                    color: Color(0xFF09648C),
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
                    color: Color(0xFFE86666),
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
      bottomNavigationBar: BottomNavBar(0, 0, 0, context),
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
          controller : key=='Name'?_initialController1:(key=='Email ID'?_initialController2:(key=='Contact'?_initialController3:(key=='Location'?_initialController4:_initialController4))) ,
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

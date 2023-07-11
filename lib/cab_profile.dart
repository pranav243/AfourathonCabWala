// import 'package:cabwala/widgets.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CabProfile extends StatefulWidget {
//   // final String name;
//   static String id = "CabProfile_screen";
//   const CabProfile ({super.key});
//   // const CabProfile ({super.key,required this.name})
//     // String docId=this.name;
//   // }
//   // const CabProfile({super.key});
//   static void callbackFunction(String receivedString) {
//     // Process the received string in the receiving class
//     print('Received string: $receivedString');
//     final docId=receivedString;
//   }

//   @override
//   State<CabProfile> createState() => _CabProfileState{
//     final String docId;

//   _CabProfileState(this.docId);
// }

// class _CabProfileState extends State<CabProfile> {
//   final _firestore = FirebaseFirestore.instance;
//   DocumentReference documentRef = _firestore.collection('your_collection').doc(docId);
//   final TextEditingController _initialController1 = TextEditingController(text: 'docId');
//   final TextEditingController _initialController2 = TextEditingController(text: 'Initial Text2');
//   final TextEditingController _initialController3 = TextEditingController(text: 'Initial Text3');
//   final TextEditingController _initialController4 = TextEditingController(text: 'Initial Text4');
//   // final TextEditingController _initialController5 = TextEditingController(text: 'Initial Text');
  
  
//   @override
//   void dispose() {
//     _initialController1.dispose();
//     _initialController2.dispose();
//     _initialController3.dispose();
//     _initialController4.dispose();
//     super.dispose();
//   }

//   String regno = '', model = '', colour = '', type = '',location='';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: regularAppBar(context),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 SvgPicture.asset("images/ellipse2.svg"),
//                 SvgPicture.asset("images/cabbig.svg")
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             InputBox("Registration Number", TextInputType.name),
//             InputBox("Model", TextInputType.name),
//             InputBox("Colour", TextInputType.name),
//             // InputBox("Location", TextInputType.name),
//             FixedBox("Location"),
//             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               InputTitle("Cab Type"),
//               SizedBox(
//                   height: 46.79,
//                   width: 307.91,
//                   child: DropdownButtonFormField(
//                     icon: const Icon(Icons.keyboard_arrow_down),
//                     items: const [
//                       DropdownMenuItem(
//                         value: 'Mini',
//                         child: Text("Mini"),
//                       ),
//                       DropdownMenuItem(
//                         value: 'Sedan',
//                         child: Text("Sedan"),
//                       ),
//                       DropdownMenuItem(
//                         value: 'SUV',
//                         child: Text("SUV"),
//                       )
//                     ],
//                     onChanged: (String? value) {
//                       type = value!;
//                     },
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w400,
//                         color: Color.fromRGBO(51, 52, 52, 1)),
//                     decoration: const InputDecoration(
//                         contentPadding:
//                             EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 1,
//                                 color: Color.fromRGBO(196, 196, 196, 1)),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10)))),
//                   )),
//               const SizedBox(
//                 height: 20,
//               )
//             ]),
//             InkWell(
//               onTap: () {
//                 _firestore.collection("Cabs").add({
//                   'Colour': colour,
//                   'Model': model,
//                   'RegNumber': regno,
//                   'Location': location,
//                   'Type': type
//                 });
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 width: 307.91,
//                 height: 46.79,
//                 decoration: BoxDecoration(
//                     color: const Color.fromRGBO(9, 100, 140, 1),
//                     borderRadius: BorderRadius.circular(20)),
//                 child: const Text(
//                   "Add Cab",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       extendBody: true,
//       bottomNavigationBar: BottomNavBar(0, 0, context),
//     );
//   }

//   Column InputBox(title, keyboardType) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         InputTitle(title),
//         SizedBox(
//           height: 46.79,
//           width: 307.91,
//           child: TextField(
//           controller : title=='Registration Number'?_initialController1:(title=='Model'?_initialController2:(title=='Colour'?_initialController3:(title=='Location'?_initialController4:_initialController4))) ,
//             onChanged: (value) {
//               if (title == 'Registration Number') {
//                 regno = value;
//               } else if (title == "Model") {
//                 model = value;
//               } else if (title == 'Colour') {
//                 colour = value;
//               } else if (title == 'Cab Type') {
//                 type = value;
//               } else if (title == 'Location') {
//                 location = value;
//               }
//             },
//             autocorrect: false,
//             textAlignVertical: TextAlignVertical.center,
//             keyboardType: keyboardType,
//             style: const TextStyle(
//                 fontWeight: FontWeight.w400,
//                 color: Color.fromRGBO(51, 52, 52, 1)),
//             decoration: const InputDecoration(
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         width: 1, color: Color.fromRGBO(196, 196, 196, 1)),
//                     borderRadius: BorderRadius.all(Radius.circular(10)))),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         )
//       ],
//     );
//   }

//   Column FixedBox(title) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         InputTitle(title),
//         SizedBox(
//           height: 46.79,
//           width: 307.91,
//           child: TextFormField(
//             enabled:false,
//             onChanged: (value) {
//               if (title == 'Registration Number') {
//                 regno = value;
//               } else if (title == "Model") {
//                 model = value;
//               } else if (title == 'Colour') {
//                 colour = value;
//               } else if (title == 'Cab Type') {
//                 type = value;
//               } else if (title == 'Location') {
//                 location = value;
//               }
//             },
//             autocorrect: false,
//             textAlignVertical: TextAlignVertical.center,
//             // keyboardType: keyboardType,
//             style: const TextStyle(
//                 fontWeight: FontWeight.w400,
//                 color: Color.fromRGBO(51, 52, 52, 1)),
//             decoration: const InputDecoration(
//                 hintText: "Kanpur",
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         width: 1, color: Color.fromRGBO(196, 196, 196, 1)),
//                     borderRadius: BorderRadius.all(Radius.circular(10)))),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         )
//       ],
//     );
//   }
// }

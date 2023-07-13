import 'package:cabwala/add_driver.dart';
import 'package:cabwala/list_drivers.dart';
import 'package:cabwala/search_drivers.dart';
import 'package:cabwala/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cabwala/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DriverManager extends StatefulWidget {
  static String id = 'drivermanager_screen';

  const DriverManager({super.key});

  @override
  State<DriverManager> createState() => _DriverManagerState();
}

class _DriverManagerState extends State<DriverManager> {
//   Future<String> getTotalDocuments() async {
//   // Replace "yourCollection" with the actual name of your collection
//   CollectionReference collectionRef =
//       FirebaseFirestore.instance.collection('Drivers');

//   QuerySnapshot querySnapshot = await collectionRef.get();
//   int totalDocuments = querySnapshot.size;

//   return "d$totalDocuments";
// }
// String driver='';
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     driver=getTotalDocuments();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: regularAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () {
                // await getTotalDocuments();
                // CollectionReference collectionRef =FirebaseFirestore.instance.collection('Drivers');
                // CollectionReference collectionRef2 =FirebaseFirestore.instance.collection('Deleted Drivers');

                // int? totalDocumentsCount ;
                // int? totalDocumentsCount2 ;

                // collectionRef.snapshots().listen((QuerySnapshot querySnapshot) {
                //   totalDocumentsCount = querySnapshot.docs.length;
                // });
                // collectionRef2.snapshots().listen((QuerySnapshot querySnapshot2) {
                //   totalDocumentsCount2 = querySnapshot2.docs.length;
                // });

                // String drivers="d000$totalDocumentsCount";
                // Navigator.pushNamed(context, AddDriver.id);
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddDriver(),));
                
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.only(left: 20),
                // height: ScreenUtil().setHeight(74),
                // width: ScreenUtil().setWidth(312),
                height: (74),
                width: (312),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(39, 149, 208, 0.27),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      SvgPicture.asset("images/ellipse.svg"),
                      SvgPicture.asset("images/plus.svg")
                    ]),
                    const SizedBox(
                      width: 15,
                    ),
                    TitleWidget("Add Driver", "Register a new driver"),
                    const SizedBox(
                      width: 80,
                    ),
                    SvgPicture.asset("images/rightarrow.svg")
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchDrivers()));
                  },
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(left: 20),
                // height: ScreenUtil().setHeight(74),
                // width: ScreenUtil().setWidth(312),
                height: (74),
                width: (312),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(39, 149, 208, 0.27),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      SvgPicture.asset("images/ellipse.svg"),
                      SvgPicture.asset("images/list.svg")
                    ]),
                    const SizedBox(
                      width: 15,
                    ),
                    TitleWidget("Driver Details", "Search/Edit/Remove Drivers"),
                    const SizedBox(
                      width: 50,
                    ),
                    SvgPicture.asset("images/rightarrow.svg")
                  ],
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(top: 12),
            //   child: SearchBarWidget(),
            // ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavBar(0, 0, 0, context),
    );
  }
}

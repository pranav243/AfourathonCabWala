import 'package:cabwala/link_home.dart';
import 'package:cabwala/manage_drivers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'manage_cabs.dart';
import 'widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinkCab extends StatefulWidget {
  static String id = 'LinkCab_screen';

  LinkCab({super.key, this.cab});

  dynamic cab;

  @override
  State<LinkCab> createState() => _LinkCabState();
}

class _LinkCabState extends State<LinkCab> {
  dynamic name;
  dynamic contact;
  dynamic emailid;
  dynamic hometown;
  dynamic driverid;
  dynamic docId;
  List _allResults = [];
  List _resultList = [];
  // List _allResults2 = [];
  // List _resultList2 = [];
  final TextEditingController _searchController = TextEditingController();

  getCollectionStream() async {
    var data = await FirebaseFirestore.instance
        .collection('Drivers')
        .orderBy('Driver ID')
        .get();
    print(data);

    for (var snapShot in data.docs) {
      // print(widget.driver['Linked To']);
      if (snapShot['Driver ID'].toString().toLowerCase() ==
          widget.cab['Driver Linked'].toString().toLowerCase())
      // if(snapShot['City'].toString().toLowerCase()=='mumbai')
      {
        name = snapShot['Name'];
        emailid = snapShot["Email ID"];
        contact = snapShot['Contact'];
        hometown = snapShot['Hometown'];
        driverid = snapShot['Driver ID'];
        docId = snapShot.reference.id.toString();
        break;
      }
    }
  }

  @override
  void initState() {
    // getCollectionStream();
    getCollectionStream(); // Call your async function here
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    print(_searchController.text);
    // if (page == 0) {
    //   searchResultListDrivers();
    // } else {
    searchResultListDrivers();
    // }
  }

  searchResultListDrivers() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var snapShot in _allResults) {
        var docId = snapShot.reference.id.toString();
        var contact = snapShot['Contact'].toLowerCase();
        var driverid = snapShot['Driver ID'].toString().toLowerCase();
        var name = snapShot['Name'].toString().toLowerCase();
        var emailid = snapShot['Email ID'].toString().toLowerCase();
        var hometown = snapShot['Hometown'].toString().toLowerCase();
        if (driverid.contains(_searchController.text.toLowerCase()) ||
            contact.contains(_searchController.text.toLowerCase()) ||
            name.contains(_searchController.text.toLowerCase()) ||
            emailid.contains(_searchController.text.toLowerCase()) ||
            hometown.contains(_searchController.text.toLowerCase())) {
          showResults.add(snapShot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  // getCollectionStream() async {
  //   var data = await FirebaseFirestore.instance
  //       .collection('Drivers')
  //       .orderBy('Driver ID')
  //       .get();

  //   setState(() {
  //     _allResults = data.docs;
  //   });
  //   searchResultListDrivers();
  // }

  getCollectionStream2() async {
    var data = await FirebaseFirestore.instance
        .collection('Drivers')
        .orderBy('Driver ID')
        .get();

    setState(() {
      // _allResults2 = data.docs;
      for (var snapShot in data.docs) {
        if (snapShot['Hometown'] == widget.cab['Location'] &&
            snapShot['Linked'] == false) {
          _allResults.add(snapShot);
        }
      }
    });
    searchResultListDrivers();
  }

  final _firestore = FirebaseFirestore.instance;
  String type = '';
  String model = '';
  String regnum = '';
  String location = '';

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // getCollectionStream();
    getCollectionStream2();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cab['Linked']) {
      return Scaffold(
        appBar: regularAppBar(context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: 312,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1, color: Color.fromRGBO(9, 100, 140, 1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cab['Model'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(9, 100, 140, 1),
                              fontSize: 16,
                              letterSpacing: 0.5),
                        ),
                        Text(
                          widget.cab['Location'],
                          style: const TextStyle(
                            color: Color(0xFF333434),
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            // height: 18,
                            letterSpacing: 0.50,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 16,
                          width: 80,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(235, 248, 255, 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            widget.cab['Type'],
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(9, 100, 140, 1),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          widget.cab['RegNumber'],
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: 312,
                height: 50,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(39, 149, 208, 0.27),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // _resultList2[index]['Model'],
                          name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(9, 100, 140, 1),
                              fontSize: 16,
                              letterSpacing: 0.5),
                        ),
                        Text(
                          // _resultList2[index]['Location'],
                          hometown,
                          style: const TextStyle(
                            color: Color(0xFF333434),
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            // height: 18,
                            letterSpacing: 0.50,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 16,
                          width: 80,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(235, 248, 255, 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            // _resultList2[index]['Type'],
                            driverid,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(9, 100, 140, 1),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          // _resultList2[index]['RegNumber'],
                          contact,
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection('Drivers')
                      .doc(docId)
                      .update({'Linked': false, 'Cab Linked': ""});
                  await FirebaseFirestore.instance
                      .collection('Cabs')
                      .doc(widget.cab.reference.id.toString())
                      .update({'Linked': false, 'Driver Linked': ""});
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Driver has been unlinked from the cab.",
                          style: TextStyle(
                              color: Color(0xFF09648C),
                              fontWeight: FontWeight.w500)),
                      backgroundColor: Color(0xFFEAF7FF),
                      elevation: 10));
                  Navigator.pushNamed(context, LinkHome.id);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(307.91),
                  height: ScreenUtil().setHeight(46.79),
                  child: Text(
                    "Remove Link",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(16),
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(217, 0, 0, 0.6)),
                ),
              )
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: BottomNavBar(0, 1, 0, context),
        // )
      );
    } else {
      return Scaffold(
        appBar: regularAppBar(context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: 312,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1, color: Color.fromRGBO(9, 100, 140, 1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cab['Model'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(9, 100, 140, 1),
                              fontSize: 16,
                              letterSpacing: 0.5),
                        ),
                        Text(
                          widget.cab['Location'],
                          style: const TextStyle(
                            color: Color(0xFF333434),
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            // height: 18,
                            letterSpacing: 0.50,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 16,
                          width: 80,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(235, 248, 255, 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            widget.cab['Type'],
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(9, 100, 140, 1),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          widget.cab['RegNumber'],
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(30),
                    bottom: ScreenUtil().setHeight(5)),
                width: 335,
                height: 34,
                alignment: Alignment.center,
                child: CupertinoSearchTextField(
                  prefixInsets: EdgeInsets.fromLTRB(20, 5, 5, 5),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.black54,
                  ),
                  // padding: EdgeInsets.only(top: 10, bottom: 5),
                  controller: _searchController,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(235, 248, 255, 1),
                  ),
                  placeholder: "Pick a driver for this cab",
                  placeholderStyle: const TextStyle(
                      letterSpacing: 0.5,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(96, 96, 96, 0.75)),
                  style: const TextStyle(),
                ),
              ),
              Expanded(
                // Wrap ListView.builder with Expanded
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  itemCount: _resultList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                      ),
                      child: InkWell(
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection('Drivers')
                              .doc(_resultList[index].reference.id.toString())
                              .update({
                            'Linked': true,
                            'Cab Linked': widget.cab['RegNumber']
                          });
                          await FirebaseFirestore.instance
                              .collection('Cabs')
                              .doc(widget.cab.reference.id.toString())
                              .update({
                            'Linked': true,
                            'Driver Linked': _resultList[index]['Driver ID']
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Chosen driver has been linked to the cab.",
                                      style: TextStyle(
                                          color: Color(0xFF09648C),
                                          fontWeight: FontWeight.w500)),
                                  backgroundColor: Color(0xFFEAF7FF),
                                  elevation: 10));
                          Navigator.pushNamed(context, LinkHome.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: 312,
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(39, 149, 208, 0.27),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _resultList[index]['Name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(9, 100, 140, 1),
                                        fontSize: 16,
                                        letterSpacing: 0.5),
                                  ),
                                  Text(
                                    _resultList[index]['Hometown'],
                                    style: const TextStyle(
                                      color: Color(0xFF333434),
                                      fontSize: 11,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      // height: 18,
                                      letterSpacing: 0.50,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 16,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            235, 248, 255, 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      _resultList[index]['Driver ID'],
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(9, 100, 140, 1),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    _resultList[index]['Contact'],
                                    style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.5),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: BottomNavBar(0, 1, 0, context),
        // )
      );
    }
  }
}

// plugins {
//   id 'com.google.gms.google-services' version '4.3.15' apply false
// }

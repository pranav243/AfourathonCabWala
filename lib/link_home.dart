import 'package:cabwala/link_cab.dart';
import 'package:cabwala/link_driver.dart';
import 'package:cabwala/manage_drivers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login.dart';
import 'manage_cabs.dart';
import 'widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinkHome extends StatefulWidget {
  static String id = 'LinkHome_screen';

  const LinkHome({super.key});

  @override
  State<LinkHome> createState() => _LinkHomeState();
}

class _LinkHomeState extends State<LinkHome> {
  int page = 0;
  List? _allResults = [];
  List? _resultList = [];
  List? _allResults2 = [];
  List? _resultList2 = [];
  final TextEditingController _searchController = TextEditingController();

  Future<void> showLogoutAlert() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: const Text(""),
            content: const Text("Do you want to logout?"),
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
                  onPressed: logoutUser,
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

  void logoutUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    print('User logged out');

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));

    User? user = auth.currentUser;

    if (user != null) {
      // User is logged in
      String uid = user.uid;
      String email = user.email!;
      // Access other user properties as needed
      print('User is logged in. UID: $uid, Email: $email');
    } else {
      // No user is currently logged in
      print('No user is currently logged in');
    }
  }

  @override
  void initState() {
    // getCollectionStream();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    print(_searchController.text);
    if (page == 0) {
      searchResultListDrivers();
    } else {
      searchResultListCabs();
    }
  }

  searchResultListDrivers() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var snapShot in _allResults!) {
        var contact = snapShot['Contact'].toString();
        var name = snapShot['Name'].toString().toLowerCase();
        var driverid = snapShot['Driver ID'].toString().toLowerCase();
        var location = snapShot['Hometown'].toString().toLowerCase();
        if (contact.contains(_searchController.text.toLowerCase()) ||
            name.contains(_searchController.text.toLowerCase()) ||
            driverid.contains(_searchController.text.toLowerCase()) ||
            location.contains(_searchController.text.toLowerCase())) {
          showResults.add(snapShot);
        }
      }
    } else {
      showResults = List.from(_allResults!);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  searchResultListCabs() {
    var showResults2 = [];
    if (_searchController.text != "") {
      for (var snapShot in _allResults2!) {
        var colour = snapShot['Colour'].toLowerCase();
        var regnum = snapShot['RegNumber'].toString().toLowerCase();
        var type = snapShot['Type'].toString().toLowerCase();
        var model = snapShot['Model'].toString().toLowerCase();
        var location = snapShot['Location'].toString().toLowerCase();
        if (colour.contains(_searchController.text.toLowerCase()) ||
            regnum.contains(_searchController.text.toLowerCase()) ||
            type.contains(_searchController.text.toLowerCase()) ||
            model.contains(_searchController.text.toLowerCase()) ||
            location.contains(_searchController.text.toLowerCase())) {
          showResults2.add(snapShot);
        }
      }
    } else {
      showResults2 = List.from(_allResults2!);
    }
    setState(() {
      _resultList2 = showResults2;
    });
  }

  getCollectionStream() async {
    var data = await FirebaseFirestore.instance
        .collection('Drivers')
        .orderBy('Driver ID')
        .get();

    setState(() {
      _allResults = data.docs;
    });
    searchResultListDrivers();
  }

  getCollectionStream2() async {
    var data = await FirebaseFirestore.instance
        .collection('Cabs')
        .orderBy('RegNumber')
        .get();

    setState(() {
      _allResults2 = data.docs;
    });
    searchResultListCabs();
  }

  final _firestore = FirebaseFirestore.instance;
  String email = '';
  String name = '';
  String contact = '';
  String home = '';

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getCollectionStream();
    getCollectionStream2();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (page == 0) {
      return Scaffold(
        // appBar: regularAppBar(context),
        appBar: AppBar(
          centerTitle: false,
          toolbarHeight: ScreenUtil().setHeight(60),
          // toolbarHeight: (60),
          elevation: 0,
          backgroundColor: Colors.white,
          leadingWidth: 0,
          title: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: ScreenUtil().setHeight(36),
              width: ScreenUtil().setWidth(120),
              // height: (36),
              // width: (120),
              child: Row(
                children: [
                  Text('Cab',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(27))),
                  Text('Wala',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(9, 100, 140, 1),
                          fontSize: ScreenUtil().setSp(27)))
                ],
              )),
          // fontSize: (30)))),

          actions: [
            GestureDetector(
              onTap: showLogoutAlert,
              child: Padding(
                padding:
                    // EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                    const EdgeInsets.symmetric(horizontal: (20)),
                child: SvgPicture.asset("images/logout.svg"),
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(132),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2,
                                color: Color.fromRGBO(9, 100, 140, 1)))),
                    child: const Text(
                      "Drivers",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(9, 100, 140, 1),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(20),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        page = 1;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: ScreenUtil().setWidth(132),
                      child: const Text(
                        "Cabs",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(9, 100, 140, 1),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(30),
                    bottom: ScreenUtil().setHeight(5)),
                width: 335,
                height: 34,
                alignment: Alignment.center,
                child: CupertinoSearchTextField(
                  prefixInsets: const EdgeInsets.fromLTRB(20, 5, 5, 5),
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
                  placeholder: "Search for Drivers",
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
                  itemCount: _resultList!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LinkDriver(
                                        driver: _resultList?[index],
                                      )));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: 312,
                          height: 50,
                          decoration: BoxDecoration(
                              color: _resultList![index]['Linked']
                                  ? const Color.fromRGBO(36, 204, 42, 0.27)
                                  : const Color.fromRGBO(39, 149, 208, 0.27),
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
                                    _resultList![index]['Name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(9, 100, 140, 1),
                                        fontSize: 16,
                                        letterSpacing: 0.5),
                                  ),
                                  Text(
                                    _resultList![index]['Hometown'],
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
                                      _resultList![index]['Driver ID'],
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(9, 100, 140, 1),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    _resultList![index]['Contact'],
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
        // extendBody: true,
        bottomNavigationBar: BottomNavBar(0, 1, 0, context),
        // )
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          toolbarHeight: ScreenUtil().setHeight(60),
          // toolbarHeight: (60),
          elevation: 0,
          backgroundColor: Colors.white,
          leadingWidth: 0,
          title: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: ScreenUtil().setHeight(36),
              width: ScreenUtil().setWidth(120),
              // height: (36),
              // width: (120),
              child: Row(
                children: [
                  Text('Cab',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(27))),
                  Text('Wala',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(9, 100, 140, 1),
                          fontSize: ScreenUtil().setSp(27)))
                ],
              )),
          // fontSize: (30)))),

          actions: [
            Padding(
              padding:
                  // EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                  const EdgeInsets.symmetric(horizontal: (20)),
              child: SvgPicture.asset("images/logout.svg"),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        page = 0;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: ScreenUtil().setWidth(132),
                      child: const Text(
                        "Drivers",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(9, 100, 140, 1),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(20),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2,
                                color: Color.fromRGBO(9, 100, 140, 1)))),
                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(132),
                    child: const Text(
                      "Cabs",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(9, 100, 140, 1),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(30),
                    bottom: ScreenUtil().setHeight(5)),
                width: 335,
                height: 34,
                alignment: Alignment.center,
                child: CupertinoSearchTextField(
                  prefixInsets: const EdgeInsets.fromLTRB(20, 5, 5, 5),
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
                  placeholder: "Search for Cabs",
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
                  itemCount: _resultList2!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LinkCab(
                                        cab: _resultList2?[index],
                                      )));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: 312,
                          height: 50,
                          decoration: BoxDecoration(
                              color: _resultList2![index]['Linked']
                                  ? const Color.fromRGBO(36, 204, 42, 0.27)
                                  : const Color.fromRGBO(39, 149, 208, 0.27),
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
                                    _resultList2![index]['Model'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(9, 100, 140, 1),
                                        fontSize: 16,
                                        letterSpacing: 0.5),
                                  ),
                                  Text(
                                    _resultList2![index]['Location'],
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
                                      _resultList2![index]['Type'],
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(9, 100, 140, 1),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    _resultList2![index]['RegNumber'],
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
        // extendBody: true,
        bottomNavigationBar: BottomNavBar(0, 1, 0, context),
        // )
      );
    }
  }
}

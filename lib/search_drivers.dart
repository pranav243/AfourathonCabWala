import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cabwala/widgets.dart';

import 'driver_profile.dart';

class SearchDrivers extends StatefulWidget {
  static String id = "Search_screen";
  const SearchDrivers({super.key});

  @override
  State<SearchDrivers> createState() => _SearchDriversState();
}

class _SearchDriversState extends State<SearchDrivers> {
  List _allResults = [];
  List _resultList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // getCollectionStream();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    print(_searchController.text);
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var snapShot in _allResults) {
        var driverId = snapShot['Driver ID'].toString().toLowerCase();
        var name = snapShot['Name'].toString().toLowerCase();
        var contact = snapShot['Contact'].toString().toLowerCase();
        var location = snapShot['Hometown'].toString().toLowerCase();
        // var location = snapShot['Location'].toString().toLowerCase();
        if (driverId.contains(_searchController.text.toLowerCase()) ||
            name.contains(_searchController.text.toLowerCase()) ||
            contact.contains(_searchController.text.toLowerCase()) ||
            location.contains(_searchController.text.toLowerCase())) {
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

  getCollectionStream() async {
    var data = await FirebaseFirestore.instance
        .collection('Drivers')
        .orderBy('Driver ID')
        .get();

    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
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
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: regularAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
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
                    fontWeight: FontWeight.w300,
                    color: Color.fromRGBO(96, 96, 96, 0.75)),
                style: const TextStyle(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Choose driver to edit details',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF09648C),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                // height: 2,
                letterSpacing: 0.50,
              ),
            ),
            Expanded(
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
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DriverProfile(
                              docId: _resultList[index].id,
                              driverId: _resultList[index]['Driver ID'],
                              contact: _resultList[index]['Contact'],
                              emailId: _resultList[index]['Email ID'],
                              location: _resultList[index]['Hometown'],
                              name: _resultList[index]['Name'],
                            ),
                          ),
                        );
                        print("Container tapped!");
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _resultList[index]['Name'],
                                  style: const TextStyle(
                                    color: Color(0xFF09648C),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    // height: 25.20,
                                    letterSpacing: 0.50,
                                  ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 16,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          235, 248, 255, 1),
                                      borderRadius: BorderRadius.circular(10)),
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
                    // ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(0, 0, 0, context),
    );
  }
}

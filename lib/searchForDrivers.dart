import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cabwala/widgets.dart';

class SearchForDrivers extends StatefulWidget {
  static String id = "SearchForDrivers_screen";
  const SearchForDrivers({super.key});

  @override
  State<SearchForDrivers> createState() => _SearchForDriversState();
}

class _SearchForDriversState extends State<SearchForDrivers> {
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
                    fontSize: 11,
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
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(9, 100, 140, 1),
                                    fontSize: 14,
                                    letterSpacing: 0.5),
                              ),
                              Text(
                                _resultList[index]['Hometown'],
                                style: const TextStyle(
                                    fontSize: 10, letterSpacing: 0.5),
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
                                width: 48,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(235, 248, 255, 1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  _resultList[index]['Driver ID'],
                                  style: const TextStyle(
                                      fontSize: 9,
                                      color: Color.fromRGBO(9, 100, 140, 1),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                _resultList[index]['Contact'],
                                style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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

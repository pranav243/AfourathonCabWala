import 'package:cabwala/cab_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cabwala/widgets.dart';

class SearchCabs extends StatefulWidget {
  static String id = "Search_screen";
  const SearchCabs({super.key});

  @override
  State<SearchCabs> createState() => _SearchCabsState();
}

class _SearchCabsState extends State<SearchCabs> {

  // void _sendDocIdToCabProfile(dynamic myString) {
  //   // Call the callback function in the other class and pass the string
  //   CabProfile.callbackFunction(myString);
  //   Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => CabProfile(),));
  // }
  
  List _allResults=[];
  List _resultList=[];
  final TextEditingController _searchController= TextEditingController();

  @override
  void initState(){
    // getCollectionStream();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged(){
    print(_searchController.text);
    searchResultList();
  }

  searchResultList(){
    var showResults = [];
    if(_searchController.text !="")
    {
      for(var snapShot in _allResults)
      {
        var regnum = snapShot['RegNumber'].toString().toLowerCase();
        var model = snapShot['Model'].toString().toLowerCase();
        var type = snapShot['Type'].toString().toLowerCase();
        var location = snapShot['Location'].toString().toLowerCase();
        if(regnum.contains(_searchController.text.toLowerCase()) || model.contains(_searchController.text.toLowerCase()) || type.contains(_searchController.text.toLowerCase()) || location.contains(_searchController.text.toLowerCase()))
        {
          showResults.add(snapShot);
        }
      }
    }
    else{
      showResults=List.from(_allResults);
    }
    setState(() {
      _resultList=showResults;
    });
  }
  getCollectionStream() async {
    var data = await FirebaseFirestore.instance.collection('Cabs').orderBy('RegNumber').get();

    setState((){
      _allResults=data.docs;
    });
    searchResultList();
  }
  final _firestore = FirebaseFirestore.instance;
  String email = '';
  String name = '';
  String contact = '';
  String home = '';

  @override
  void dispose(){
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies(){
    getCollectionStream();
    super.didChangeDependencies();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: regularAppBar(context),
    // body: Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       CupertinoSearchTextField(
    //         controller: _searchController,
    //       ),
          // SizedBox(
          //   height: 16,
          // ),
          // Text(
          //   'Choose cab to edit details',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     color: Color(0xFF09648C),
          //     fontSize: 14,
          //     fontFamily: 'Poppins',
          //     fontWeight: FontWeight.w600,
          //     // height: 2,
          //     letterSpacing: 0.50,
          //   ),
          // ),
    body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
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
            SizedBox(
            height: 16,
          ),
          Text(
            'Choose cab to edit details',
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
          Expanded( // Wrap ListView.builder with Expanded
            // child: ListView.builder(
            //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            //   itemCount: _resultList.length,
            //   itemBuilder: (context, index) {
            //     return Padding(
            //       padding: const EdgeInsets.only(bottom: 8.0),
            //       child :ListTile(
            //       title: Text(_resultList[index].id),
            //       subtitle: Text(_resultList[index]['RegNumber']),
            //       trailing: Text(_resultList[index]['Location']),
            //       leading: Text(_resultList[index]['Type']),
            //       // isThreeLine: true,
            //       tileColor: const Color.fromRGBO(39, 149, 208, 0.27),
            //       // onTap: (){_sendDocIdToCabProfile(_resultList[index].id);},
            //       onTap:(){ Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => CabProfile(docId:_resultList[index].id,regnumber:_resultList[index]['RegNumber'],model:_resultList[index]['Model'],colour:_resultList[index]['Colour'],location: _resultList[index]['Location'],type:_resultList[index]['Type'])));}
                  

            //       )
            //     );
            //   },
            // ),
            child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                itemCount: _resultList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                    ),
                    // child: ListTile(
                    //   title: Text(_resultList[index]['Model']),
                    //   subtitle: Text(_resultList[index]['RegNumber']),
                    //   trailing: Text(_resultList[index]['Location']),
                    //   leading: Text(_resultList[index]['Type']),
                    //   // isThreeLine: true,
                    //   tileColor: const Color.fromRGBO(39, 149, 208, 0.27),
                    //   // onTap: (){_sendDocIdToCabProfile(_resultList[index]);}
                    // )
                    child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CabProfile(
                            docId: _resultList[index].id,
                            regnumber: _resultList[index]['RegNumber'],
                            model: _resultList[index]['Model'],
                            colour: _resultList[index]['Colour'],
                            location: _resultList[index]['Location'],
                            type: _resultList[index]['Type'],
                          ),
                        ),
                      );
                      print("Container tapped!");
                    },
                    child:InkWell(
                      onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CabProfile(
                          docId: _resultList[index].id,
                          regnumber: _resultList[index]['RegNumber'],
                          model: _resultList[index]['Model'],
                          colour: _resultList[index]['Colour'],
                          location: _resultList[index]['Location'],
                          type: _resultList[index]['Type'],
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
                                _resultList[index]['Model'],
                                style: const TextStyle(
                                    color: Color(0xFF09648C),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    // height: 25.20,
                                    letterSpacing: 0.50,),
                              ),
                              Text(
                                _resultList[index]['Location'],
                                style: const TextStyle(
                                    color: Color(0xFF333434),
                                    fontSize: 11,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    // height: 18,
                                    letterSpacing: 0.50,),
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
                                  _resultList[index]['Type'],
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(9, 100, 140, 1),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                _resultList[index]['RegNumber'],
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
                    ),
                    
                  );
                },
              ),
          ),
        ],
      ),
    ),
  );
}
}
    // return SizedBox(
    //   width: 312,
    //   child: TextField(
    //     // controller: _searchController,
    //     style: const TextStyle(color: Color(0xFF09648C)),
    //     decoration: InputDecoration(
    //       filled: true,
    //       fillColor: const Color(0xFFEAF7FF),
    //       // hintText: 'Search for ${widget.searchfor}',
    //       hintStyle: const TextStyle(
    //         color: Color(0xBF606060),
    //         fontSize: 14,
    //         fontFamily: 'Poppins',
    //         fontWeight: FontWeight.w400,
    //       ),
    //       prefixIcon: const Icon(Icons.search, color: Color(0xFF09648C)),
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(25),
    //         borderSide: BorderSide.none,
    //       ),
    //       contentPadding: const EdgeInsets.symmetric(vertical: 12),
    //       suffixIcon: IconButton(
    //         icon: const Icon(Icons.clear, color: Color(0xFF09648C)),
    //         onPressed: () {
    //           setState(() {
    //             // _searchController.clear();
    //           });
    //         },
    //       ),
    //     ),
    //     onChanged: (value) {
    //       // Perform search operation with the entered value
    //       print('Search query: $value');
    //     },
    //   ),
    // );
// }

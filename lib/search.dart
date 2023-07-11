import 'package:cabwala/cab_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cabwala/widgets.dart';

class Search extends StatefulWidget {
  static String id = "Search_screen";
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  // void _sendDocIdToCabProfile(String myString) {
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
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CupertinoSearchTextField(
            controller: _searchController,
          ),
          Expanded( // Wrap ListView.builder with Expanded
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: _resultList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child :ListTile(
                  title: Text(_resultList[index]['Model']),
                  subtitle: Text(_resultList[index]['RegNumber']),
                  trailing: Text(_resultList[index]['Location']),
                  leading: Text(_resultList[index]['Type']),
                  // isThreeLine: true,
                  tileColor: const Color.fromRGBO(39, 149, 208, 0.27),
                  // onTap: (){_sendDocIdToCabProfile(_resultList[index]);}
                  

                  )
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
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
}

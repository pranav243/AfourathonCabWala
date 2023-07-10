import 'package:cabwala/searchbar.dart';
import 'package:cabwala/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListCabs extends StatefulWidget {
  static String id = 'listcabs_screen';
  const ListCabs({super.key});

  @override
  State<ListCabs> createState() => _ListCabsState();
}

class _ListCabsState extends State<ListCabs> {
  final _firestore = FirebaseFirestore.instance;
  List<Widget> cabsWidget = [];

  void initState() {
    getMessagesStream();
  }

  void getMessagesStream() async {
    await for (var snapshot in _firestore.collection("Cabs").snapshots()) {
      for (var cab in snapshot.docs) {
        // print(msg.data());
        // cabsFirebase.add(cab.data());
        Widget widget = Container(
          margin: const EdgeInsets.only(top: 15),
          padding: EdgeInsets.only(left: 20),
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
              // Stack(alignment: Alignment.center, children: [
              //   SvgPicture.asset("images/ellipse.svg"),
              //   SvgPicture.asset("images/driver.svg")
              // ]),
              const SizedBox(
                width: 20,
              ),
              TitleWidget(cab.data()['RegNumber'], cab.data()['Model']),
              const SizedBox(
                width: 50,
              ),
              // SvgPicture.asset("images/rightarrow.svg")
            ],
          ),
        );

        cabsWidget.add(widget);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: regularAppBar(context),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SearchBarWidget(searchfor: 'Cabs'),
            // StreamBuilder<QuerySnapshot>(
            //   stream: _firestore.collection("Cabs").snapshots(),
            //   builder: (context, snapshot) {
            //     cabsWidget.clear();
            //     if (snapshot.hasData) {
            //       final cabs = snapshot.data!.docs;
            //       for (var cab in cabs) {
            //         final regno = cab['RegNumber'];
            //         // final msgsender = msg['sender'];
            //         // final msgwidget = Padding(
            //           padding: EdgeInsets.all(10),
            //           child: Column(
            //             children: [
            //               // Text(
            //               //   '$msgsender',
            //               //   style:
            //               //       TextStyle(fontSize: 12, color: Colors.black54),
            //               // ),
            //               Material(
            //                 elevation: 5,
            //                 borderRadius: BorderRadius.circular(30),
            //                 color: Colors.lightBlueAccent,
            //                 child: Padding(
            //                   padding: const EdgeInsets.symmetric(
            //                       vertical: 10, horizontal: 20),
            //                   child: Text(
            //                     '$regno',
            //                     style: TextStyle(fontSize: 15),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         );
            //         cabsWidget.add(msgwidget);
            //       }

            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: cabsWidget,
              ),
            )
          ],
        ),
      ),
      // extendBody: true,
      bottomNavigationBar: BottomNavBar(0, 0, context),
    );
  }
}

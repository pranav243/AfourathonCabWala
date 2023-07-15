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

  @override
  void initState() {
    getMessagesStream();
  }

  void getMessagesStream() async {
    await for (var snapshot in _firestore.collection("Cabs").snapshots()) {
      for (var cab in snapshot.docs) {
        Widget widget = Container(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.only(left: 20),
          height: (74),
          width: (312),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(39, 149, 208, 0.27),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: cabsWidget,
              ),
            )
          ],
        ),
      ),
      // extendBody: true,
      bottomNavigationBar: BottomNavBar(0, 0, 0, context),
    );
  }
}

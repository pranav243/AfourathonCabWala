import 'package:cabwala/searchbar.dart';
import 'package:cabwala/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListDrivers extends StatefulWidget {
  static String id = 'listdrivers_screen';
  const ListDrivers({super.key});

  @override
  State<ListDrivers> createState() => _ListDriversState();
}

class _ListDriversState extends State<ListDrivers> {
  final _firestore = FirebaseFirestore.instance;
  List<Widget> cabsWidget = [];

  @override
  void initState() {
    getMessagesStream();
  }

  void getMessagesStream() async {
    await for (var snapshot in _firestore.collection("Drivers").snapshots()) {
      for (var driver in snapshot.docs) {
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
              TitleWidget(driver.data()['Name'], driver.data()['Contact']),
              const SizedBox(
                width: 50,
              ),
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
            Container(
              // margin: EdgeInsets.only(top: 12),
              child: SearchBarWidget(searchfor: 'Drivers'),
            ),
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

import 'package:cabwala/add_driver.dart';
import 'package:cabwala/manage_drivers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'add_cab.dart';
import 'home.dart';
import 'manage_cabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            // title: 'Flutter Demo',
            theme: ThemeData(
              fontFamily: 'Poppins', scaffoldBackgroundColor: Colors.white,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              // primarySwatch: Colors.blue,
            ),
            initialRoute: Home.id,
            routes: {
              Home.id: (context) => Home(),
              DriverManager.id: (context) => DriverManager(),
              AddDriver.id: (context) => AddDriver(),
              CabManager.id: (context) => const CabManager(),
              AddCab.id: (context) => const AddCab(),
              // ChatScreen.id: (context) => ChatScreen()
            },
            // home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}

import 'package:cabwala/add_driver.dart';
import 'package:cabwala/login.dart';
import 'package:cabwala/manage_drivers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'add_cab.dart';
import 'home.dart';
import 'manage_cabs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'stats.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
            initialRoute: Stats.id,
            routes: {
              Stats.id:(context) => Stats(cabs:148,drivers:100,mini: 48,sedan:70,suv:30,active:97,),
              Home.id: (context) => Home(),
              DriverManager.id: (context) => DriverManager(),
              AddDriver.id: (context) => AddDriver(),
              CabManager.id: (context) => const CabManager(),
              AddCab.id: (context) => const AddCab(),
              Login.id: (context) => const Login(),

              // ChatScreen.id: (context) => ChatScreen()
            },
            // home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}

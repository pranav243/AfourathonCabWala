import 'package:cabwala/add_driver.dart';
import 'package:cabwala/list_drivers.dart';
import 'package:cabwala/manage_drivers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'list_cabs.dart';
import 'add_cab.dart';
import 'home.dart';
import 'manage_cabs.dart';
import 'package:firebase_core/firebase_core.dart';

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
            initialRoute: Home.id,
            routes: {
              Home.id: (context) => const Home(),
              DriverManager.id: (context) => const DriverManager(),
              AddDriver.id: (context) => const AddDriver(),
              CabManager.id: (context) => const CabManager(),
              AddCab.id: (context) => const AddCab(),
              ListCabs.id: (context) => const ListCabs(),
              ListDrivers.id: (context) => const ListDrivers(),
            },
            // home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}

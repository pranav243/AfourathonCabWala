import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'home.dart';

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
                fontFamily: 'Poppins', scaffoldBackgroundColor: Colors.white
                // primarySwatch: Colors.blue,
                ),
            initialRoute: Home.id,
            routes: {
              Home.id: (context) => Home(),
              // Levels.id: (context) => Levels(),
              // Level1.id: (context) => Level1(),
              // ChatScreen.id: (context) => ChatScreen()
            },
            // home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}

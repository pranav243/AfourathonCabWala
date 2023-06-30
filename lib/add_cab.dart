import 'package:cabwala/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddCab extends StatefulWidget {
  static String id = "addCab_screen";
  const AddCab({super.key});

  @override
  State<AddCab> createState() => _AddCabState();
}

class _AddCabState extends State<AddCab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: regularAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset("images/ellipse2.svg"),
                SvgPicture.asset("images/cabbig.svg")
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            // InputBox("Driver ID"),
            InputBox("Registration Number", TextInputType.name),
            InputBox("Model", TextInputType.phone),
            InputBox("Colour", TextInputType.emailAddress),
            Container(
              alignment: Alignment.center,
              width: 307.91,
              height: 46.79,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(9, 100, 140, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: const Text(
                "Add Cab",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavBar(0, 0),
    );
  }
}

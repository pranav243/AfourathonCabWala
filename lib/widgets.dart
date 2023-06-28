import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

BottomNavigationBarItem BottomNavBarHome(selected) {
  if (selected == 1) {
    return BottomNavigationBarItem(
        icon: Stack(alignment: Alignment.topCenter, children: [
          Container(
            height: 36.72,
            width: 36.72,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.36),
                color: Color.fromRGBO(255, 255, 255, 0.47)),
          ),
          SvgPicture.asset("images/home.svg")
        ]),
        label: 'home');
  } else {
    return BottomNavigationBarItem(
        icon: Stack(alignment: Alignment.topCenter, children: [
          Container(
              height: 36.72,
              width: 36.72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.36),
                // color: Color.fromRGBO(255, 255, 255, 0.47)),
              )),
          SvgPicture.asset("images/home.svg")
        ]),
        label: 'home');
  }
}

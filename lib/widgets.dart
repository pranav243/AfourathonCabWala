import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

ClipRRect BottomNavBar(homeSelected, profilesetSelected) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    child: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(9, 100, 140, 1),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavBarHome(homeSelected),
          BottomNavBarProfileSettings(profilesetSelected),
        ]),
  );
}

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
        icon: SvgPicture.asset("images/home.svg"), label: 'home');
  }
}

BottomNavigationBarItem BottomNavBarProfileSettings(selected) {
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
          SvgPicture.asset("images/profileset.svg")
        ]),
        label: 'profileSettings');
  } else {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset("images/profileset.svg"),
        label: 'profileSettings');
  }
}

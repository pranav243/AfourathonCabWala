import 'package:cabwala/home.dart';
import 'package:cabwala/link_home.dart';
import 'package:cabwala/stats_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Container InputTitle(title) {
  return Container(
    margin: const EdgeInsets.only(left: 10, bottom: 5),
    child: Text(
      title,
      style: const TextStyle(
          color: Color.fromRGBO(144, 152, 177, 1),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5),
    ),
  );
}

Container DetailTitle(title) {
  return Container(
    margin: const EdgeInsets.only(left: 10, bottom: 5),
    child: Text(
      title,
      style: const TextStyle(
          color: Color(0xFF09648C),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5),
    ),
  );
}

AppBar regularAppBar(BuildContext context) {
  return AppBar(
    centerTitle: false,
    // toolbarHeight: ScreenUtil().setHeight(60),
    toolbarHeight: (60),
    elevation: 0,
    backgroundColor: Colors.white,
    leadingWidth: 0,
    title: InkWell(
        // onTap: ()=> Navigator.of(context).popUntil((route) => route.isFirst),
        onTap: () => Navigator.pop(context),
        child: SvgPicture.asset("images/backbutton.svg")),

    actions: const [
      Padding(
        padding:
            // EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            EdgeInsets.symmetric(horizontal: (20)),
        // child: SvgPicture.asset("images/profile.svg"),
      )
    ],
  );
}

Column TitleWidget(title, description) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          letterSpacing: 0.5,
          color: Color(0xFF333434),
        ),
      ),
      const SizedBox(
        // height: ScreenUtil().setHeight(3),
        height: (3),
      ),
      Text(description,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            letterSpacing: 0.5,
            color: Color(0xFF333434),
          ))
    ],
  );
}

ClipRRect BottomNavBar(homeSelected, manageSelected, statsSelected, context) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    child: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(9, 100, 140, 1),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavBarHome(homeSelected, context),
          BottomNavBarManage(manageSelected, context),
          BottomNavBarStats(statsSelected, context),
        ]),
  );
}

BottomNavigationBarItem BottomNavBarHome(selected, context) {
  if (selected == 1) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset("images/home1.svg"), label: 'home');
  } else {
    return BottomNavigationBarItem(
        icon: InkWell(
            onTap: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
            child: SvgPicture.asset("images/home0.svg")),
        label: 'home');
  }
}

BottomNavigationBarItem BottomNavBarManage(selected, context) {
  if (selected == 1) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset("images/manage1.svg"), label: 'profileSettings');
  } else {
    return BottomNavigationBarItem(
        icon: InkWell(
            onTap: () => Navigator.pushNamed(context, LinkHome.id),
            child: SvgPicture.asset("images/manage0.svg")),
        label: 'profileSettings');
  }
}

BottomNavigationBarItem BottomNavBarStats(selected, context) {
  if (selected == 1) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset("images/stats1.svg"), label: 'profileSettings');
  } else {
    return BottomNavigationBarItem(
        icon: InkWell(
            onTap: () => Navigator.pushNamed(context, StatsSearch.id),
            child: SvgPicture.asset("images/stats0.svg")),
        label: 'profileSettings');
  }
}

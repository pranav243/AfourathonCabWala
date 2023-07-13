import 'package:cabwala/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Column InputBox(title, keyboardType) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       InputTitle(title),
//       SizedBox(
//         height: 46.79,
//         width: 307.91,
//         child: TextField(
//           autocorrect: false,
//           textAlignVertical: TextAlignVertical.center,
//           keyboardType: keyboardType,
//           style: const TextStyle(
//               fontWeight: FontWeight.w400,
//               color: Color.fromRGBO(51, 52, 52, 1)),
//           decoration: const InputDecoration(
//               border: OutlineInputBorder(
//                   borderSide: BorderSide(
//                       width: 1, color: Color.fromRGBO(196, 196, 196, 1)),
//                   borderRadius: BorderRadius.all(Radius.circular(10)))),
//         ),
//       ),
//       const SizedBox(
//         height: 20,
//       )
//     ],
//   );
// }

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
        onTap: () => Navigator.pop(context),
        child: SvgPicture.asset("images/backbutton.svg")),

    actions: [
      Padding(
        padding:
            // EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            const EdgeInsets.symmetric(horizontal: (20)),
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

// ClipRRect BottomNavBar(homeSelected, profilesetSelected, context) {
//   return ClipRRect(
//     borderRadius: const BorderRadius.only(
//         topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//     child: BottomNavigationBar(
//         backgroundColor: const Color.fromRGBO(9, 100, 140, 1),
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         items: [
//           BottomNavBarHome(homeSelected, context),
//           BottomNavBarProfileSettings(profilesetSelected),
//         ]),
//   );
// }

// BottomNavigationBarItem BottomNavBarHome(selected, context) {
//   if (selected == 1) {
//     return BottomNavigationBarItem(
//         icon: Stack(alignment: Alignment.topCenter, children: [
//           Container(
//             height: 36.72,
//             width: 36.72,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(18.36),
//                 color: Color.fromRGBO(255, 255, 255, 0.47)),
//           ),
//           SvgPicture.asset("images/home.svg")
//         ]),
//         label: 'home');
//   } else {
//     return BottomNavigationBarItem(
//         icon: InkWell(
//             onTap: () =>
//                 Navigator.popUntil(context, ModalRoute.withName(Home.id)),
//             child: SvgPicture.asset("images/home.svg")),
//         label: 'home');
//   }
// }

// BottomNavigationBarItem BottomNavBarProfileSettings(selected) {
//   if (selected == 1) {
//     return BottomNavigationBarItem(
//         icon: Stack(alignment: Alignment.topCenter, children: [
//           Container(
//             height: 36.72,
//             width: 36.72,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(18.36),
//                 color: Color.fromRGBO(255, 255, 255, 0.47)),
//           ),
//           SvgPicture.asset("images/profileset.svg")
//         ]),
//         label: 'profileSettings');
//   } else {
//     return BottomNavigationBarItem(
//         icon: SvgPicture.asset("images/profileset.svg"),
//         label: 'profileSettings');
//   }
// }


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
          BottomNavBarManage(manageSelected),
          BottomNavBarStats(statsSelected),
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
                Navigator.popUntil(context, ModalRoute.withName(Home.id)),
            child: SvgPicture.asset("images/home0.svg")),
        label: 'home');
  }
}

BottomNavigationBarItem BottomNavBarManage(selected) {
  if (selected == 1) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset("images/manage1.svg"), label: 'profileSettings');
  } else {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset("images/manage0.svg"), label: 'profileSettings');
  }
}

BottomNavigationBarItem BottomNavBarStats(selected) {
  if (selected == 1) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset("images/stats1.svg"), label: 'profileSettings');
  } else {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset("images/stats0.svg"), label: 'profileSettings');
  }
}

import 'package:flutter/material.dart';

import '../helpers.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({Key? key, this.selectedIndex, this.onItemTapped})
      : super(key: key);

  final int? selectedIndex;
  final void Function(int)? onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 14,
      iconSize: 28,
      selectedFontSize: 16,
      unselectedFontSize: 14,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.brown.shade400,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Profile",
        ),
      ],
      currentIndex: selectedIndex!,
      selectedItemColor: appColor,
      onTap: onItemTapped,
    );
  }
}

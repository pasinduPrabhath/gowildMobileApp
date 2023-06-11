import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

import '../Screens/admin/dashboard_screen.dart';

class SideNavBar extends StatelessWidget {
  const SideNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SideNavigationBar(
          selectedIndex: selectedIndex,
          items: const [
            SideNavigationBarItem(
              icon: Icons.dashboard,
              label: 'Dashboard',
            ),
            SideNavigationBarItem(
              icon: Icons.person,
              label: 'Account',
            ),
            SideNavigationBarItem(
              icon: Icons.settings,
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        // Expanded(
        //   child: views.elementAt(selectedIndex),
        // ),
      ],
    );
  }

  void setState(Null Function() param0) {}
}

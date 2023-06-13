import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  String? accountName = '';
  String? accountEmail;
  ImageProvider? currentAccountPicture;
  SideDrawer({
    super.key,
    this.accountName,
    this.accountEmail,
    this.currentAccountPicture,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountName!),
            accountEmail: Text(accountEmail!),
            currentAccountPicture: CircleAvatar(
              backgroundImage: currentAccountPicture,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          ListTile(
            title: Text(
              'Item 1',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text(
              'Item 2',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              'Logout',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            leading: Icon(Icons.logout,
                color: Theme.of(context).colorScheme.onPrimary),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/');
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}

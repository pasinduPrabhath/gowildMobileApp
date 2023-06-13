import 'package:flutter/material.dart';
import '../../reusable_components/sideDrawer.dart';
import '../../backend/api_requests/registration_screen_api.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

List<Widget> views = const [
  Center(
    child: Text('Dashboard'),
  ),
  Center(
    child: Text('Account'),
  ),
  Center(
    child: Text('Settings'),
  ),
];
int selectedIndex = 0;
final numberOfUsers = 0;

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: SideDrawer(
        accountName: 'Pasindu Prabhath',
        accountEmail: 'pasinduprabhath@gmail.com',
        currentAccountPicture:
            const AssetImage('assets/images/adminProfPic.png'),
      ),
      body: Center(
        child: FutureBuilder<int>(
          future: Api.numberOfRegisteredUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                'Number of registered users: ${snapshot.data}',
                style: TextStyle(fontSize: 24),
              );
            } else if (snapshot.hasError) {
              return Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 24),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

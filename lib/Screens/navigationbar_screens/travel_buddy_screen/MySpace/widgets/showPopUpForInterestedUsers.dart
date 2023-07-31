import 'package:flutter/material.dart';
import 'package:gowild/backend/api_requests/client_api.dart';

import '../../../profile_screen/clientProfileView/thirdPersonView/thirdPersonProfileView.dart';

class InterestedUsersPopup extends StatefulWidget {
  final List<Map<String, dynamic>> users;
  final String email;
  final String userName;
  final int postId;

  const InterestedUsersPopup(
      {super.key,
      required this.users,
      required this.email,
      required this.userName,
      required this.postId});

  @override
  State<InterestedUsersPopup> createState() => _InterestedUsersPopupState();
}

class _InterestedUsersPopupState extends State<InterestedUsersPopup> {
  @override
  Widget build(BuildContext context) {
    print('username: ${widget.userName}');
    return AlertDialog(
      title: const Text('Interested Users'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.users.length,
          itemBuilder: (context, index) {
            final user = widget.users[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThirdPersonProfileScreen(
                      email: user['email'],
                      userName: user['firstName'] + ' ' + user['lastName'],
                    ),
                  ),
                );
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user['profile_picture_url']),
                ),
                title: Text('${user['firstName']} ${user['lastName']}',
                    style: const TextStyle(fontSize: 14)),
                subtitle: Text(
                  '${user['town']} ${user['country']}',
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(168, 0, 0, 0),
                    backgroundColor: const Color.fromARGB(255, 208, 231, 247),
                  ),
                  onPressed: () async {
                    print('user id: ${user['user_id']}');
                    print('post id: ${widget.postId}');
                    final res = await ClientAPI.approveTravelBuddyReq(
                        user['user_id'], widget.postId);
                    print('res: $res');
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: const Text('Accept'),
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../Screens/navigationbar_screens/profile_screen/clientProfileView/thirdPersonView/thirdPersonProfileView.dart';
import '../backend/api_requests/client_api.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: ClientAPI.searchUsers(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return SearchListItem(
                firstName: snapshot.data?[index]['firstName'],
                lastName: snapshot.data?[index]['lastName'],
                town: snapshot.data?[index]['town'],
                country: snapshot.data?[index]['country'],
                email: snapshot.data?[index]['email'],
                key: ValueKey(index),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: ClientAPI.searchUsers(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return SearchListItem(
                firstName: snapshot.data?[index]['firstName'],
                lastName: snapshot.data?[index]['lastName'],
                town: snapshot.data?[index]['town'],
                country: snapshot.data?[index]['country'],
                email: snapshot.data?[index]['email'],
                key: ValueKey(index),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class SearchListItem extends StatelessWidget {
  const SearchListItem({
    required Key key,
    required this.firstName,
    required this.lastName,
    required this.town,
    required this.country,
    required this.email,
  }) : super(key: key);

  final String firstName;
  final String lastName;
  final String town;
  final String country;
  final String email;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ThirdPersonProfileScreen(
                      email: email,
                      userName: '$firstName $lastName',
                    )));
      },
      child: ListTile(
        title: Text('$firstName $lastName'),
        subtitle: Text('$town, $country'),
      ),
    );
  }
}

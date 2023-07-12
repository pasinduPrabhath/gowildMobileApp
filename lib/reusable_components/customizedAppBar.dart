import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gowild/backend/api_requests/client_api.dart';

class CustomizedAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomizedAppBar({
    required Key key,
  }) : super(key: key);

  @override
  _CustomizedAppBarState createState() => _CustomizedAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 56);
}

class _CustomizedAppBarState extends State<CustomizedAppBar> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(235, 141, 228, 240),
                Color.fromARGB(235, 168, 230, 238),
                Color.fromARGB(235, 163, 211, 218),
                Color.fromARGB(235, 205, 235, 240),
                Color.fromARGB(235, 195, 227, 231),
                Color.fromARGB(235, 197, 223, 226),
                Color.fromARGB(235, 205, 231, 235),
                Color.fromARGB(235, 213, 238, 241),
                Color.fromARGB(235, 205, 231, 235),
                Color.fromARGB(235, 227, 234, 235),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text(
          'GoWild',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                _isSearching ? Icons.cancel : Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: Colors.black,
              ),
              onPressed: () async {
                final result = await ClientAPI.searchUsers('ser');
                print(result[0]['firstName']);
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
              return ListTile(
                title: Text(snapshot.data?[index]['firstName']),
                subtitle: Text(snapshot.data?[index]['lastName']),
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
              return ListTile(
                title: Text(snapshot.data?[index]['firstName']),
                subtitle: Text(snapshot.data?[index]['lastName']),
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

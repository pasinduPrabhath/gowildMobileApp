import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomizedAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomizedAppBar({
    required Key key,
  }) : super(key: key);

  @override
  _CustomizedAppBarState createState() => _CustomizedAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomizedAppBarState extends State<CustomizedAppBar> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
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
      title: _isSearching
          ? const SearchWidget()
          : const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'GoWild',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
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
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
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
            onPressed: () {
              // do something
            },
          ),
        ),
      ],
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: const TextStyle(fontSize: 20),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(40.0), // Decreased from 80.0 to 40.0
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: const Color.fromARGB(139, 231, 230, 230),
            prefixIcon: const Icon(Icons.search),
          ),
          onChanged: (value) {
            // Update the search text
          },
        ),
      ),
    );
  }
}

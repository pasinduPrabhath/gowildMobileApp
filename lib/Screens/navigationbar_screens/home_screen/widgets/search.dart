import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: const TextStyle(fontSize: 18, color: Colors.black),
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
    );
  }
}

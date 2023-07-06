import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomizedAppBar extends StatelessWidget {
  const CustomizedAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        // height: MediaQuery.of(context).size.height * 0.2,
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
      title: const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Text(
          'GoWild',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      actions: [
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
            )),
      ],
    );
  }
}

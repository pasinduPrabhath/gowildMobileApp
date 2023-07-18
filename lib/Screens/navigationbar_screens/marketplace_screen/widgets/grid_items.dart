import 'package:flutter/material.dart';

class GridItems extends StatelessWidget {
  GridItems({super.key});
  var pnames = [
    "Apple Watch -M2",
    "White Tshirt",
    "Nike Shoe",
    "Ear Headphone"
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pnames.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.2,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(108, 147, 212, 241),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "30% off",
                      style: TextStyle(
                          color: Color.fromARGB(255, 12, 12, 12), fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    "assets/images/market/${pnames[index]}.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pnames[index],
                          style: const TextStyle(
                              color: Color.fromARGB(255, 12, 12, 12),
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}

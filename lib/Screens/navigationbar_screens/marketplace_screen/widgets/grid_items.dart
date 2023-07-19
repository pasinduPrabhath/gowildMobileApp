import 'package:flutter/material.dart';
import '../marketProductDescription.dart';

class GridItems extends StatelessWidget {
  GridItems({super.key});
  var pnames = [
    "Apple Watch -M2",
    "White Tshirt",
    "Nike Shoe",
    "Ear Headphone",
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
        // childAspectRatio: 0.7,
        crossAxisCount: 2,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (context, index) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          margin:
              const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(136, 147, 211, 241),
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
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductDescription()));
                  },
                  child: Image.asset(
                    // "assets/images/bird/bird-1.jpg"
                    "assets/images/market/${pnames[index]}.png",
                    height: 100,
                    width: 100,
                  ),
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
                    Text(
                      pnames[index],
                      style: const TextStyle(
                          color: Color.fromARGB(255, 12, 12, 12),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    const Row(
                      children: [
                        Text(
                          "Rs. 2000",
                          style: TextStyle(
                              color: Color.fromARGB(255, 179, 55, 55),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class MyTripRequestCardView extends StatelessWidget {
  const MyTripRequestCardView({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Padding(
        padding: const EdgeInsets.only(top: 13.0, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'John Doe',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Text(' traveling to '),
                          const Text(
                            'Wilpaththu',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            '2 hours ago, ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            'Traveling on 27 February 2023',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, sapien vel lacinia bibendum, velit velit bibendum sapien, vel bibendum sapien velit bibendum sapien.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Interested',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.person_outline),
                      SizedBox(width: 5),
                      Text('2/8',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(width: 5),
                      Text(
                        'People',
                        style: TextStyle(fontSize: 14),
                      ),
                      // SizedBox(width: size.width * 0.1),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(Icons.message_outlined),
                      SizedBox(width: 5),
                      Text(
                        'Contact',
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              height: 1,
              color: const Color.fromARGB(255, 228, 227, 227),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 13.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 10),
                    child: Text('Approval Status :'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Text('Not Approved'),
                  ),
                  Icon(
                    Icons.verified_outlined,
                    size: 15,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyRequestShowCard extends StatelessWidget {
  const MyRequestShowCard({
    super.key,
    required this.size,
  });

  final Size size;
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this request?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    ).then((confirmed) {
      if (confirmed != null && confirmed) {
        // Perform the delete operation here
      }
    });
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.favorite_border),
                      ),
                      // const SizedBox(width: 5),
                      Text(
                        'View Interested',
                        style: TextStyle(fontSize: 13),
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
                  InkWell(
                    onTap: () {
                      _showDeleteConfirmationDialog(context);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.delete_outline),
                        SizedBox(width: 5),
                        Text(
                          'Delete',
                        )
                      ],
                    ),
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

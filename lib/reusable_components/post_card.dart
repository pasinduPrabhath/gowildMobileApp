import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String imageUrl;
  const PostCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // NetworkImage url;
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          //header section
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 10,
            ).copyWith(right: 0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/premium-vector/young-girl-anime-style-character-vector-illustration-design-manga-anime-girl_147933-100.jpg?w=740'),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hellen Keller',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      barrierColor:
                          const Color.fromARGB(110, 0, 0, 0).withOpacity(0.5),
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor:
                            Colors.black, // set background color to black
                        child: ListView(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            shrinkWrap: true,
                            children: [
                              'Delete',
                            ]
                                .map(
                                  (e) => InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                      child: Text(e),
                                    ),
                                  ),
                                )
                                .toList()),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                )
              ],
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.width * 0.6,
            width: double.infinity,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: IconButton(
                  alignment: Alignment.bottomRight,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
          //Description and comments
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '1,300 likes',
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: const TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'Hellen Keller',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' Leopard in the wild',
                          )
                        ]),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: const Text(
                      'View all 300 comments',
                      style: TextStyle(fontSize: 14, color: Colors.white54),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: const Text(
                    '9 minutes ago',
                    style: TextStyle(fontSize: 14, color: Colors.white54),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

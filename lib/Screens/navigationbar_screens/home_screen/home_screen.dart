import 'package:flutter/material.dart';
import './widgets/background.dart';
import '../../../reusable_components/customizedAppBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomizedAppBar(
            key: UniqueKey(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 32.0,
                    ),
                    padding: const EdgeInsets.all(14.0),
                    height: size.height * 0.4,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      // color: const Color.fromARGB(255, 124, 25, 25),
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/bird/bird-${index + 1}.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(children: [
                      Row(
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(
                                radius: 16.0,
                                backgroundImage: AssetImage(
                                    'assets/images/adminProfPic.png'),
                              ),
                              SizedBox(width: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pasindu Prabhath',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '2 hours ago',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_vert,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildPostStat(
                              context: context,
                              likeCount: '120k',
                              icon: const Icon(Icons.favorite_border,
                                  color: Colors.white)),
                          _buildPostStat(
                              context: context,
                              likeCount: '20k',
                              icon: const Icon(
                                Icons.bookmark_border_outlined,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildPostStat({
    required BuildContext context,
    required String likeCount,
    required Icon icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(150, 190, 184, 184),
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: icon,
          ),
          Text(
            likeCount,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(width: 15.0),
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Color.fromARGB(139, 231, 230, 230),
        prefixIcon: Icon(Icons.search),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            // Clear the search text
          },
        ),
      ),
      onChanged: (value) {
        // Update the search text
      },
    );
  }
}

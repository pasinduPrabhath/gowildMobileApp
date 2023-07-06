import 'package:flutter/material.dart';
import 'package:gowild/Screens/message_detail/widgets/message_detail_background.dart';
import 'package:gowild/reusable_components/profile_image.dart';

class MessageDetailScreen extends StatelessWidget {
  MessageDetailScreen({super.key});

  final messages = [
    'yeash we ',
    'are going',
    ' there and ',
    'hipe you wil',
    ' join with us how about ypu',
    ' do you ',
    'come with us with',
    ' or no ok',
    ' then lets meet again',
    ' after few weekks may ',
    'be mothns how knows.'
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MessageDetailsBackground(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            SizedBox(
              height: size.height * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ProfileImage(radius: 35.0),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Charlie Kelly',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 3),
                      const Text('Online')
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              // flex: 0,
              child: ListView.builder(
                  itemCount: messages.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, index) {
                    final message = messages[index];
                    return Row(
                      mainAxisAlignment: index % 2 == 0
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: size.width * 0.8,
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.only(
                                bottomLeft: const Radius.circular(20.0),
                                bottomRight: const Radius.circular(20.0),
                                topLeft: index.isEven
                                    ? Radius.zero
                                    : const Radius.circular(20.0),
                                topRight: index.isOdd
                                    ? Radius.zero
                                    : const Radius.circular(20.0),
                              )),
                          child: Text(message),
                        ),
                      ],
                    );
                  }),
            ),
            Container(
              height: 50,
              width: size.width,
              margin: const EdgeInsets.only(
                left: 40.0,
                right: 40.0,
                bottom: 50.0,
                top: 8.0,
              ),
              padding: const EdgeInsets.only(
                left: 32.0,
                right: 16.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 25.0,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type a message',
                      hintStyle: Theme.of(context).textTheme.displayMedium,
                    )),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

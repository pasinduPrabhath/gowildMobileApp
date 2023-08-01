// import 'package:flutter/material.dart';
// import 'package:gowild/Screens/navigationbar_screens/message_screen/widgets/message_item.dart';
// import './widgets/message_background.dart';

// class MessageScreen extends StatelessWidget {
//   const MessageScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MessageBackground(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.secondary,
//           title: Text(
//             'Messages',
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     boxShadow: [
//                       BoxShadow(
//                           offset: const Offset(0, 4),
//                           blurRadius: 25.0,
//                           color: Theme.of(context)
//                               .colorScheme
//                               .secondary
//                               .withOpacity(0.3)),
//                     ],
//                   ),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: const Color.fromARGB(255, 162, 179, 209)
//                           .withOpacity(0.1),
//                       isDense: true,
//                       hintText: 'Search  😎',
//                       hintStyle: Theme.of(context)
//                           .textTheme
//                           .displaySmall
//                           ?.copyWith(color: Colors.grey),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15.0),
//                         borderSide: const BorderSide(
//                             width: 0.0, style: BorderStyle.none),
//                       ),
//                       suffixIcon: Icon(
//                         Icons.search,
//                         color: Theme.of(context).colorScheme.onSecondary,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 ListView(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   children: const [
//                     MessageItem(
//                       name: "Pasindu Prabhath",
//                       message: "Hi what\'s going on!",
//                     ),
//                     MessageItem(
//                       name: "Pasindu Prabhath",
//                       message: "Hi what\'s going on!",
//                     ),
//                     MessageItem(
//                       name: "Pasindu Prabhath",
//                       message: "Hi what\'s going on!",
//                     ),
//                     MessageItem(
//                       name: "Pasindu Prabhath",
//                       message: "Hi what\'s going on!",
//                     ),
//                     MessageItem(
//                       name: "Pasindu Prabhath",
//                       message: "Hi what\'s going on!",
//                     ),
//                     MessageItem(
//                       name: "Pasindu Prabhath",
//                       message: "Hi what\'s going on!",
//                     ),
//                     MessageItem(
//                       name: "Pasindu Prabhath",
//                       message: "Hi what\'s going on!",
//                     ),
//                     MessageItem(
//                       name: "Pasindu Prabhath",
//                       message: "Hi what\'s going on!",
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//       ),
//     );
//   }
// }

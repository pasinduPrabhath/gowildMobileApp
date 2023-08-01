// import 'package:flutter/material.dart';
// import '../../../../reusable_components/profile_image.dart';
// import '../../../message_detail/message_detail_screen.dart';

// class MessageItem extends StatelessWidget {
//   const MessageItem({super.key, required this.name, required this.message});
//   final String name;
//   final String message;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => MessageDetailScreen()));
//       },
//       child: Container(
//         padding: const EdgeInsets.all(10.0),
//         margin: const EdgeInsets.only(bottom: 16.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(32.0),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const ProfileImage(
//               radius: 28,
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name,
//                     style: Theme.of(context).textTheme.displayLarge,
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     message,
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:showny/constants.dart';
// import 'package:showny/helper/font_helper.dart';

// class BattleListItem extends StatelessWidget {
//   const BattleListItem(
//       {super.key,
//       required this.imageUrl,
//       required this.title,
//       required this.description,
//       required this.due,
//       required this.btnTitle,
//       required this.onTap});

//   final String imageUrl;
//   final String title;
//   final String description;
//   final String due;
//   final String btnTitle;
//   final Function() onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Container(
//             width: 130,
//             height: 200,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(imageUrl),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8.0),
//           Expanded(
//             child: SizedBox(
//               height: 200,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 10.0),
//                   Text(title, style: Constants.appBarTitleStyle),
//                   const SizedBox(height: 8.0),
//                   Text(
//                     description,
//                     style: Constants.appBarTitleStyle.copyWith(fontSize: 12.0),
//                   ),
//                   const SizedBox(height: 17.0),
//                   Text(
//                     due,
//                     style: Constants.defaultTextStyle.copyWith(fontSize: 12.0),
//                   ),
//                   const Spacer(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       CupertinoButton(
//                         minSize: 0.0,
//                         padding: EdgeInsets.zero,
//                         color: Colors.black,
//                         child: SizedBox(
//                             width: 120,
//                             height: 32,
//                             child: Center(
//                               child: Text(
//                                 btnTitle,
//                                 style: FontHelper.regualr_14_ffffff,
//                               ),
//                             )),
//                         onPressed: () {
//                           onTap();
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

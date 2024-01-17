// import 'package:flutter/material.dart';

// class PageRouteBuilderRightLeft<T> extends PageRouteBuilder<T> {
//   final Widget child;
//   final AxisDirection direction;
//   final Duration duration;

//   PageRouteBuilderRightLeft({
//     required this.child,
//     this.direction = AxisDirection.right, // 기본값은 오른쪽에서 왼쪽으로
//     this.duration = const Duration(milliseconds: 250), // 기본 전환 시간
//   }) : super(
//           pageBuilder: (context, animation, secondaryAnimation) => child,
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             Offset beginOffset;
//             switch (direction) {
//               case AxisDirection.right:
//                 beginOffset = const Offset(1.0, 0.0);
//                 break;
//               case AxisDirection.left:
//                 beginOffset = const Offset(-1.0, 0.0);
//                 break;
//               case AxisDirection.up:
//                 beginOffset = const Offset(0.0, 1.0);
//                 break;
//               case AxisDirection.down:
//                 beginOffset = const Offset(0.0, -1.0);
//                 break;
//             }

//             var endOffset = Offset.zero;
//             var curve = Curves.ease;

//             var tween = Tween(begin: beginOffset, end: endOffset)
//                 .chain(CurveTween(curve: curve));
//             var offsetAnimation = animation.drive(tween);

//             return SlideTransition(
//               position: offsetAnimation,
//               child: child,
//             );
//           },
//           transitionDuration: duration,
//         );
// }

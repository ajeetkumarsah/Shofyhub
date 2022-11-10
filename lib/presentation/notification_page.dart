// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:zcart_seller/presentation/auth/signup_screen.dart';

// class NotificationPage extends StatelessWidget {
//   const NotificationPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         toolbarHeight: 60.h,
//         backgroundColor: const Color(0xff683CB7),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(22.r),
//           ),
//         ),
//         title: const Text("My Account"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const SignupScreen(),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.person),
//           ),
//         ],
//       ),
//       body: ListView.separated(
//         separatorBuilder: (context, index) => SizedBox(
//           height: 4.h,
//         ),
//         itemCount: 5,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15, top: 13),
//             child: Container(
//               padding: const EdgeInsets.only(top: 15),
//               height: 85.h,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: const Color(0xffF5F5F5),
//                 borderRadius: BorderRadius.circular(15.r),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Order #09876543",
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5.h,
//                     ),
//                     const Text(
//                       "You recieved a new order",
//                       style: TextStyle(
//                         color: Colors.black54,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5.h,
//                     ),
//                     const Text(
//                       "19 Jul 2021 7:38Pm",
//                       style: TextStyle(
//                         color: Color(0xffB0B0B0),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

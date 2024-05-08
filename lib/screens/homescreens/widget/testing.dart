// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class TestingBlood extends StatelessWidget {
//   const TestingBlood({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//   decoration: BoxDecoration(
//     color: Color(0xFFFFFAFA),
//     borderRadius: BorderRadius.circular(10),
//   ),
//   child: Container(
//     padding: EdgeInsets.fromLTRB(0.3, 41, 0, 0),
//     child: Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Text(
//           '1/4',
//           style: GoogleFonts.getFont(
//             'Lexend',
//             fontWeight: FontWeight.w600,
//             fontSize: 20,
//             color: Color(0xFF490007),
//           ),
//         ),
//         Positioned(
//           right: -107,
//           top: -48.4,
//           child: Transform(
//             transform: Matrix4.identity()..rotateZ(3.1295428124),
//             child: Container(
//               width: 573.5,
//               height: 301.8,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0xFFE1204D),
//                     offset: Offset(0, 4),
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child: SvgPicture.network(
//                 'Assets2/vectors/ellipse_1_x2.svg',
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           left: 29.7,
//           right: 32,
//           bottom: 113,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25),
//               color: Color(0xFFFFFFFF),
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0x40000000),
//                   offset: Offset(0, 4),
//                   blurRadius: 2,
//                 ),
//               ],
//             ),
//             child: SizedBox(
//               width: 298,
//               height: 523,
//               child: Container(
//                 padding: EdgeInsets.fromLTRB(17, 44, 21.7, 10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.fromLTRB(0, 0, 0, 36),
//                       child: Text(
//                         'Is your weight less than 50kg?',
//                         style: GoogleFonts.getFont(
//                           'Lexend',
//                           fontWeight: FontWeight.w600,
//                           fontSize: 20,
//                           color: Color(0xFF000000),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(12, 0, 4.3, 30),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Color(0xFFE1204D)),
//                         borderRadius: BorderRadius.circular(50),
//                         color: Color(0xFFFFFFFF),
//                       ),
//                       child: Container(
//                         padding: EdgeInsets.fromLTRB(0, 19, 1.8, 21),
//                         child: 
//                         Text(
//                           'Yes',
//                           style: GoogleFonts.getFont(
//                             'Lexend',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 20,
//                             color: Color(0xFF000000),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(12, 0, 4.3, 179),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Color(0xFFE1204D)),
//                         borderRadius: BorderRadius.circular(50),
//                         color: Color(0xFFFFFFFF),
//                       ),
//                       child: Container(
//                         padding: EdgeInsets.fromLTRB(0, 19, 0.6, 21),
//                         child: 
//                         Text(
//                           'No',
//                           style: GoogleFonts.getFont(
//                             'Lexend',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 20,
//                             color: Color(0xFF000000),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(4.3, 0, 4.3, 0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Color(0xFFFFFFFF),
//                         ),
//                         child: Container(
//                           padding: EdgeInsets.fromLTRB(11, 9, 13.3, 12),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.fromLTRB(0, 0, 3.4, 0),
//                                 child: Text(
//                                   'Skip ',
//                                   style: GoogleFonts.getFont(
//                                     'Lexend',
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 18,
//                                     color: Color(0xFF490008),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.fromLTRB(0, 9.5, 0, 4.6),
//                                 width: 14.4,
//                                 height: 9,
//                                 child: 
//                                 SizedBox(
//                                   width: 14.4,
//                                   height: 9,
//                                   child: SvgPicture.network(
//                                     'Assets2/vectors/vector_131_x2.svg',
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           right: 17,
//           top: -17,
//           child: Container(
//             decoration: BoxDecoration(
//               color: Color(0xFFE1204D),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(50),
//               ),
//             ),
//             child: Container(
//               width: 68,
//               height: 60,
//               padding: EdgeInsets.fromLTRB(0, 18, 0.9, 18.7),
//               child: 
//               SizedBox(
//                 width: 13.1,
//                 height: 23.3,
//                 child: SvgPicture.network(
//                   'Assets2/vectors/vector_20_x2.svg',
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           left: 21.7,
//           top: -17,
//           child: Container(
//             decoration: BoxDecoration(
//               color: Color(0xFFE1204D),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(50),
//               ),
//             ),
//             child: Container(
//               width: 68,
//               height: 60,
//               padding: EdgeInsets.fromLTRB(0.9, 18.7, 0, 18),
//               child: 
//               SizedBox(
//                 width: 13.1,
//                 height: 23.3,
//                 child: SvgPicture.network(
//                   'Assets2/vectors/vector_49_x2.svg',
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// );
//   }
// }
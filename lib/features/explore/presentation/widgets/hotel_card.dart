// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class HotelCard extends StatelessWidget {
//   final String image;
//   final String name;
//   final String address;
//   final String rating;
//   final String duration;

//   const HotelCard({
//     Key? key,
//     required this.image,
//     required this.name,
//     required this.address,
//     required this.rating,
//     required this.duration,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(9),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.13),
//             offset: const Offset(0, 9),
//             blurRadius: 12,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(9),
//               bottomLeft: Radius.circular(9),
//             ),
//             child: Image.network(
//               image,
//               width: 93,
//               height: 93,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name,
//                     style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: const Color(0xFF0085FF),
//                     ),
//                   ),
//                   Text(
//                     address,
//                     style: GoogleFonts.poppins(
//                       fontSize: 9,
//                       color: const Color(0xFF6C757D),
//                     ),
//                   ),
//                   const SizedBox(height: 22),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Image.network(
//                             'https://cdn.builder.io/api/v1/image/assets/a9a243819b6642fbb0aa075040b1900b/8c1b03cd6f2b589957e9d6c47c065be1f41990e226577ed1979cc042d6b35f88?placeholderIfAbsent=true',
//                             width: 14,
//                             height: 14,
//                           ),
//                           const SizedBox(width: 3),
//                           Text(
//                             rating,
//                             style: GoogleFonts.inter(
//                               fontSize: 11,
//                               color: const Color(0xFF6C757D),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFFFC727),
//                           borderRadius: BorderRadius.circular(15),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.25),
//                               offset: const Offset(0, 1),
//                               blurRadius: 4,
//                             ),
//                           ],
//                         ),
//                         child: Text(
//                           duration,
//                           style: GoogleFonts.poppins(
//                             fontSize: 11,
//                             color: const Color(0xFF161616),
//                             letterSpacing: 0.28,
//                           ),
//                         ),
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
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'rating_display.dart';

// class JourneyCard extends StatelessWidget {
//   final String image;
//   final String title;
//   final String subtitle;
//   final double rating;
//   final String price;
//   final String duration;

//   const JourneyCard({
//     super.key,
//     required this.image,
//     required this.title,
//     required this.subtitle,
//     required this.rating,
//     required this.price,
//     required this.duration,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(9),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black,
//             offset: const Offset(0, 9),
//             blurRadius: 12,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
//             child: Image.network(
//               image,
//               width: double.infinity,
//               height: 120,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(6),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: GoogleFonts.poppins(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: const Color(0xFF0085FF),
//                   ),
//                 ),
//                 Text(
//                   subtitle,
//                   style: GoogleFonts.poppins(
//                     fontSize: 9,
//                     color: const Color(0xFF6C757D),
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 RatingDisplay(rating: rating),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       price,
//                       style: GoogleFonts.poppins(
//                         fontSize: 11,
//                         color: const Color(0xFF0085FF),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFFFC727),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Text(
//                         duration,
//                         style: GoogleFonts.inter(
//                           fontSize: 11,
//                           color: const Color(0xFF161616),
//                           letterSpacing: 0.28,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
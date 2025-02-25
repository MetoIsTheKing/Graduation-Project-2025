// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class RatingDisplay extends StatelessWidget {
//   final double rating;

//   const RatingDisplay({
//     super.key,
//     required this.rating,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Image.network(
//           'https://cdn.builder.io/api/v1/image/assets/a9a243819b6642fbb0aa075040b1900b/161c11c1fb244adc188ea6b9213dac6d0a4f3cd0780331b8d61f9c946c3df215?placeholderIfAbsent=true',
//           width: 14,
//           height: 14,
//           fit: BoxFit.contain,
//         ),
//         const SizedBox(width: 3),
//         Text(
//           rating.toString(),
//           style: GoogleFonts.poppins(
//             fontSize: 11,
//             color: const Color(0xFF6C757D),
//           ),
//         ),
//       ],
//     );
//   }
// }
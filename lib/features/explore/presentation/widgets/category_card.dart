// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CategoryCard extends StatelessWidget {
//   final String icon;
//   final String label;
//   final bool isSelected;

//   const CategoryCard({
//     Key? key,
//     required this.icon,
//     required this.label,
//     required this.isSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(19),
//         border: Border.all(
//           color: const Color(0xFFA6B4C1),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Image.network(
//             icon,
//             width: 41,
//             height: 41,
//             fit: BoxFit.contain,
//           ),
//           const SizedBox(height: 7),
//           Text(
//             label,
//             style: GoogleFonts.poppins(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: const Color(0xFF0085FF),
//               letterSpacing: 0.27,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CustomBottomNavBar extends StatelessWidget {
//   const CustomBottomNavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFF6F6F6),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.25),
//             offset: const Offset(0, 4),
//             blurRadius: 19,
//             spreadRadius: 9,
//           ),
//         ],
//         border: const Border(
//           top: BorderSide(
//             color: Color(0x33000000),
//             width: 1,
//           ),
//         ),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 9),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildNavItem('Explore', 'URL_routing', true),
//           _buildNavItem('Flights', 'URL_airplane', false),
//           _buildNavItem('Favorites', 'URL_lovely', false),
//           _buildNavItem('Profile', 'URL_profile', false),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(String label, String iconUrl, bool isSelected) {
//     return SizedBox(
//       height: 50,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: 26,
//             height: 26,
//             child: Image.network(iconUrl),
//           ),
//           Text(
//             label,
//             style: GoogleFonts.poppins(
//               fontSize: 11,
//               color: isSelected ? const Color(0xFF0085FF) : const Color(0xFF82898F),
//               letterSpacing: -0.16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
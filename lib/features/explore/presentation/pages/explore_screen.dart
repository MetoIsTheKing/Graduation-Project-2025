// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:graduation_project_2025/features/explore/presentation/widgets/custom_botton_nav_bar.dart';
// import 'package:graduation_project_2025/features/explore/presentation/widgets/hotel_card.dart';
// import '../widgets/category_card.dart';
// import '../widgets/journey_card.dart';

// class ExploreScreen extends StatelessWidget {
//   const ExploreScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0085FF),
//       body: SingleChildScrollView(
//         child: Container(
//           constraints: const BoxConstraints(maxWidth: 480),
//           //margin: const EdgeInsets.symmetric(horizontal: auto),
//           child: Column(
//             children: [
//               // Header Logo
//               Padding(
//                 padding: const EdgeInsets.only(left: 21, top: 12),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Image.network(
//                     'https://cdn.builder.io/api/v1/image/assets/a9a243819b6642fbb0aa075040b1900b/f8e6de7742d2241245778c978c09cfc644d51f70172b6c474d1dc2eb4f65b8ab?placeholderIfAbsent=true',
//                     width: 54,
//                     height: 54 / 2.57,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),

//               // Hero Section
//               Container(
//                 margin: const EdgeInsets.only(top: 11),
//                 padding: const EdgeInsets.fromLTRB(16, 16, 16, 26),
//                 child: Stack(
//                   children: [
//                     Image.network(
//                       'https://cdn.builder.io/api/v1/image/assets/a9a243819b6642fbb0aa075040b1900b/2e996abcc9c835714ef9674241c59a4a11e7ccb8bc002da391c075a6c208bbcf?placeholderIfAbsent=true',
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 26),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               'Sky is the limit. Explore the world with us.',
//                               style: GoogleFonts.poppins(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                           Image.network(
//                             'https://cdn.builder.io/api/v1/image/assets/a9a243819b6642fbb0aa075040b1900b/3413d497d230144c7ce2bebdfc38edeaa72987b5b9b4bf8e58bb2dac4bf28737?placeholderIfAbsent=true',
//                             width: 41,
//                             height: 41,
//                             fit: BoxFit.contain,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Category Icons
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CategoryCard(
//                       icon: 'https://cdn.builder.io/api/v1/image/assets/a9a243819b6642fbb0aa075040b1900b/31dd6a984d0a4d634beb083fdd3d5b95f44a86148b8643174c2cf08c5df60dc5?placeholderIfAbsent=true',
//                       label: 'Hotel',
//                       isSelected: false,
//                     ),
//                     const SizedBox(width: 20),
//                     CategoryCard(
//                       icon: 'https://cdn.builder.io/api/v1/image/assets/a9a243819b6642fbb0aa075040b1900b/b9191e1f7fda8169faa46b8497c739f497a490239f2a66bee73ea2dd2c700b73?placeholderIfAbsent=true',
//                       label: 'Flight',
//                       isSelected: true,
//                     ),
//                     const SizedBox(width: 20),
//                     CategoryCard(
//                       icon: 'https://cdn.builder.io/api/v1/image/assets/a9a243819b6642fbb0aa075040b1900b/c82d1626b0b814a9ddbfa3fdd7be37080ab943c337104b94ae5a51b736f9a702?placeholderIfAbsent=true',
//                       label: 'Activity',
//                       isSelected: false,
//                     ),
//                   ],
//                 ),
//               ),

//               // Main Content Area
//               Container(
//                 margin: const EdgeInsets.only(top: 9),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(32.16),
//                     topRight: Radius.circular(32.16),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Journey together',
//                             style: GoogleFonts.poppins(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                               color: const Color(0xFF4B5563),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: JourneyCard(
//                                   image: 'https://cdn.builder.io/api/v1/image/assets/a9a243819b6642fbb0aa075040b1900b/13b0132ef640b3fcc5ff3d7c5b3cd09410f592ece505ac7a26166779562c0f95?placeholderIfAbsent=true',
//                                   title: 'Mount Bromo',
//                                   subtitle: 'Volcano in East Java',
//                                   rating: 4.9,
//                                   price: '\$ 150/pax',
//                                   duration: '3D2N',
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: JourneyCard(
//                                   image: 'https://cdn.builder.io/api/v1/image/assets/a9a243819b6642fbb0aa075040b1900b/c532d5aad8cfd383abd8c15ae8f58dc7ad005daf50416d01bfa0fdc7072a07da?placeholderIfAbsent=true',
//                                   title: 'Labengki Sombori',
//                                   subtitle: 'Islands in Sulawesi',
//                                   rating: 4.8,
//                                   price: '\$ 250/pax',
//                                   duration: '3D2N',
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Hotels Section
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(15, 29, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Hotels recomendation for you',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600,
//                                   color: const Color(0xFF4B5563),
//                                 ),
//                               ),
//                               Text(
//                                 'See all',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 13,
//                                   color: const Color(0xFF0085FF),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           HotelCard(
//                             image: 'https://cdn.builder.io/api/v1/image/assets/a9a243819b6642fbb0aa075040b1900b/254fe7443769766a02b8bc9712097dfa6002aa9566aea0bc819c224fac93bfb2?placeholderIfAbsent=true',
//                             name: 'Swiss-Belhotel Rainforest Kuta',
//                             address: 'Jl. Sunset Road No. 101, Kuta, Bali, Indonesia',
//                             rating: '4-star hotel',
//                             duration: '3D2N',
//                           ),
//                           const SizedBox(height: 9),
//                           HotelCard(
//                             image: 'https://cdn.builder.io/api/v1/image/assets/a9a243819b6642fbb0aa075040b1900b/ff2dc6449122c83512b9f1f5e956452b7cb70440001ef6424181d0cedbc3a265?placeholderIfAbsent=true',
//                             name: 'Swiss-Belhotel Rainforest Kuta',
//                             address: 'Jl. Sunset Road No. 101, Kuta, Bali, Indonesia',
//                             rating: '4-star hotel',
//                             duration: '3D2N',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(),
//     );
//   }
// }
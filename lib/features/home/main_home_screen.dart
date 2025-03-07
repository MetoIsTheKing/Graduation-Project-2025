import 'package:flutter/material.dart';
import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/chat_bot.dart';
//import 'package:graduation_project_2025/features/home/my_bookings.dart';
import 'package:graduation_project_2025/features/home/explore/presentation/pages/explore_screen.dart';
import 'package:graduation_project_2025/features/home/my_profile.dart';
import 'package:graduation_project_2025/features/home/search_airport.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  MainHomeScreenState createState() => MainHomeScreenState();
}

class MainHomeScreenState extends State<MainHomeScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  late List<Widget> _screens;
  bool _isNavBarVisible = true; // State variable to control visibility
  double _lastOffset = 0.0; // To track the last scroll position

  @override
  void initState() {
    super.initState();
    _screens = [
      ExploreScreen(scrollController: _scrollController),

      //TODO: just a place holder👇
      SearchAirport(
        isOrigin: true,
        appBarTitle: 'Search Origin',
        onBack: () => context.pop(),
      ),
      //MyBookings(),
      ChatBot(),
      MyProfile(),
    ];

    // Add a listener to the ScrollController
    _scrollController.addListener(() {
      double currentOffset = _scrollController.offset;
      if (currentOffset > _lastOffset && currentOffset > 0) {
        // Scrolling down
        if (_isNavBarVisible) {
          setState(() {
            _isNavBarVisible = false;
          });
        }
      } else if (currentOffset < _lastOffset) {
        // Scrolling up
        if (!_isNavBarVisible) {
          setState(() {
            _isNavBarVisible = true;
          });
        }
      }
      _lastOffset = currentOffset;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          // PageView takes up the full screen
          PageView(
            controller: _pageController,
            physics: BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: _screens,
          ),
          // AnimatedPositioned for smooth hide/show animation
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            left: 8,
            right: 8,
            bottom:
                _isNavBarVisible ? 0.05 : -300, // Slide out of view when hidden
            child: Stack(
              children: [
                Positioned(
                  bottom: 40,
                  left: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: const Color.fromARGB(255, 139, 139, 139),
                          offset: const Offset(0, 0),
                          blurRadius: 16,
                          spreadRadius: -20,
                        ),
                      ],
                    ),
                  ),
                ),
                DotCurvedBottomNav(
                  scrollController: _scrollController,
                  hideOnScroll: true,
                  indicatorColor: AppColors.appYellow,
                  backgroundColor: Colors.white,
                  animationDuration: const Duration(milliseconds: 300),
                  animationCurve: Curves.easeInOut,
                  selectedIndex: _currentPage,
                  indicatorSize: 5,
                  borderRadius: 25,
                  height: 70,
                  onTap: (index) {
                    setState(() {
                      _currentPage = index;
                      _pageController.jumpToPage(index);
                    });
                  },
                  items: [
                    Icon(
                      size: 30,
                      Icons.explore,
                      color: _currentPage == 0
                          ? AppColors.appYellow
                          : AppColors.appDarkGrey,
                    ),
                    Icon(
                      size: 30,
                      Icons.bookmark_outlined,
                      color: _currentPage == 1
                          ? AppColors.appYellow
                          : AppColors.appDarkGrey,
                    ),
                    Icon(
                      size: 30,
                      Icons.child_care_outlined,
                      color: _currentPage == 2
                          ? AppColors.appYellow
                          : AppColors.appDarkGrey,
                    ),
                    Icon(
                      size: 30,
                      Icons.person,
                      color: _currentPage == 3
                          ? AppColors.appYellow
                          : AppColors.appDarkGrey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

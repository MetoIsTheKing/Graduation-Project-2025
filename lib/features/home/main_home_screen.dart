import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/flights_data_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/search_flights/search_flights_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/pages/search_flights_screen.dart';
import 'package:graduation_project_2025/features/home/my_bookings/presentation/cubit/my_bookings_cubit.dart';

import 'package:graduation_project_2025/features/home/my_bookings/presentation/pages/my_bookings_screen.dart';
import 'package:graduation_project_2025/features/home/explore/main_explore/presentation/pages/explore_screen.dart';

import 'profile/presentation/pages/my_profile.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  MainHomeScreenState createState() => MainHomeScreenState();
}

class MainHomeScreenState extends State<MainHomeScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  late List<ScrollController> _scrollControllers; // List of ScrollControllers
  bool _isNavBarVisible = true; // State variable to control visibility
  double _lastOffset = 0.0; // To track the last scroll position

  @override
  void initState() {
    super.initState();
    // Initialize one ScrollController per page
    _scrollControllers = List.generate(
      4, // Number of screens (Explore, MyBookings, ChatBot, MyProfile)
      (index) => ScrollController(),
    );

    // Add a listener to all ScrollControllers
    for (var controller in _scrollControllers) {
      controller.addListener(_onScroll);
    }

    // Ensure initial scroll check happens after first frame
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _checkScrollPosition();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _scrollControllers) {
      controller.removeListener(_onScroll);
      controller.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    _checkScrollPosition(); // Call the check method
  }

  void _checkScrollPosition() {
    final controller = _scrollControllers[_currentPage];
    if (controller.hasClients) {
      double currentOffset = controller.offset;
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, deviceInfo, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey[200],
          body: Stack(
            children: [
              // PageView takes up the full screen
              PageView(
                controller: _pageController,
                physics: ClampingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      _checkScrollPosition(); // Re-check after page change
                    });
                  });
                },
                children: [
                  BlocProvider(
                    create: (context) => FlightsDataCubit(),
                    child: SearchFlightsScreen(
                        scrollController: _scrollControllers[0]),
                  ),
                  BlocProvider(
                    create: (context) =>
                        getIt<MyBookingsCubit>()..loadBookings(),
                    child: MyBookingsScreen(
                        scrollController: _scrollControllers[1]),
                  ),
                  MyProfile(scrollController: _scrollControllers[3]),
                ],
              ),
              // AnimatedPositioned for smooth hide/show animation
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                left: 8,
                right: 8,
                bottom: _isNavBarVisible
                    ? 0.05
                    : -300, // Slide out of view when hidden
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
                      scrollController: _scrollControllers[
                          _currentPage], // Use current page's controller
                      hideOnScroll: true,
                      indicatorColor: AppColors.appYellow,
                      backgroundColor: Colors.white,
                      animationDuration: const Duration(milliseconds: 300),
                      animationCurve: Curves.easeInOut,
                      selectedIndex: _currentPage,
                      indicatorSize: 6,
                      borderRadius: 25,
                      height: 70,
                      onTap: (index) {
                        setState(() {
                          _currentPage = index;
                          _pageController.jumpToPage(index);
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            _checkScrollPosition(); // Re-check after tap
                          });
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
      },
    );
  }
}

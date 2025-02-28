import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/features/auth/presentation/pages/login_screen.dart';
import 'package:graduation_project_2025/features/auth/presentation/pages/signup_screen.dart';
import 'package:graduation_project_2025/features/home/explore/presentation/pages/explore_screen.dart';
import 'package:graduation_project_2025/features/home/main_home_screen.dart';
import 'package:graduation_project_2025/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:graduation_project_2025/features/on_boarding/presentation/pages/onboarding_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Hello , here is the splash screen'),
            ),
          ),
        );
      case Routes.logIn:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case Routes.signUp:
        return MaterialPageRoute(builder: (context) => SignupScreen());
      case Routes.mainHome:
        return MaterialPageRoute(builder: (context) => MainHomeScreen());
      case Routes.explore:
        return MaterialPageRoute(builder: (context) => ExploreScreen());
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => OnBoardingCubit(),
            child: const OnboardingScreen(),
          ),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('Undefined Route'),
        ),
      ),
    );
  }
}

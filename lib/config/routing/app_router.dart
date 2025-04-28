import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/features/auth/presentation/pages/change_password_screen.dart';
import 'package:graduation_project_2025/features/auth/presentation/pages/forgetpassword_screen.dart';
import 'package:graduation_project_2025/features/auth/presentation/pages/login_screen.dart';
import 'package:graduation_project_2025/features/auth/presentation/pages/signup_screen.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/flights_data_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/search_flights/search_flights_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/pages/flights_screen.dart';
import 'package:graduation_project_2025/features/home/explore/main_explore/presentation/pages/explore_screen.dart';
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
      case Routes.forgetpassword:
        return MaterialPageRoute(builder: (context) => ForgetpasswordScreen());
      case Routes.changePassword:
        return MaterialPageRoute(builder: (context) => ChangePasswordScreen());
      case Routes.resetPassword:
        return MaterialPageRoute(
            builder: (context) => ChangePasswordScreen(
                  isReset: true,
                ));
      case Routes.signUp:
        return MaterialPageRoute(builder: (context) => SignupScreen());
      case Routes.mainHome:
        return MaterialPageRoute(builder: (context) => MainHomeScreen());
      case Routes.explore:
        return MaterialPageRoute(builder: (context) => ExploreScreen());
      case Routes.flights:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => getIt<FlightsDataCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => getIt<SearchFlightsCubit>(),
                    ),
                  ],
                  child: FlightsScreen(),
                ));
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

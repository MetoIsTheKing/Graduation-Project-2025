import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/routing/arguments.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/features/booking/presentation/pages/payment_screen.dart';
import 'package:graduation_project_2025/features/chat_bot/presentation/cubit/chat_bot_cubit.dart';
import 'package:graduation_project_2025/features/chat_bot/presentation/pages/chat_bot_screen.dart';

import 'package:graduation_project_2025/features/auth/presentation/pages/change_password_screen.dart';
import 'package:graduation_project_2025/features/auth/presentation/pages/forgetpassword_screen.dart';
import 'package:graduation_project_2025/features/auth/presentation/pages/login_screen.dart';
import 'package:graduation_project_2025/features/auth/presentation/pages/signup_screen.dart';
import 'package:graduation_project_2025/features/booking/presentation/cubit/booking_cubit/booking_cubit.dart';

import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/flights_data_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/search_flights/search_flights_cubit.dart';
import 'package:graduation_project_2025/features/booking/presentation/pages/booking_application_screen.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/pages/flight_search_results_screen.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/pages/search_flights_screen.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/pages/search_airport.dart';
import 'package:graduation_project_2025/features/home/explore/main_explore/presentation/pages/explore_screen.dart';
import 'package:graduation_project_2025/features/home/main_home_screen.dart';
import 'package:graduation_project_2025/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:graduation_project_2025/features/on_boarding/presentation/pages/onboarding_screen.dart';

import '../../features/home/explore/flights/data/models/flight_model.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
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
      case Routes.chatBot:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<ChatBotCubit>(),
                  child: ChatBotScreen(),
                ));
      // case Routes.flightReview:
      //   return MaterialPageRoute(builder: (context) => FlightReviewScreen());
      case Routes.flights:
        return MaterialPageRoute(builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<FlightsDataCubit>()),
              BlocProvider.value(value: getIt<SearchFlightsCubit>()),
            ],
            child: SearchFlightsScreen(),
          );
        });

      // here is how to pass the args to the destination screen
      case Routes.searchAirports:
        return MaterialPageRoute(builder: (context) {
          final argss = args as SearchAirportArguments;
          final searchFlightCubit = getIt<SearchFlightsCubit>();

          return SearchAirport(
              searchFlightsCubit: searchFlightCubit, args: argss);
        });
      case Routes.searchFlightResults:
        return MaterialPageRoute(
            // give the route its name so We can Use PopUntill
            settings: settings,
            builder: (context) {
              return FlightSearchResultsScreen(
                searchFlightsCubit: getIt<SearchFlightsCubit>(),
              );
            });
      case Routes.bookingApplication:
        return MaterialPageRoute(builder: (context) {
          final bookingArgs = args as Map<String, int>;
          return BookingApplicationScreen(
            travelers: bookingArgs,
          );
        });
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => OnBoardingCubit(),
            child: const OnboardingScreen(),
          ),
        );
      case Routes.bookingScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider.value(
            value: getIt<BookingCubit>(),
            child: BookingApplicationScreen(
              travelers: getIt<FlightSearchQueryParams>().getTravellersMap(),
            ),
          ),
        );
      case Routes.paymentScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider.value(
            value: getIt<BookingCubit>(),
            child: PaymentScreen(),
          ),
        );

      default:
        return undefinedRoute();
    }
  }

// how ot access the args inside hte destination screen ? and would it be nessesary to declare those args in the constructor of the destination screen ?
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

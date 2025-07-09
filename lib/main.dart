import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:graduation_project_2025/app.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/helpers/bloc_observer.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart'
    as my_device_info;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  await initDependencies();
  Bloc.observer = MyBlocObserver();
  FlutterNativeSplash.remove();

  // Initialize Stripe with your publishable key
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLIC_KEY']!;

  // This is for advanced settings, good to have
  await Stripe.instance.applySettings();

  runApp(MyApp());
}

// WITHOUT DEVICE PREVIEW (Don't touch this)
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initDependencies();
//   Bloc.observer = MyBlocObserver();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Update DeviceInfo with the real device's MediaQuery
//     getIt<DeviceInfo>().updateFromContext(context);
//     return MaterialApp(
//       home: MainHomeScreen(),
//     );
//   }
// }

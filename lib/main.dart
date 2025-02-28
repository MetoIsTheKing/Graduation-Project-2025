import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_2025/app.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/helpers/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  Bloc.observer = MyBlocObserver();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) {
        // Initialize context-dependent dependencies
        setupContextDependentDependencies(context);
        return MyApp();
      },
    ),
  );
}

// WITHOUT DEVICE PREVIEW (Don't touch this)
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize context-independent dependencies
//   await initDependencies();

//   // Set up Bloc observer (if needed)
//   Bloc.observer = MyBlocObserver();

//   // Get the initial MediaQueryData from the window
//   final mediaQueryData = MediaQueryData.fromWindow(WidgetsBinding.instance.window);

//   // Initialize context-dependent dependencies
//   setupContextDependentDependencies(mediaQueryData);

//   // Run the app
//   runApp(MyApp());
// }


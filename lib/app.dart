import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/routing/app_router.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart'
    as my_device_info;
import 'package:graduation_project_2025/features/auth/presentation/cubit/auth_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Make sure you have all your necessary imports here

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: MaterialApp(
        // 1. REMOVE the old DevicePreview properties
        // locale: DevicePreview.locale(context), <--- DELETE THIS
        // builder: DevicePreview.appBuilder, <--- DELETE THIS

        // 2. ADD the new builder for your DeviceInfo logic
        builder: (context, child) {
          // This ensures your singleton is updated whenever the app rebuilds
          getIt<my_device_info.DeviceInfo>().updateFromContext(context);
          // The builder must return the child widget for the app to display
          return child!;
        },

        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter().generateRoute,
        initialRoute: Routes.onBoarding,
      ),
    );
  }
}

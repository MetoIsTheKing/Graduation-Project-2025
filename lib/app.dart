import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/routing/app_router.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().generateRoute,
      initialRoute: Routes.onBoarding,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/routing/app_router.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().generateRoute,
      initialRoute: Routes.flights,
    );
  }
}

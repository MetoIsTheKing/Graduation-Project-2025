import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/routing/app_router.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/features/auth/presentation/cubit/auth_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter().generateRoute,
        initialRoute: Routes.signUp,
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_2025/app.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/helpers/bloc_observer.dart';

void main() async{
  await initDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp()));
}


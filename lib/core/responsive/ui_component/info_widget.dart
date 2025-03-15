import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';

class InfoWidget extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceInfo deviceInfo,
      BoxConstraints constraints) builder;

  const InfoWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final deviceInfo = GetIt.instance<DeviceInfo>();
    return ValueListenableBuilder<bool>(
      valueListenable: deviceInfo.notifier,
      builder: (context, _, __) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return builder(context, deviceInfo, constraints);
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../Models/device_info.dart'; // Adjust the import path

class InfoWidget extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceInfo deviceInfo, BoxConstraints constraints) builder;

  const InfoWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Retrieve the singleton instance of DeviceInfo from GetIt
        final deviceInfo = GetIt.instance<DeviceInfo>();

        return builder(context, deviceInfo, constraints);
      },
    );
  }
}
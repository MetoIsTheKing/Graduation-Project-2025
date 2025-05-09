import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';

class RecommendationTag extends StatelessWidget {
  const RecommendationTag({
    super.key,
    required this.tagData,
    required this.medium12,
    required this.deviceInfo,
     this.constraints,
    required this.tagColor,
  });

  final String tagData;
  final TextStyle medium12;
  final DeviceInfo deviceInfo;
  final BoxConstraints? constraints;
  final Color tagColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: constraints!.maxWidth * 0.02),
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.05),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: constraints!.maxWidth * 0.03),
        child: Text(
          tagData,
          style: medium12.copyWith(
              color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

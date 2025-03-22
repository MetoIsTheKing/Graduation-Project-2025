import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class BaseWidget extends StatelessWidget {
  final ScrollController? scrollController;
  final Widget backgroundWidget;
  final Widget foregroundWidget;
  const BaseWidget({super.key, this.scrollController, required this.backgroundWidget, required this.foregroundWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBlue,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          controller: scrollController,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.appBlue,
            ),
            child: Stack(
              children: [
                backgroundWidget,
                foregroundWidget,
              ],
            ),
          ),
        )),
    );
  }
}
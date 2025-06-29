import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/curved_appbar.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

import '../../../../config/theming/text_styles.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constraints) {
      return Scaffold(
        appBar: CurvedAppbar(
          onBack: () => context.pop(),
          backgroundColor: AppColors.appBlue,
          titleWidget: Text(
            'Payment',
            style: TextStyles.medium20(deviceInfo, Colors.white),
          ),
          backButtonColor: Colors.white,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
        ),
      );
    });
  }
}

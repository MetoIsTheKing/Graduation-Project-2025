import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_textfield.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/signup_widgets/auth_phone_widget.dart';
import 'package:intl_phone_field/countries.dart';

class ContactInfoTile extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final Country selectedCountry;
  final void Function(Country) onCountryChanged;
  const ContactInfoTile({
    super.key,
    required this.emailController,
    required this.phoneController,
    required this.selectedCountry,
    required this.onCountryChanged,
  });

  @override
  State<ContactInfoTile> createState() => _ContactInfoTileState();
}

class _ContactInfoTileState extends State<ContactInfoTile> {
  final FocusNode emailNode = FocusNode();
  final FocusNode phoneNode = FocusNode();
  Color expandableTitleColor = AppColors.appDarkBlue;

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, deviceInfo, constraints) {
        return Padding(
          padding: EdgeInsets.only(top: deviceInfo.screenHeight * 0.015),
          child: ExpansionTile(
            title: Text(
              'Contact Info',
              style: TextStyles.medium20(deviceInfo, expandableTitleColor),
            ),
            backgroundColor: Colors.white,
            childrenPadding: EdgeInsets.symmetric(
              horizontal: deviceInfo.screenWidth * 0.05,
              vertical: deviceInfo.screenHeight * 0.012,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                deviceInfo.screenHeight * 0.03,
              ),
              side: BorderSide(
                color: AppColors.appBlue,
                width: deviceInfo.screenHeight * 0.003,
              ),
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                deviceInfo.screenHeight * 0.026,
              ),
            ),
            leading: Image.asset(
              'assets/images/contact_info_icon.png',
              height: deviceInfo.screenHeight * 0.025,
              color: expandableTitleColor,
            ),
            iconColor: AppColors.appDarkBlue,
            collapsedIconColor: AppColors.appDarkBlue,
            dense: true,
            textColor: AppColors.appDarkBlue,
            collapsedTextColor: AppColors.appDarkBlue,
            collapsedBackgroundColor: AppColors.appYellow,
            expansionAnimationStyle: AnimationStyle(
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 300),
            ),
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: deviceInfo.screenHeight * 0.01,
                ),
                child: AuthTextField(
                  prefix: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  controller: widget.emailController,
                  focusNode: emailNode,
                  nextFocusNode: phoneNode,
                  needValidation: true,
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: deviceInfo.screenHeight * 0.015),
                child: AuthPhoneWidget(
                  controller: widget.phoneController,
                  onCountryChanged: widget.onCountryChanged,
                  initialCountry: widget.selectedCountry,
                  focusNode: phoneNode,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

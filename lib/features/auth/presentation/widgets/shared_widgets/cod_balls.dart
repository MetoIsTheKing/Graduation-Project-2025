import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';

class CodBalls extends StatelessWidget {
  const CodBalls({
    super.key,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    required this.onchang,
  });
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final void Function(String)? onchang;
  @override
  Widget build(BuildContext context) {
    final TextStyle inputTextStyle = TextStyles.mediumDark16
        .copyWith(fontSize: deviceInfo.screenWidth * 0.04, color: Colors.black);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceInfo.screenWidth * 0.01),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            counterText: "",
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius:
                    BorderRadius.circular(deviceInfo.screenWidth * .8)),
            constraints: BoxConstraints(
              maxWidth: deviceInfo.screenWidth * .15,
              minHeight: deviceInfo.screenHeight * .11,
            ),
            filled: true,
            fillColor: AppColors.appGrey,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(deviceInfo.screenWidth * .8),
            )),
        style: inputTextStyle,
        keyboardType: TextInputType.text,
        maxLength: 1,
        textAlign: TextAlign.center,
        //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        focusNode: focusNode,
        onChanged: onchang,
      ),
    );
  }
}
// class CodBalls extends StatefulWidget {
//   CodBalls({
//     super.key,
//   });

//   @override
//   State<CodBalls> createState() => _CodBallsState();
// }

// class _CodBallsState extends State<CodBalls> {
//   @override
//   FocusNode ballFocus = FocusNode();

//   TextEditingController? ballController;

//   @override
//   void dispose() {
//     ballFocus.dispose();
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     final deviceInfo = getIt<DeviceInfo>();

//     return TextField(
//       controller: ballController,
//     )
//     ; }}
//     Container(
//         width: deviceInfo.screenWidth * .15,
//         height: deviceInfo.screenWidth * .15,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             color: AppColors.appGrey,
//             borderRadius: BorderRadius.circular(deviceInfo.screenWidth * .3)),
//         child: AuthTextField(
//           isPassword: false,
//           controller: ballController,
//           keyboardType: TextInputType.number,
//           prefix: "",
//           hint: "",
//           needValidation: true,
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
// import 'package:get/get.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/features/auth/presentation/pages/signup_screen.dart';

import '../pages/security_page.dart';
import 'my_profile_rows.dart';

class MyProfileSignupBody extends StatelessWidget {
  const MyProfileSignupBody({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constrains) {
      final fieldsSpacing = deviceInfo.screenHeight * 0.015;
      print('this is code from MyProfile ---> ${deviceInfo.hashCode}');
      return Scaffold(
          body: Column(children: [
        Container(
          height: deviceInfo.screenHeight * (330 / 874),
          width: deviceInfo.screenWidth * (403 / 403),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius:
                  BorderRadius.circular(deviceInfo.screenWidth * 0.09)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deviceInfo.screenHeight * .040,
                  ),
                  Image.asset(
                    "assets/images/not-registeredArtboard.png",
                    // width: 120,
                    // height: 120,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    'You are not signed in !!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.52,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: deviceInfo.screenHeight * .05,
                    width: deviceInfo.screenWidth * .5,
                    child: CustomRoundedButton(
                      deviceInfo: deviceInfo,
                      label: 'Sign in',
                      backgroundColor: Colors.white,
                      textColor: Colors.blue,
                      onPressed: () {
                        context.pushNamed(Routes.signUp);
                      },
                    ),
                  )
                ]),
          ),
        ),
        SizedBox(
          height: deviceInfo.screenHeight * .02,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(children: [
            buildMenuRow(
                icon: "assets/images/Heart.svg",
                title: "Favorites",
                deviceInfo: deviceInfo),
            buildMenuRow(
                icon: "assets/images/msg.svg",
                title: "Notifications",
                deviceInfo: deviceInfo),
            buildMenuRow(
                icon: "assets/images/plane_icon.svg",
                title: "Travel Preferences",
                deviceInfo: deviceInfo),
            buildMenuRow(
                icon: "assets/images/Navigation3.svg",
                title: "Payment Methods",
                deviceInfo: deviceInfo),
            buildMenuRow(
              icon: "assets/images/Lock.svg",
              title: "Security",
              deviceInfo: deviceInfo,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecurityPage())),
            ),
            buildMenuRow(
              icon: "assets/images/Navigation.svg",
              title: "Settings",
              deviceInfo: deviceInfo,
            ),
            buildMenuRow(
                icon: "assets/images/Help circle.svg",
                title: "Help",
                deviceInfo: deviceInfo),
            buildMenuRow(
                icon: "assets/images/icon_about.svg",
                title: "About",
                deviceInfo: deviceInfo),
          ]),
        )
      ]));
    });
  }
}

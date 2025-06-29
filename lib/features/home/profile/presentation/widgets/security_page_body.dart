import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';

import 'my_profile_rows.dart';

class SecurityPageBody extends StatelessWidget {
  const SecurityPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constrains) {
      final fieldsSpacing = deviceInfo.screenHeight * 0.015;
      print('this is code from MyProfile ---> ${deviceInfo.hashCode}');

      return Scaffold(
          body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * (250 / 874),
          width: MediaQuery.of(context).size.width * (403 / 403),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius:
                  BorderRadius.circular(deviceInfo.screenWidth * 0.09)),
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deviceInfo.screenHeight * .14,
                  ),
                  Text(
                    "Security",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 40,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(2, 2),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
        SizedBox(
          height: deviceInfo.screenHeight * .05,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(children: [
            buildMenuRow(
                icon: "assets/images/Lock.svg",
                title: "   Change Password",
                deviceInfo: deviceInfo),
            buildMenuRow(
                icon: "assets/images/mobile_friendly.svg",
                title: "   Sign out all the devices",
                deviceInfo: deviceInfo),
            buildMenuRow(
                icon: "assets/images/Trash 2.svg",
                title: "   Delete account",
                deviceInfo: deviceInfo),
          ]),
        )
      ]));
    });
  }
}

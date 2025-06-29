import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';

import '../pages/my_profile_signup.dart';
import '../pages/security_page.dart';
import 'my_profile_rows.dart';

class MyProfileBody extends StatelessWidget {
  const MyProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constrains) {
      print('this is code from MyProfile ---> ${deviceInfo.hashCode}');

      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: deviceInfo.screenHeight * 0.18,
              backgroundColor: Colors.blue,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  var top = constraints.biggest.height;
                  bool isCollapsed = top <= kToolbarHeight + 50;
                  return FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: 20, bottom: 16),
                    centerTitle: false,
                    title: isCollapsed
                        ? Row(
                            children: [
                              Image.asset(
                                "assets/images/Ellipse 54 .png",
                                width: 35,
                                height: 35,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Jos Creative",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : null,
                    background: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(30),
                          bottomStart: Radius.circular(30),
                          topEnd: Radius.zero,
                          topStart: Radius.zero),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(30),
                            bottomStart: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, top: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "My Profile",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 25),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/Ellipse 54 .png",
                                    width: 60,
                                    height: 60,
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Jos Creative",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "jospghamdes@gmail.com",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        "+1 654 785 4462",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 8.0, right: 10),
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/images/edit_1.svg"),
                                          Text(
                                            "Edit",
                                            style:
                                                TextStyle(color: Colors.amber),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    SizedBox(height: deviceInfo.screenHeight * .04),
                    Container(
                      width: deviceInfo.screenWidth,
                      height: deviceInfo.screenHeight * .11,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF3F9FF),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1, color: const Color(0xFF0084FF)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Complete your profile',
                                    style: TextStyle(
                                      color: const Color(0xFF0084FF),
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'you have remaining 2 steps',
                                    style: TextStyle(
                                      color: const Color(0xFF0084FF),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Stack(
                                    children: [
                                      Container(
                                        width: 127,
                                        height: 6,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFFC727),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 230,
                                        height: 6,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1,
                                              color: const Color(0xFF0084FF),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(22),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Image.asset(
                              "assets/images/check_1.png",
                              width: 80,
                              height: 80,
                              //   fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: deviceInfo.screenHeight * .04),
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
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecurityPage())),
                    ),
                    buildMenuRow(
                      icon: "assets/images/Lock.svg",
                      title: "Passenger Info",
                      deviceInfo: deviceInfo,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyProfileSignup())),
                    ),
                    buildMenuRow(
                        icon: "assets/images/Help circle.svg",
                        title: "Help",
                        deviceInfo: deviceInfo),
                    buildMenuRow(
                        icon: "assets/images/icon_about.svg",
                        title: "About",
                        deviceInfo: deviceInfo),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Row(
                        children: [
                          Icon(Icons.logout_outlined, color: Colors.red),
                          SizedBox(width: 10),
                          Text(
                            "Log Out",
                            style: TextStyle(color: Colors.red),
                          ),
                          const Spacer(),
                          InkWell(
                            child: SvgPicture.asset(
                                "assets/images/Shevron right.svg"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

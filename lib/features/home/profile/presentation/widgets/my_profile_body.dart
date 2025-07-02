import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
// import 'package:get/get.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/features/auth/presentation/pages/login_screen.dart';
import 'package:graduation_project_2025/features/booking/presentation/pages/payment_screen.dart';
import 'package:graduation_project_2025/features/home/main_home_screen.dart';
import 'package:graduation_project_2025/features/home/profile/presentation/manager/profile_cubit.dart';
import 'package:graduation_project_2025/features/home/profile/presentation/manager/profile_state.dart';
import 'package:graduation_project_2025/features/home/profile/presentation/widgets/custom_profile_dialog.dart';
import 'package:intl_phone_field/countries.dart';

import '../pages/my_profile_signup.dart';
import '../pages/security_page.dart';
import 'my_profile_rows.dart';

class MyProfileBody extends StatefulWidget {
  const MyProfileBody({super.key});

  @override
  State<MyProfileBody> createState() => _MyProfileBodyState();
}

class _MyProfileBodyState extends State<MyProfileBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Country selectedCountry = countries.firstWhere(
    (country) =>
        country.code == 'EG', // Change 'US' to your desired country code
    orElse: () => countries.first, // Fallback to the first country if not found
  );
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final phoneFocus = FocusNode();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    phoneFocus.dispose();
    super.dispose();
  }

  void onCountryChanged(Country country) {
    setState(() {
      selectedCountry = country;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? name;
    return BlocProvider<ProfileCubit>(
        create: (_) => getIt<ProfileCubit>()..getUserProfile(),
        child: InfoWidget(builder: (context, deviceInfo, constraints) {
          return Scaffold(
            key: _scaffoldKey,
            drawer: EditProfileDialog(
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              phoneController: phoneController,
              firstNameFocus: firstNameFocus,
              lastNameFocus: lastNameFocus,
              phoneFocus: phoneFocus,
              fieldsSpacing: deviceInfo.screenHeight * 0.015,
              onCountryChanged: onCountryChanged,
              selectedCountry: selectedCountry,
              dialogHeight: deviceInfo.screenHeight * 0.5,
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  expandedHeight: deviceInfo.screenHeight * 0.15,
                  backgroundColor: Colors.blue,
                  flexibleSpace: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
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
                                  Text(
                                    name.toString(),
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
                            width: double.infinity,
                            height: deviceInfo.screenHeight * .2,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadiusDirectional.only(
                                bottomEnd: Radius.circular(30),
                                bottomStart: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: deviceInfo.screenWidth * .02,
                                  top: deviceInfo.screenHeight * .04),
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
                                  SizedBox(
                                      height: deviceInfo.screenHeight * .01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/Ellipse 54 .png",
                                        width: deviceInfo.screenWidth * .12,
                                      ),
                                      SizedBox(
                                          width: deviceInfo.screenWidth * .03),
                                      BlocBuilder<ProfileCubit, UserState>(
                                        builder: (context, state) {
                                          if (state is UserProfileLoaded) {
                                            final user = state.profile;
                                            return Column(
                                              spacing: deviceInfo.screenHeight *
                                                  .015,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  name = user.user.firstName,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    height: deviceInfo
                                                            .screenHeight *
                                                        .00009,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  user.user.email,
                                                  style: TextStyle(
                                                    height: deviceInfo
                                                            .screenHeight *
                                                        .0009,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  user.user.phoneNumber,
                                                  style: TextStyle(
                                                    height: deviceInfo
                                                            .screenHeight *
                                                        .0009,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else if (state is UserLoading) {
                                            return CircularProgressIndicator(
                                                color: Colors.white);
                                          } else if (state is UserError) {
                                            return Text(
                                              "Error loading profile",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            );
                                          }
                                          return SizedBox(); // initial empty state
                                        },
                                      ),
                                      const Spacer(),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              // top: 8.0,
                                              right:
                                                  deviceInfo.screenHeight * .01,
                                              bottom: deviceInfo.screenHeight *
                                                  .01),
                                          child: GestureDetector(
                                            onTap: () {
                                              _scaffoldKey.currentState
                                                  ?.openDrawer();
                                            },
                                            child: Column(
                                              spacing:
                                                  deviceInfo.screenHeight * .01,
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/images/edit_1.svg"),
                                                Text("Edit",
                                                    style: TextStyle(
                                                        height: deviceInfo
                                                                .screenHeight *
                                                            .0009,
                                                        color: Colors.amber)),
                                              ],
                                            ),
                                          )
                                          //  Column(
                                          //   spacing:
                                          //       deviceInfo.screenHeight * .01,
                                          //   children: [
                                          //     SvgPicture.asset(
                                          //         "assets/images/edit_1.svg"),
                                          //     Text(
                                          //       "Edit",
                                          //       style: TextStyle(
                                          //           height: deviceInfo
                                          //                   .screenHeight *
                                          //               .0009,
                                          //           color: Colors.amber),
                                          //     ),
                                          //   ],
                                          // )
                                          ),
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
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceInfo.screenWidth * .06),
                    child: Column(
                      children: [
                        SizedBox(height: deviceInfo.screenHeight * .04),
                        buildMenuRow(
                            icon: "assets/images/Heart.svg",
                            title: "Favorites",
                            deviceInfo: deviceInfo),
                        buildMenuRow(
                          icon: "assets/images/msg.svg",
                          title: "Notifications",
                          deviceInfo: deviceInfo,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainHomeScreen())),
                        ),
                        buildMenuRow(
                            icon: "assets/images/plane_icon.svg",
                            title: "Travel Preferences",
                            deviceInfo: deviceInfo),
                        buildMenuRow(
                          icon: "assets/images/Navigation3.svg",
                          title: "Payment Methods",
                          deviceInfo: deviceInfo,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentScreen())),
                        ),
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
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen())),
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
        }));
  }
}

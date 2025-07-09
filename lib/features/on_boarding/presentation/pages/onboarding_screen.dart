import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:graduation_project_2025/features/on_boarding/presentation/widgets/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late ValueNotifier<int> indexNotifier;
  late int finalIndex = 0;

  @override
  void initState() {
    super.initState();
    indexNotifier = ValueNotifier<int>(context.read<OnBoardingCubit>().index!);
    //TODO: study value notifier
    indexNotifier.addListener(() {
      setState(() {
        finalIndex = indexNotifier.value;
        print('this is final index $finalIndex');
      });
    });
  }

  @override
  void dispose() {
    indexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constrains) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: deviceInfo.screenHeight * 0.01,
                horizontal: deviceInfo.screenWidth * 0.04,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<OnBoardingCubit, OnBoardingState>(
                    builder: (context, state) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation, // Fades the content in
                            child: child,
                          );
                        },
                        child: OnboardingContent(
                          key: ValueKey<int>(indexNotifier
                              .value), // Unique key to trigger the switch
                          index: indexNotifier.value,
                          image: state.onboardingContent.image,
                          title: state.onboardingContent.title,
                          subTitle: state.onboardingContent.subTitle,
                          deviceInfo: deviceInfo,
                        ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomRoundedButton(
                          deviceInfo: deviceInfo,
                          label: 'Next',
                          textColor: Colors.white,
                          backgroundColor: AppColors.appBlue,
                          onPressed: () {
                            if (indexNotifier.value == 2) {
                              context.pushReplacementNamed(Routes.mainHome);
                              return;
                            }
                            context.read<OnBoardingCubit>().nextOnboarding();
                            indexNotifier.value =
                                context.read<OnBoardingCubit>().index!;
                          },
                        ),
                      ),
                      Visibility(
                          visible: finalIndex < 2 ? true : false,
                          child:
                              SizedBox(width: deviceInfo.screenWidth * 0.02)),
                      Visibility(
                        visible: finalIndex < 2 ? true : false,
                        child: Expanded(
                          flex: 1,
                          child: CustomRoundedButton(
                            deviceInfo: deviceInfo,
                            label: 'Skip',
                            textColor: AppColors.appDarkBlue,
                            backgroundColor: AppColors.appYellow,
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) =>
                              //         CodeVerification(email: 'ana we7sh')));
                              context.pushReplacementNamed(Routes.mainHome);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
    });
  }
}

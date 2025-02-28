import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/presentation/widgets/hotel_recomendation_card.dart';
import 'package:graduation_project_2025/features/home/explore/presentation/widgets/profile_header.dart';
import 'package:graduation_project_2025/features/home/explore/presentation/widgets/quick_action_button.dart';
import 'package:graduation_project_2025/features/home/explore/presentation/widgets/section_label.dart';
import 'package:graduation_project_2025/features/home/explore/presentation/widgets/tour_card.dart';

class ExploreScreen extends StatefulWidget {
  final ScrollController? scrollController;
  const ExploreScreen({super.key, this.scrollController});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constrains) {
      print('this is hashcod inside explore : ${deviceInfo.hashCode}');
      //print('max width: ${constrains.maxWidth}');
      //print('max height: ${constrains.maxHeight}');

      return Scaffold(
        backgroundColor: AppColors.appBlue,
        body: SafeArea(
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.appBlue,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: deviceInfo.screenHeight * 0.03),
                    child: Image.asset('assets/images/global_map.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: deviceInfo.screenHeight * 0.22),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: deviceInfo.screenHeight * 0.02),
                        child: ProfileHeader(
                          userFirstName: 'John',
                          profileImage: 'assets/images/profile_img.png',
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: deviceInfo.screenHeight * 0.02),
                        child: IntrinsicWidth(
                          stepWidth: deviceInfo.screenWidth * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              QuickActionButton(
                                  iconlabel: 'Hotel',
                                  icon: 'assets/images/hotel_icon.png',
                                  dimension: deviceInfo.screenHeight * 0.11,
                                  onPressed: () {
                                    print('hotel clicked');
                                  }),
                              QuickActionButton(
                                  iconlabel: 'Flight',
                                  icon: 'assets/images/flight_icon.png',
                                  dimension: deviceInfo.screenHeight * 0.13,
                                  onPressed: () {
                                    print('flight clicked');
                                  }),
                              QuickActionButton(
                                  iconlabel: 'Activity',
                                  icon: 'assets/images/hotel_icon.png',
                                  dimension: deviceInfo.screenHeight * 0.11,
                                  onPressed: () {
                                    print('activity clicked');
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceInfo.screenWidth * 0.04,
                            vertical: deviceInfo.screenHeight * 0.02),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(deviceInfo.screenWidth * 0.08),
                            topRight:
                                Radius.circular(deviceInfo.screenWidth * 0.08),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SectionLabel(
                              deviceInfo: deviceInfo,
                              label: 'Journey Together',
                              onTap: () {
                                print('see all clicked');
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: deviceInfo.screenHeight * 0.025),
                              child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                dragStartBehavior: DragStartBehavior.start,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // place holders
                                    TourCard(
                                      tourTitle: 'Paris',
                                      tourSubtitle: 'Eiffel Tower',
                                      tourRating: 4.5,
                                      tourPrice: 200,
                                      onTap: () => print('card clicked'),
                                    ),
                                    TourCard(
                                      tourTitle: 'Paris',
                                      tourSubtitle: 'Eiffel Tower',
                                      tourRating: 4.5,
                                      tourPrice: 200,
                                    ),
                                    TourCard(
                                      tourTitle: 'Paris',
                                      tourSubtitle: 'Eiffel Tower',
                                      tourRating: 4.5,
                                      tourPrice: 200,
                                    ),
                                    TourCard(
                                      tourTitle: 'Paris',
                                      tourSubtitle: 'Eiffel Tower',
                                      tourRating: 4.5,
                                      tourPrice: 200,
                                    ),
                                    TourCard(
                                      tourTitle: 'Paris',
                                      tourSubtitle: 'Eiffel Tower',
                                      tourRating: 4.5,
                                      tourPrice: 200,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SectionLabel(
                              deviceInfo: deviceInfo,
                              label: 'Hotels recomendation for you',
                              onTap: () {
                                print('see all clicked');
                              },
                            ),
                            HotelRecomendationCard(
                              hotelImage: 'assets/images/hotel_img_1.png',
                              hotelName: 'Swissotel The Bosphorus',
                              hotelAddress: 'Istanbul, Turkey',
                              hotelRating: 4.5,
                            ),
                            HotelRecomendationCard(
                              hotelImage: 'assets/images/hotel_img_1.png',
                              hotelName: 'Swissotel The Bosphorus',
                              hotelAddress: 'Istanbul, Turkey',
                              hotelRating: 4.5,
                            ),
                            HotelRecomendationCard(
                              hotelImage: 'assets/images/hotel_img_1.png',
                              hotelName: 'Swissotel The Bosphorus',
                              hotelAddress: 'Istanbul, Turkey',
                              hotelRating: 4.5,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

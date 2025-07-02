import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/my_logger.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/error_toast.dart';
import 'package:graduation_project_2025/features/booking/data/models/booking_sub_models.dart';
import 'package:graduation_project_2025/features/booking/data/models/one_way_booking_model.dart';
import 'package:graduation_project_2025/features/booking/data/models/round_trip_booking_model.dart';
import 'package:graduation_project_2025/features/booking/presentation/cubit/booking_cubit/booking_cubit.dart';
import 'package:graduation_project_2025/features/booking/presentation/widgets/booking_application/contact_info_tile.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_model.dart';
import 'package:graduation_project_2025/features/booking/data/models/traveler_info_model.dart';
import 'package:graduation_project_2025/core/shared_components/curved_appbar.dart';
import 'package:graduation_project_2025/features/booking/presentation/widgets/booking_application/total_price_tag.dart';
import 'package:graduation_project_2025/features/booking/presentation/widgets/booking_application/traveler_info_tile.dart';
import 'package:intl_phone_field/countries.dart';

import '../../../../config/routing/auth_navigation_state.dart';
import '../../../../config/routing/routes.dart';
import '../cubit/booking_cubit/booking_state.dart';

class BookingApplicationScreen extends StatefulWidget {
  final Map<String, int> travelers;
  const BookingApplicationScreen({super.key, required this.travelers});

  @override
  State<BookingApplicationScreen> createState() =>
      _BookingApplicationScreenState();
}

class _BookingApplicationScreenState extends State<BookingApplicationScreen> {
  late BookingCubit cubit;

  late List<TravelerInfoUiModel> travelersInfoList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late int travelersCount;
  bool isRoundTrip = getIt<FlightSearchQueryParams>().isRoundTrip;
  double totalPriceOneWay = getIt<OneWayBookingModel>().totalPrice;
  double totalPriceRoundTrip = getIt<RoundTripBookingModel>().totalPrice;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  Country selectedCountry = Country(
    code: "EG",
    name: "Egypt",
    dialCode: "+20",
    flag: "🇪🇬",
    nameTranslations: {},
    minLength: 10,
    maxLength: 11,
  );
  @override
  void initState() {
    super.initState();
    // Calculate total travelers count
    travelersCount = widget.travelers['adults'] ?? 0;

    // Cubit Initialization
    cubit = getIt<BookingCubit>();
    // Add children count if available
    if (widget.travelers.containsKey('children')) {
      travelersCount += widget.travelers['children'] ?? 0;
    }

    // Add infants count if available
    if (widget.travelers.containsKey('infants')) {
      travelersCount += widget.travelers['infants'] ?? 0;
    }
    travelersInfoList = List.generate(
        travelersCount,
        (index) => TravelerInfoUiModel(
              travelerType: _getTravelerType(index).toLowerCase(),
              firstName: '',
              lastName: '',
              birthDate: '',
              nationality: '',
              passportNumber: '',
              passportExpiryDate: '',
              issuingCountry: '',
            ));
  }

  String _getTravelerType(int index) {
    int adultsCount = widget.travelers['adults'] ?? 0;
    int childrenCount = widget.travelers['children'] ?? 0;

    if (index < adultsCount) {
      return 'Adult';
    } else if (index < adultsCount + childrenCount) {
      int childNumber = (index - adultsCount) + 1;
      return 'Child';
    } else {
      int infantNumber = (index - adultsCount - childrenCount) + 1;
      return 'Infant';
    }
  }

  void onCountryChanged(Country country) {
    setState(() {
      selectedCountry = country;
    });
  }

  void submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Check if any attribute of any traveler is empty
      bool hasEmptyField = travelersInfoList.any((traveler) =>
          traveler.firstName.trim().isEmpty ||
          traveler.lastName.trim().isEmpty ||
          traveler.birthDate.trim().isEmpty ||
          traveler.nationality.trim().isEmpty ||
          traveler.passportNumber.trim().isEmpty ||
          traveler.passportExpiryDate.trim().isEmpty ||
          traveler.issuingCountry.trim().isEmpty);

      if (hasEmptyField ||
          emailController.text.isEmpty ||
          phoneController.text.isEmpty) {
        MyLogger.red('fill all traveler details and contact information.');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('fill all traveler details and contact information.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(10),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      //final jsonList = travelersInfoList.map((t) => t.toJson()).toList();
      if (isRoundTrip) {
        getIt<RoundTripBookingModel>().travellersInfo =
            travelersInfoList.map((e) => e.toTravellerInfoModel()).toList();
        getIt<RoundTripBookingModel>().contactDetails = ContactDetailsModel(
            email: emailController.text,
            phone: "${selectedCountry.dialCode}${phoneController.text}");
        MyLogger.green(
          'Round trip booking model updated with travelers info: ${getIt<RoundTripBookingModel>().toJson()} ',
        );
        log('Round trip booking model updated with travelers info: ${getIt<RoundTripBookingModel>().toJson()} ');
        // getIt<RoundTripBookingModel>().travellersInfo = jsonList;
      } else {
        getIt<OneWayBookingModel>().travellersInfo =
            travelersInfoList.map((e) => e.toTravellerInfoModel()).toList();
        getIt<OneWayBookingModel>().contactDetails = ContactDetailsModel(
          email: emailController.text,
          phone: "${selectedCountry.dialCode}${phoneController.text}",
        );

        MyLogger.green(
          'Round trip booking model updated with travelers info: ${getIt<OneWayBookingModel>().toJson()} ',
        );
        //getIt<OneWayBookingModel>().travellersInfo = jsonList;
      }
      //////////////////////// Booking in cubit
      cubit.bookFlight(
        isRoundTrip
            ? getIt<RoundTripBookingModel>().toJson()
            : getIt<OneWayBookingModel>().toJson(),
      );
      //////////////////////////////////////////////////
      //MyLogger.green(jsonEncode(jsonList));
    } else {
      MyLogger.red('Form validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constraints) {
      return Scaffold(
        appBar: CurvedAppbar(
            onBack: () => context.pop(),
            backgroundColor: AppColors.appBlue,
            titleWidget: Text(
              'Enter travelers details',
              style: TextStyles.medium20(deviceInfo, Colors.white),
            ),
            backButtonColor: Colors.white),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: deviceInfo.screenWidth * 0.05,
              vertical: deviceInfo.screenHeight * 0.03),
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TotalPriceTag(
                    deviceInfo: deviceInfo,
                    totalPrice: isRoundTrip
                        ? totalPriceRoundTrip.toString()
                        : totalPriceOneWay.toString(),
                    onTapSummary: () {
                      print('view summary');
                    },
                  ),
                  ListView.builder(
                    itemCount: travelersInfoList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return TravelerInfoTile(
                        travelerInfoModel: travelersInfoList[index],
                        onDataChanged: (updatedTraveler) {
                          travelersInfoList[index] =
                              updatedTraveler; // Update the list
                        },
                      );
                    },
                  ),
                  //? Contact Info
                  ContactInfoTile(
                    emailController: emailController,
                    phoneController: phoneController,
                    selectedCountry: selectedCountry,
                    onCountryChanged: onCountryChanged,
                  ),
                  BlocConsumer<BookingCubit, BookingState>(
                    listener: (context, state) {
                      if (state is BookingLoading) {
                        MyLogger.green('Booking in progress...');
                      } else if (state is BookingSuccess) {
                        successToast(
                          title: 'Success',
                          description: state.message,
                        ).show(context);
                        context.pushNamed(Routes.paymentScreen);
                      } else if (state is BookingFailure) {
                        errorToast(title: 'Error', description: state.error)
                            .show(context);
                      } else if (state is RefreshTokenExpired) {
                        errorToast(
                          title: 'Session Expired',
                          description: 'Please log in again.',
                        ).show(context);
                        getIt<AuthNavigationState>()
                            .setRedirectRoute(Routes.bookingScreen);
                        if (mounted) {
                          Navigator.of(context).pushNamed(Routes.logIn);
                        } else {
                          return;
                        }
                      }
                    },
                    builder: (context, state) {
                      return CustomRoundedButton(
                        deviceInfo: deviceInfo,
                        label: 'continue',
                        backgroundColor: AppColors.appBlue,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          submitForm();
                        },
                        textColor: AppColors.appLighterGrey,
                        isLoading: state is BookingLoading,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

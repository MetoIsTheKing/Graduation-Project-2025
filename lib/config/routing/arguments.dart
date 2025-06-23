import 'package:flutter/material.dart';

class SearchAirportArguments {
  final String appBarTitle;
  final TextEditingController fromController;
  final TextEditingController toController;
  final bool isOrigin;
  final void Function() onBack;

  SearchAirportArguments({
    required this.fromController,
    required this.toController,
    required this.appBarTitle,
    required this.isOrigin,
    required this.onBack,
  });
}

class AirportsDetails {
  Map<String, dynamic>? arrAirportsDetails;
  Map<String, dynamic>? depAirportsDetails;

  AirportsDetails({
    this.arrAirportsDetails,
    this.depAirportsDetails,
  });
}

import 'package:flutter/material.dart';

class FlightModel {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController travellersController = TextEditingController();
  final TextEditingController departureDateController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();
  DateTime? departureDate;
  DateTime? returnDate;
  final Map<String, int> travellers;
  String flightClass;
  FlightModel({
    this.departureDate,
    this.returnDate,
    this.travellers = const {
      'adults': 0,
      'children': 0,
      'infants': 0,
    },
    this.flightClass = 'economy',
  });
  void dispose() {
    fromController.dispose();
    toController.dispose();
    travellersController.dispose();
    departureDateController.dispose();
    returnDateController.dispose();
  }
}

import 'package:flutter/material.dart';

class FlightModel {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController travellersController = TextEditingController();
  final TextEditingController departureDateController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();
  DateTime? departureDate;
  DateTime? returnDate;
  final Map<String, int> travellers = {
    'adults': 1,
    'children': 0,
    'infants': 0,
  };
  String flightClass;
  FlightModel({
    this.departureDate,
    this.returnDate,
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

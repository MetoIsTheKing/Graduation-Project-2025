import 'package:flutter/material.dart';

class FlightModel {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController travellersController = TextEditingController();
  final TextEditingController departureDateController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();
  DateTime? departureDate;
  DateTime? returnDate;
  FlightModel({
    this.departureDate,
    this.returnDate,
  });
  void dispose() {
    fromController.dispose();
    toController.dispose();
    travellersController.dispose();
    departureDateController.dispose();
    returnDateController.dispose();
  }
}

import 'package:flutter/material.dart';

class FlightModel {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController travellersController =
      TextEditingController(text: '1 Traveller , Economy');
  final TextEditingController departureDateController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();

  DateTime? departureDate;
  DateTime? returnDate;

  // Changed from final to late - will be initialized in constructor
  late Map<String, int> travellers;

  String flightClass;

  FlightModel({
    this.departureDate,
    this.returnDate,
    this.flightClass = 'ECONOMY',
    Map<String, int>? travellers,
  }) {
    // Initialize travellers map from parameter or use defaults
    this.travellers = travellers != null
        ? Map<String, int>.from(
            travellers) // Create a copy to avoid reference issues
        : {
            'adults': 1,
            'children': 0,
            'infants': 0,
          };
  }

  void dispose() {
    fromController.dispose();
    toController.dispose();
    travellersController.dispose();
    departureDateController.dispose();
    returnDateController.dispose();
  }

  // Helper method to get all data as a map for API call
  Map<String, dynamic> toApiMap() {
    return {
      'from': fromController.text,
      'to': toController.text,
      'departureDate': departureDate?.toIso8601String(),
      'returnDate': returnDate?.toIso8601String(),
      'travellers': travellers,
      'flightClass': flightClass,
    };
  }

  // Create a copy of this model (useful for state management)
  FlightModel copyWith({
    DateTime? departureDate,
    DateTime? returnDate,
    String? flightClass,
    Map<String, int>? travellers,
  }) {
    return FlightModel(
      departureDate: departureDate ?? this.departureDate,
      returnDate: returnDate ?? this.returnDate,
      flightClass: flightClass ?? this.flightClass,
      travellers: travellers ?? Map<String, int>.from(this.travellers),
    );
  }
}

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
  bool nonStop = false;
  //int max
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

class FlightSearchQueryParams {
  String originLocationCode;
  String destinationLocationCode;
  String departureDate;
  String? returnDate;
  int adults;
  int children;
  int infants;
  String travelClass;
  bool nonStop;
  int max;
  String currencyCode;

  FlightSearchQueryParams([
    this.originLocationCode = '',
    this.destinationLocationCode = '',
    this.departureDate = '',
    this.returnDate = '',
    this.adults = 1,
    this.children = 0,
    this.infants = 0,
    this.travelClass = 'ECONOMY',
    this.nonStop = false,
    this.max = 10,
    this.currencyCode = 'USD',
  ]);

  Map<String, dynamic> toMap() {
    return {
      'originLocationCode': originLocationCode,
      'destinationLocationCode': destinationLocationCode,
      'departureDate': departureDate,
      if (returnDate != null || returnDate!.isNotEmpty)
        'returnDate': returnDate,
      'adults': adults,
      'children': children,
      'infants': infants,
      'travelClass': travelClass,
      'nonStop': nonStop,
      'max': max,
      'currencyCode': currencyCode,
    };
  }
}

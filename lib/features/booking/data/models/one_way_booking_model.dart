import 'dart:convert';

import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/shared_functions/mapping_airports_codes.dart';

import '../../../../core/helpers/my_logger.dart';
import '../../../home/explore/flights/data/models/flight_result_model.dart';
import 'booking_sub_models.dart';

/// Helper function to decode the JSON string and create a oneWayBookingModel object.
OneWayBookingModel oneWayBookingModelFromJson(String str) =>
    OneWayBookingModel.fromJson(json.decode(str));

/// Helper function to encode a oneWayBookingModel object to a JSON string.
String oneWayBookingModelToJson(OneWayBookingModel data) =>
    json.encode(data.toJson());

/// Main class representing the entire flight booking structure.
class OneWayBookingModel {
  String bookingType = "ONE_WAY";
  String flightId;
  int numberOfStops;
  String originAirportCode;
  String destinationAirportCode;
  String originCity;
  String destinationCity;
  DateTime departureDate;
  DateTime arrivalDate;
  BaggageOptionModel selectedBaggageOption;
  double totalPrice;
  String currency;
  List<TravellerInfoModel> travellersInfo;
  ContactDetailsModel contactDetails;

  OneWayBookingModel({
    required this.flightId,
    required this.numberOfStops,
    required this.originAirportCode,
    required this.destinationAirportCode,
    required this.originCity,
    required this.destinationCity,
    required this.departureDate,
    required this.arrivalDate,
    required this.selectedBaggageOption,
    required this.totalPrice,
    required this.currency,
    required this.travellersInfo,
    required this.contactDetails,
  });

  /// Factory constructor to create a oneWayBookingModel instance from a JSON map.
  factory OneWayBookingModel.fromJson(Map<String, dynamic> json) =>
      OneWayBookingModel(
        flightId: json["flightID"],
        numberOfStops: json["numberOfStops"],
        originAirportCode: json["originAirportCode"],
        destinationAirportCode: json["destinationAirportCode"],
        originCity: json["originCIty"],
        destinationCity: json["destinationCIty"],
        departureDate: DateTime.parse(json["departureDate"]),
        arrivalDate: DateTime.parse(json["arrivalDate"]),
        selectedBaggageOption:
            BaggageOptionModel.fromJson(json["selectedBaggageOption"]),
        totalPrice: (json["totalPrice"] as num).toDouble(),
        currency: json["currency"],
        travellersInfo: List<TravellerInfoModel>.from(
            json["travellersInfo"].map((x) => TravellerInfoModel.fromJson(x))),
        contactDetails: ContactDetailsModel.fromJson(json["contactDetails"]),
      );

  /// Converts the oneWayBookingModel instance to a JSON map.
  Map<String, dynamic> toJson() => {
        "bookingType": bookingType,
        "flightID": flightId,
        "numberOfStops": numberOfStops,
        "originAirportCode": originAirportCode,
        "destinationAirportCode": destinationAirportCode,
        "originCIty": originCity,
        "destinationCIty": destinationCity,
        "departureDate":
            "${departureDate.year.toString().padLeft(4, '0')}-${departureDate.month.toString().padLeft(2, '0')}-${departureDate.day.toString().padLeft(2, '0')}",
        "arrivalDate":
            "${arrivalDate.year.toString().padLeft(4, '0')}-${arrivalDate.month.toString().padLeft(2, '0')}-${arrivalDate.day.toString().padLeft(2, '0')}",
        "selectedBaggageOption": selectedBaggageOption.toJson(),
        "totalPrice": totalPrice,
        "currency": currency,
        "travellersInfo":
            List<dynamic>.from(travellersInfo.map((x) => x.toJson())),
        "contactDetails": contactDetails.toJson(),
      };

// --- MAPPING FUNCTION ---

  /// Maps a [FlightResultModel] to a [OneWayBookingModel].
  ///
  /// Requires the flight result, a list of traveler details, contact details,
  /// and the selected baggage option to create a complete booking model.
  static void mapFlightResultToOneWayBooking({
    required FlightResultModel flightResult,
    required BaggageOptionModel baggageOption,
    required double totalPrice,
  }) {
    // Ensure there is at least one itinerary to process.
    if (flightResult.itineraries.isEmpty ||
        flightResult.itineraries.first.segments.isEmpty) {
      throw ArgumentError(
          'FlightResultModel must contain at least one itinerary and one segment.');
    }

    final firstItinerary = flightResult.itineraries.first;
    final firstSegment = firstItinerary.segments.first;
    final lastSegment = firstItinerary.segments.last;

    // Calculate the number of stops. (e.g., 2 segments = 1 stop)
    final int numberOfStops = firstItinerary.segments.length - 1;

    // Extract departure and arrival information from the first and last segments.
    final String originAirportCode = firstSegment.departure.iataCode;
    final String destinationAirportCode = lastSegment.arrival.iataCode;
    final DateTime departureDate =
        DateTime.parse(firstSegment.departure.departureDateTime);
    final DateTime arrivalDate =
        DateTime.parse(lastSegment.arrival.arrivalDateTime);

    // Extract price information.
    final String currency = 'USD';

    final String originCity =
        getAirportDetails(originAirportCode)['city'] ?? originAirportCode;
    final String destinationCity =
        getAirportDetails(destinationAirportCode)['city'] ?? originAirportCode;

    getIt<OneWayBookingModel>().flightId = flightResult.flightId;
    getIt<OneWayBookingModel>().numberOfStops = numberOfStops;
    getIt<OneWayBookingModel>().originAirportCode = originAirportCode;
    getIt<OneWayBookingModel>().destinationAirportCode = destinationAirportCode;
    getIt<OneWayBookingModel>().originCity = originCity;
    getIt<OneWayBookingModel>().destinationCity = destinationCity;
    getIt<OneWayBookingModel>().departureDate = departureDate;
    getIt<OneWayBookingModel>().arrivalDate = arrivalDate;
    getIt<OneWayBookingModel>().selectedBaggageOption = baggageOption;
    getIt<OneWayBookingModel>().totalPrice = totalPrice;
    getIt<OneWayBookingModel>().currency = currency;
  }

  /// for logging purposes
  /// representation of the booking details.
  void printBookingDetails() {
    MyLogger.magenta(bookingType);
    MyLogger.magenta('Flight ID: $flightId');
    MyLogger.magenta('Number of Stops: $numberOfStops');
    MyLogger.magenta('Origin Airport Code: $originAirportCode');
    MyLogger.magenta('Destination Airport Code: $destinationAirportCode');
    MyLogger.magenta('Origin City: $originCity');
    MyLogger.magenta('Destination City: $destinationCity');
    MyLogger.magenta('Departure Date: $departureDate');
    MyLogger.magenta('Arrival Date: $arrivalDate');
    MyLogger.magenta('Selected Baggage Option:');
    MyLogger.magenta('\t Type: ${selectedBaggageOption.type}');
    MyLogger.magenta('\t Price: ${selectedBaggageOption.price}');
    MyLogger.magenta('\t Weight: ${selectedBaggageOption.weight}');

    MyLogger.magenta('Total Price: $totalPrice');
    MyLogger.magenta('Currency: $currency');
    MyLogger.magenta('Travellers Info: ');
    for (var traveller in travellersInfo) {
      MyLogger.magenta('\t Name: ${traveller.firstName}');
      MyLogger.magenta('\t Last Name: ${traveller.lastName}');
      MyLogger.magenta('\t \t birthDate: ${traveller.birthDate}');
      MyLogger.magenta('\t \t type: ${traveller.travelerType}');
      MyLogger.magenta('\t \t nationality: ${traveller.nationality}');
      MyLogger.magenta('\t \t passportNumber: ${traveller.passportNumber}');
      MyLogger.magenta('\t \t issuingCountry: ${traveller.issuingCountry}');
      MyLogger.magenta('\t \t expiryDate: ${traveller.expiryDate}');
    }
    MyLogger.magenta('Contact Details:');
    MyLogger.magenta('\t Email: ${contactDetails.email}');
    MyLogger.magenta('\t Phone: ${contactDetails.phone}');
  }
}

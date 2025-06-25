import 'dart:convert';

import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/shared_functions/mapping_airports_codes.dart';
import '../../../../core/helpers/my_logger.dart';
import '../../../home/explore/flights/data/models/flight_result_model.dart';
import 'booking_sub_models.dart';

/// Helper function to decode the JSON string and create a RoundTripBookingModel object.
RoundTripBookingModel roundTripBookingModelFromJson(String str) =>
    RoundTripBookingModel.fromJson(json.decode(str));

/// Helper function to encode a RoundTripBookingModel object to a JSON string.
String roundTripBookingModelToJson(RoundTripBookingModel data) =>
    json.encode(data.toJson());

/// Main class representing the entire round trip booking structure.
class RoundTripBookingModel {
  String bookingType = 'ROUND_TRIP';
  List<FlightDataModel> flightData;
  double totalPrice;
  String currency;
  List<TravellerInfoModel> travellersInfo;
  ContactDetailsModel contactDetails;

  RoundTripBookingModel({
    required this.flightData,
    required this.totalPrice,
    required this.currency,
    required this.travellersInfo,
    required this.contactDetails,
  });

  /// Factory constructor to create a RoundTripBookingModel instance from a JSON map.
  factory RoundTripBookingModel.fromJson(Map<String, dynamic> json) =>
      RoundTripBookingModel(
        flightData: List<FlightDataModel>.from(
            json["flightData"].map((x) => FlightDataModel.fromJson(x))),
        totalPrice: (json["totalPrice"] as num).toDouble(),
        currency: json["currency"],
        travellersInfo: List<TravellerInfoModel>.from(
            json["travellersInfo"].map((x) => TravellerInfoModel.fromJson(x))),
        contactDetails: ContactDetailsModel.fromJson(json["contactDetails"]),
      );

  /// Converts the RoundTripBookingModel instance to a JSON map.
  Map<String, dynamic> toJson() => {
        "bookingType": bookingType,
        "flightData": List<dynamic>.from(flightData.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "currency": currency,
        "travellersInfo":
            List<dynamic>.from(travellersInfo.map((x) => x.toJson())),
        "contactDetails": contactDetails.toJson(),
      };

  /// Maps a [FlightResultModel] to a [RoundTripBookingModel].
  ///
  /// Requires the flight result, a list of traveler details, contact details,
  /// and the selected baggage option to create a complete booking model.
  static void mapFlightResultToRoundTripBooking(
      {required FlightResultModel flightResult,
      required BaggageOptionModel baggageOption,
      required double totalPrice,
      required bool isSecondTrip}) {
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

    final index = isSecondTrip ? 1 : 0;
    // Create flight data for round trip booking
    getIt<RoundTripBookingModel>().flightData[index].flightId =
        flightResult.flightId;
    getIt<RoundTripBookingModel>().flightData[index].numberOfStops =
        numberOfStops;
    getIt<RoundTripBookingModel>().flightData[index].originAirportCode =
        originAirportCode;
    getIt<RoundTripBookingModel>().flightData[index].destinationAirportCode =
        destinationAirportCode;
    getIt<RoundTripBookingModel>().flightData[index].originCity = originCity;
    getIt<RoundTripBookingModel>().flightData[index].destinationCity =
        destinationCity;
    getIt<RoundTripBookingModel>().flightData[index].departureDate =
        departureDate;
    getIt<RoundTripBookingModel>().flightData[index].arrivalDate = arrivalDate;
    getIt<RoundTripBookingModel>().flightData[index].selectedBaggageOption =
        baggageOption;
    getIt<RoundTripBookingModel>().totalPrice = totalPrice;
    getIt<RoundTripBookingModel>().currency = currency;

    getIt<RoundTripBookingModel>().totalPrice += totalPrice;
    getIt<RoundTripBookingModel>().currency = currency;
  }

  /// for logging purposes
  /// representation of the booking details.
  void printBookingDetails() {
    MyLogger.magenta(bookingType);

    MyLogger.magenta('Flight Data:');
    for (int i = 0; i < flightData.length; i++) {
      final flight = flightData[i];
      MyLogger.magenta('\t Flight ${i + 1} (${flight.typeOfFlight}):');
      MyLogger.magenta('\t\t Flight ID: ${flight.flightId}');
      MyLogger.magenta('\t\t Number of Stops: ${flight.numberOfStops}');
      MyLogger.magenta('\t\t Origin Airport Code: ${flight.originAirportCode}');
      MyLogger.magenta(
          '\t\t Destination Airport Code: ${flight.destinationAirportCode}');
      MyLogger.magenta('\t\t Origin City: ${flight.originCity}');
      MyLogger.magenta('\t\t Destination City: ${flight.destinationCity}');
      MyLogger.magenta('\t\t Departure Date: ${flight.departureDate}');
      MyLogger.magenta('\t\t Arrival Date: ${flight.arrivalDate}');
      MyLogger.magenta('\t\t Selected Baggage Option:');
      MyLogger.magenta('\t\t\t Type: ${flight.selectedBaggageOption.type}');
      MyLogger.magenta('\t\t\t Price: ${flight.selectedBaggageOption.price}');
      MyLogger.magenta('\t\t\t Weight: ${flight.selectedBaggageOption.weight}');
    }

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

/// Represents the data for a single flight leg (either outgoing or return).
class FlightDataModel {
  String flightId;
  String typeOfFlight;
  int numberOfStops;
  String originAirportCode;
  String destinationAirportCode;
  String originCity;
  String destinationCity;
  DateTime departureDate;
  DateTime arrivalDate;
  BaggageOptionModel selectedBaggageOption;

  FlightDataModel({
    required this.flightId,
    required this.typeOfFlight,
    required this.numberOfStops,
    required this.originAirportCode,
    required this.destinationAirportCode,
    required this.originCity,
    required this.destinationCity,
    required this.departureDate,
    required this.arrivalDate,
    required this.selectedBaggageOption,
  });

  factory FlightDataModel.fromJson(Map<String, dynamic> json) =>
      FlightDataModel(
        flightId: json["flightID"],
        typeOfFlight: json["typeOfFlight"],
        numberOfStops: json["numberOfStops"],
        originAirportCode: json["originAirportCode"],
        destinationAirportCode: json["destinationAirportCode"],
        originCity: json["originCIty"],
        destinationCity: json["destinationCIty"],
        departureDate: DateTime.parse(json["departureDate"]),
        arrivalDate: DateTime.parse(json["arrivalDate"]),
        selectedBaggageOption:
            BaggageOptionModel.fromJson(json["selectedBaggageOption"]),
      );

  Map<String, dynamic> toJson() => {
        "flightID": flightId,
        "typeOfFlight": typeOfFlight,
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
      };
}

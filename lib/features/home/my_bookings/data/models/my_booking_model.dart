import 'dart:convert';

import 'package:graduation_project_2025/core/helpers/my_logger.dart';

// Function to decode a list of MyBookingsModel from a JSON string
List<MyBookingsModel> myBookingsModelFromJson(String str) =>
    List<MyBookingsModel>.from(
        json.decode(str).map((x) => MyBookingsModel.fromJson(x)));

// Function to encode a list of MyBookingsModel to a JSON string
String myBookingsModelToJson(List<MyBookingsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

/// Main model representing a single booking record.
/// It accommodates both ONE_WAY and ROUND_TRIP structures.
class MyBookingsModel {
  String id;
  String userId;
  String bookingType;
  double totalPrice;
  String currency;
  List<MyBookingsTravellersInfoModel> travellersInfo;
  MyBookingsContactDetailsModel contactDetails;
  String bookingRef;
  String status;
  String paymentStatus;
  List<MyBookingsFlightDataModel> flightData;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  // Fields specific to ONE_WAY trips (nullable)
  String? flightId;
  String? originAirportCode;
  String? destinationAirportCode;
  String? originCity;
  String? destinationCity;
  DateTime? departureDate;
  DateTime? arrivalDate;
  int? numberOfStops;
  MyBookingsSelectedBaggageOptionModel? selectedBaggageOption;

  MyBookingsModel({
    required this.id,
    required this.userId,
    required this.bookingType,
    required this.totalPrice,
    required this.currency,
    required this.travellersInfo,
    required this.contactDetails,
    required this.bookingRef,
    required this.status,
    required this.paymentStatus,
    required this.flightData,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    // Nullable one-way fields
    this.flightId,
    this.originAirportCode,
    this.destinationAirportCode,
    this.originCity,
    this.destinationCity,
    this.departureDate,
    this.arrivalDate,
    this.numberOfStops,
    this.selectedBaggageOption,
  });

  String get totalFlightDuration {
    Duration duration;
    if (bookingType == 'ROUND_TRIP') {
      if (flightData.isEmpty) {
        duration = Duration.zero;
      } else {
        // Using a for loop for robust null-safety analysis.
        Duration total = Duration.zero;
        for (final flight in flightData) {
          total += flight.arrivalDate.difference(flight.departureDate);
        }
        duration = total;
      }
    } else if (bookingType == 'ONE_WAY') {
      // For one-way, calculate the difference between the main arrival and departure dates.
      if (arrivalDate != null && departureDate != null) {
        duration = arrivalDate!.difference(departureDate!);
      } else {
        duration = Duration.zero;
      }
    } else {
      // Return zero duration if the type is unknown.
      duration = Duration.zero;
    }

    if (duration.inMinutes == 0) {
      return "0h 0m";
    }
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    final hoursString = hours > 0 ? '${hours}h' : '';
    final minutesString = minutes > 0 ? '${minutes}m' : '';

    // Join the parts with a space, filtering out empty strings.
    return [hoursString, minutesString].where((s) => s.isNotEmpty).join(' ');
  }

  /// Factory constructor to create a MyBookingsModel instance from a JSON map.
  factory MyBookingsModel.fromJson(Map<String, dynamic> json) =>
      MyBookingsModel(
        id: json["_id"],
        userId: json["userId"],
        bookingType: json["bookingType"],
        totalPrice: json["totalPrice"]?.toDouble(),
        currency: json["currency"],
        travellersInfo: List<MyBookingsTravellersInfoModel>.from(
            json["travellersInfo"]
                .map((x) => MyBookingsTravellersInfoModel.fromJson(x))),
        contactDetails:
            MyBookingsContactDetailsModel.fromJson(json["contactDetails"]),
        bookingRef: json["bookingRef"],
        status: json["status"],
        paymentStatus: json["paymentStatus"],
        flightData: List<MyBookingsFlightDataModel>.from(json["flightData"]
            .map((x) => MyBookingsFlightDataModel.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        // Conditionally parse one-way fields
        flightId: json["flightId"],
        originAirportCode: json["originAirportCode"],
        destinationAirportCode: json["destinationAirportCode"],
        originCity: json["originCity"],
        destinationCity: json["destinationCity"],
        departureDate: json["departureDate"] == null
            ? null
            : DateTime.parse(json["departureDate"]),
        arrivalDate: json["arrivalDate"] == null
            ? null
            : DateTime.parse(json["arrivalDate"]),
        numberOfStops: json["numberOfStops"],
        selectedBaggageOption: json["selectedBaggageOption"] == null
            ? null
            : MyBookingsSelectedBaggageOptionModel.fromJson(
                json["selectedBaggageOption"]),
      );

  /// Method to convert a MyBookingsModel instance to a JSON map.
  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "bookingType": bookingType,
        "totalPrice": totalPrice,
        "currency": currency,
        "travellersInfo":
            List<dynamic>.from(travellersInfo.map((x) => x.toJson())),
        "contactDetails": contactDetails.toJson(),
        "bookingRef": bookingRef,
        "status": status,
        "paymentStatus": paymentStatus,
        "flightData": List<dynamic>.from(flightData.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        // Conditionally include one-way fields if they are not null
        if (flightId != null) "flightId": flightId,
        if (originAirportCode != null) "originAirportCode": originAirportCode,
        if (destinationAirportCode != null)
          "destinationAirportCode": destinationAirportCode,
        if (originCity != null) "originCity": originCity,
        if (destinationCity != null) "destinationCity": destinationCity,
        if (departureDate != null)
          "departureDate": departureDate?.toIso8601String(),
        if (arrivalDate != null) "arrivalDate": arrivalDate?.toIso8601String(),
        if (numberOfStops != null) "numberOfStops": numberOfStops,
        if (selectedBaggageOption != null)
          "selectedBaggageOption": selectedBaggageOption?.toJson(),
      };
}

/// Represents the contact details for the booking.
class MyBookingsContactDetailsModel {
  String email;
  String phone;

  MyBookingsContactDetailsModel({
    required this.email,
    required this.phone,
  });

  factory MyBookingsContactDetailsModel.fromJson(Map<String, dynamic> json) =>
      MyBookingsContactDetailsModel(
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phone": phone,
      };
}

/// Represents the data for a single flight leg in a ROUND_TRIP booking.
class MyBookingsFlightDataModel {
  String flightId;
  String typeOfFlight;
  int numberOfStops;
  String originAirportCode;
  String destinationAirportCode;
  String originCity;
  String destinationCity;
  DateTime departureDate;
  DateTime arrivalDate;
  MyBookingsSelectedBaggageOptionModel selectedBaggageOption;

  MyBookingsFlightDataModel({
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

  factory MyBookingsFlightDataModel.fromJson(Map<String, dynamic> json) =>
      MyBookingsFlightDataModel(
        // Note: JSON has "flightID", model uses "flightId" for consistency
        flightId: json["flightID"],
        typeOfFlight: json["typeOfFlight"],
        numberOfStops: json["numberOfStops"],
        originAirportCode: json["originAirportCode"],
        destinationAirportCode: json["destinationAirportCode"],
        // Note: JSON has "originCIty" and "destinationCIty" (with typos)
        // We robustly check for both the correct and incorrect spellings.
        originCity: json["originCIty"] ?? json["originCity"],
        destinationCity: json["destinationCIty"] ?? json["destinationCity"],
        departureDate: DateTime.parse(json["departureDate"]),
        arrivalDate: DateTime.parse(json["arrivalDate"]),
        selectedBaggageOption: MyBookingsSelectedBaggageOptionModel.fromJson(
            json["selectedBaggageOption"]),
      );

  Map<String, dynamic> toJson() => {
        "flightID": flightId,
        "typeOfFlight": typeOfFlight,
        "numberOfStops": numberOfStops,
        "originAirportCode": originAirportCode,
        "destinationAirportCode": destinationAirportCode,
        "originCIty": originCity, // Writing back with the original key
        "destinationCIty":
            destinationCity, // Writing back with the original key
        "departureDate": departureDate.toIso8601String(),
        "arrivalDate": arrivalDate.toIso8601String(),
        "selectedBaggageOption": selectedBaggageOption.toJson(),
      };
}

/// Represents the selected baggage option.
class MyBookingsSelectedBaggageOptionModel {
  String type;
  String weight;
  num price; // Using num to handle both int and double

  MyBookingsSelectedBaggageOptionModel({
    required this.type,
    required this.weight,
    required this.price,
  });

  factory MyBookingsSelectedBaggageOptionModel.fromJson(
          Map<String, dynamic> json) =>
      MyBookingsSelectedBaggageOptionModel(
        type: json["type"],
        weight: json["weight"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "weight": weight,
        "price": price,
      };
}

/// Represents the information for a single traveller.
class MyBookingsTravellersInfoModel {
  String firstName;
  String lastName;
  String birthDate;
  String travelerType;
  String nationality;
  String passportNumber;
  String issuingCountry;
  String expiryDate;
  String seatNumber;
  DateTime seatAssignedAt;

  MyBookingsTravellersInfoModel({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.travelerType,
    required this.nationality,
    required this.passportNumber,
    required this.issuingCountry,
    required this.expiryDate,
    required this.seatNumber,
    required this.seatAssignedAt,
  });

  factory MyBookingsTravellersInfoModel.fromJson(Map<String, dynamic> json) =>
      MyBookingsTravellersInfoModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        birthDate: json["birthDate"],
        travelerType: json["travelerType"],
        nationality: json["nationality"],
        passportNumber: json["passportNumber"],
        issuingCountry: json["issuingCountry"],
        expiryDate: json["expiryDate"],
        seatNumber: json["seatNumber"],
        seatAssignedAt: DateTime.parse(json["seatAssignedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "birthDate": birthDate,
        "travelerType": travelerType,
        "nationality": nationality,
        "passportNumber": passportNumber,
        "issuingCountry": issuingCountry,
        "expiryDate": expiryDate,
        "seatNumber": seatNumber,
        "seatAssignedAt": seatAssignedAt.toIso8601String(),
      };
}

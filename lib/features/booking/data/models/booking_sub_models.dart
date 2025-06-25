/// Represents the selected baggage option.
class BaggageOptionModel {
  final String type;
  final String weight;
  final double price;

  BaggageOptionModel({
    required this.type,
    required this.weight,
    required this.price,
  });

  factory BaggageOptionModel.fromJson(Map<String, dynamic> json) =>
      BaggageOptionModel(
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

/// Represents the contact details for the booking.
class ContactDetailsModel {
  final String email;
  final String phone;

  ContactDetailsModel({
    required this.email,
    required this.phone,
  });

  factory ContactDetailsModel.fromJson(Map<String, dynamic> json) =>
      ContactDetailsModel(
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phone": phone,
      };
}

/// Represents the information for a single traveller.
class TravellerInfoModel {
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String travelerType;
  final String nationality;
  final String passportNumber;
  final String issuingCountry;
  final DateTime expiryDate;

  TravellerInfoModel({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.travelerType,
    required this.nationality,
    required this.passportNumber,
    required this.issuingCountry,
    required this.expiryDate,
  });

  factory TravellerInfoModel.fromJson(Map<String, dynamic> json) =>
      TravellerInfoModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        birthDate: DateTime.parse(json["birthDate"]),
        travelerType: json["travelerType"],
        nationality: json["nationality"],
        passportNumber: json["passportNumber"],
        issuingCountry: json["issuingCountry"],
        expiryDate: DateTime.parse(json["expiryDate"]),
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "birthDate":
            "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "travelerType": travelerType,
        "nationality": nationality,
        "passportNumber": passportNumber,
        "issuingCountry": issuingCountry,
        "expiryDate":
            "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
      };
}

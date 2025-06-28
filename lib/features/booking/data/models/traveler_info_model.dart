import 'package:graduation_project_2025/features/booking/data/models/booking_sub_models.dart';

class TravelerInfoUiModel {
  String travelerType;
  String firstName;
  String lastName;
  String birthDate;
  String nationality;
  String passportNumber;
  String passportExpiryDate;
  String issuingCountry;

  TravelerInfoUiModel({
    required this.travelerType,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.nationality,
    required this.passportNumber,
    required this.passportExpiryDate,
    required this.issuingCountry,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'nationality': nationality,
      'passportNumber': passportNumber,
      'passportExpiryDate': passportExpiryDate,
      'passportIssuanceCountry': issuingCountry,
    };
  }

  TravellerInfoModel toTravellerInfoModel() {
    return TravellerInfoModel(
      firstName: firstName,
      lastName: lastName,
      birthDate: DateTime.parse(birthDate),
      travelerType: travelerType,
      nationality: nationality,
      passportNumber: passportNumber,
      issuingCountry: issuingCountry,
      expiryDate: DateTime.parse(passportExpiryDate),
    );
  }

}

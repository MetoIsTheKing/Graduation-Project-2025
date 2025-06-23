class TravelerInfoModel {
  String travelerType;
  String fullName;
  String birthDate;
  String nationality;
  String passportNumber;
  String passportExpiryDate;
  String issuingCountry;

  TravelerInfoModel({
    required this.travelerType,
    required this.fullName,
    required this.birthDate,
    required this.nationality,
    required this.passportNumber,
    required this.passportExpiryDate,
    required this.issuingCountry,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'birthDate': birthDate,
      'nationality': nationality,
      'passportNumber': passportNumber,
      'passportExpiryDate': passportExpiryDate,
      'passportIssuanceCountry': issuingCountry,
    };
  }
}

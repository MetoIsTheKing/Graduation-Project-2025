class UserProfileModel {
  final bool success;
  final String message;
  final Profile user;

  UserProfileModel({
    required this.success,
    required this.message,
    required this.user,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      success: json['success'],
      message: json['data']['message'],
      user: Profile.fromJson(json['data']['user']),
    );
  }
}

class Profile {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String country;
  final String phoneNumber;
  final bool isVerified;
  final String birthdate;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.country,
    required this.phoneNumber,
    required this.isVerified,
    required this.birthdate,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      country: json['country'],
      phoneNumber: json['phoneNumber'],
      isVerified: json['isVerified'],
      birthdate: json['birthdate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'country': country,
      'birthdate': birthdate,
    };
  }
}

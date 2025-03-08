class UserModel {
  final bool success;
  final ResponseData data;

  UserModel({required this.success, required this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      success: json['success'],
      data: ResponseData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

class ResponseData {
  final String message;
  final User user;

  ResponseData({required this.message, required this.user});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      message: json['message'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user': user.toJson(),
    };
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String country;
  final String phoneNumber;
  final bool isVerified;
  final String birthdate;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.country,
    required this.phoneNumber,
    required this.isVerified,
    required this.birthdate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'country': country,
      'phoneNumber': phoneNumber,
      'isVerified': isVerified,
      'birthdate': birthdate,
    };
  }
}

class AirportModel {
  final String name;
  final String iataCode;
  final String cityName;
  final String countryName;

  AirportModel({
    required this.name,
    required this.iataCode,
    required this.cityName,
    required this.countryName,
  });

  factory AirportModel.fromJson(Map<String, dynamic> json) {
    try {
      // Extract address data - handles both nested and flat structures
      final address = json['address'] as Map<String, dynamic>? ?? {};
      
      return AirportModel(
        name: json['name']?.toString() ?? json['detailedName']?.toString() ?? 'Unknown',
        iataCode: json['iataCode']?.toString() ?? '',
        cityName: address['cityName']?.toString() ?? 'Unknown',
        countryName: address['countryName']?.toString() ?? 'Unknown',
      );
    } catch (e) {
      print('Error parsing airport JSON: $e');
      print('Problematic JSON: $json');
      throw FormatException('Invalid airport data: ${e.toString()}');
    }
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'iataCode': iataCode,
    'cityName': cityName,
    'countryName': countryName,
  };
}
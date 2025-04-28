import 'package:graduation_project_2025/core/network_clients/abstract_client.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/airport_model.dart';

abstract class SearchAirportsRemoteDataSource {
  Future<Map<String, dynamic>> searchAirports(String query);
}

class SearchAirportsRemoteDataSourceImpl
    implements SearchAirportsRemoteDataSource {
  final DioNetworkClient amadeusApiClient;
  SearchAirportsRemoteDataSourceImpl({required this.amadeusApiClient});

  @override
  Future<Map<String, dynamic>> searchAirports(String query) async {
  try {
    final response = await amadeusApiClient.get(
      'reference-data/locations',
      queryParameters: {
        'subType': 'AIRPORT',
        'keyword': query,
        'sort': "analytics.travelers.score",
        'page[limit]': 30,
        'page[offset]': 0,
        'view': 'LIGHT',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'] as List;
      final airportsList = data
          .map((json) {
            try {
              // Ensure we have a proper Map
              final jsonMap = json is Map<String, dynamic> 
                  ? json 
                  : Map<String, dynamic>.from(json as Map);
              return AirportModel.fromJson(jsonMap);
            } catch (e) {
              print('Error parsing airport: $e');
              return null;
            }
          })
          .whereType<AirportModel>()
          .toList();

      return {
        'statusCode': response.statusCode,
        'airports': airportsList.map((a) => a.toJson()).toList(),
      };
    } else {
      return {
        'statusCode': response.statusCode,
        'error': response.statusMessage ?? 'Unknown error',
      };
    }
  } catch (e, stackTrace) {
    print('Error in searchAirports: $e');
    print(stackTrace);
    return {
      'statusCode': 500,
      'error': e.toString(),
    };
  }
}
}

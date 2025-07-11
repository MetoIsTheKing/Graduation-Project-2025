import 'dart:developer';

import 'package:graduation_project_2025/core/network_clients/abstract_client.dart';
import 'package:graduation_project_2025/features/home/flights/data/models/airport_model.dart';
import 'package:graduation_project_2025/features/home/flights/data/models/flight_result_model.dart';

abstract class SearchFlightssRemoteDataSource {
  Future<Map<String, dynamic>> searchAirports(String query);
  Future<Map<String, dynamic>> searchFlights(Map<String, dynamic> query);
}

class SearchFlightssRemoteDataSourceImpl
    implements SearchFlightssRemoteDataSource {
  final DioNetworkClient amadeusApiClient;
  SearchFlightssRemoteDataSourceImpl({required this.amadeusApiClient});

  @override
  Future<Map<String, dynamic>> searchAirports(String query) async {
    try {
      final response = await amadeusApiClient.get(
        'v1/reference-data/locations',
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
          'airports': airportsList,
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

  @override
  Future<Map<String, dynamic>> searchFlights(Map<String, dynamic> query) async {
    try {
      final response = await amadeusApiClient.get(
        'v2/shopping/flight-offers',
        queryParameters: query,
      );

      if (response.statusCode == 200) {
        // Check if the data list is empty
        final List<dynamic> data = response.data['data'] as List? ?? [];

        if (data.isEmpty) {
          return {
            'statusCode': response.statusCode,
            'flights': <FlightResultModel>[], // Return empty list
          };
        }

        // Parse data into FlightResultModel objects
        final flightsList = data
            .map((json) {
              try {
                final jsonMap = json is Map<String, dynamic>
                    ? json
                    : Map<String, dynamic>.from(json as Map);

                return FlightResultModel.fromJson(jsonMap);
              } catch (e, stackTrace) {
                print('Error parsing flight: $e');
                log('this is stack : $stackTrace');
                return null;
              }
            })
            .whereType<FlightResultModel>() // Filter out null values
            .toList();
        return {
          'statusCode': response.statusCode,
          'flights': flightsList,
        };
      } else {
        return {
          'statusCode': response.statusCode,
          'error': response.statusMessage ?? 'Unknown error',
        };
      }
    } catch (e, stackTrace) {
      print('Error in searchFlights: $e');
      print(stackTrace);
      return {
        'statusCode': 500,
        'error': e.toString(),
      };
    }
  }
}

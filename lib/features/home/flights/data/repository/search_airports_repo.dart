import 'dart:developer';

import 'package:graduation_project_2025/features/home/flights/data/data_sources/search_flights_remote.dart';

class SearchFlightsRepo {
  final SearchFlightssRemoteDataSource remoteDataSource;

  SearchFlightsRepo({required this.remoteDataSource});

  Future<Map<String, dynamic>> searchAirports(String query) async {
    try {
      final response = await remoteDataSource.searchAirports(query);
      return response;
    } catch (e) {
      log('Error in SearchAirportsRepo: $e');
      return Future.error(e);
    }
  }

  Future<Map<String, dynamic>> searchFlights(Map<String, dynamic> query) async {
    try {
      final response = await remoteDataSource.searchFlights(query);
      return response;
    } catch (e) {
      log('Error in SearchFlightsRepo: $e');
      return Future.error(e);
    }
  }
}

import 'dart:developer';

import 'package:graduation_project_2025/features/home/explore/flights/data/data_sources/search_airports_remote.dart';

class SearchAirportsRepo {
  final SearchAirportsRemoteDataSource remoteDataSource;

  SearchAirportsRepo({required this.remoteDataSource});

  Future<Map<String, dynamic>> searchAirports(String query) async {
    try {
      final response = await remoteDataSource.searchAirports(query);
      return response;
    } catch (e) {
      log('Error in SearchAirportsRepo: $e');
      return Future.error(e);
    }
  }
}
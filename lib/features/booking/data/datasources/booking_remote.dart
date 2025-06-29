import 'package:graduation_project_2025/core/api/end_points.dart';

import '../../../../core/network_clients/abstract_client.dart';

abstract class BookingRemote {
  Future<Map<String, dynamic>> bookFlight(Map<String, dynamic> requestBody,
      {String? path});
}

class BookingRemoteImpl implements BookingRemote {
  final DioNetworkClient bookingClient;

  BookingRemoteImpl({required this.bookingClient});

  @override
  Future<Map<String, dynamic>> bookFlight(Map<String, dynamic> requestBody,
      {String? path}) async {
    try {
      final response = await bookingClient.post(
        EndPoints.bookFlight,
        data: requestBody,
        isProtected: true,
      );
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(e);
    }
  }
}

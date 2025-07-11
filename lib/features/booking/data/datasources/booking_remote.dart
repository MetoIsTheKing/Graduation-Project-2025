import 'package:dio/dio.dart';
import 'package:graduation_project_2025/core/api/end_points.dart';
import 'package:graduation_project_2025/core/helpers/my_logger.dart';

import '../../../../core/network_clients/abstract_client.dart';

abstract class BookingRemote {
  Future<Map<String, dynamic>> bookFlight(Map<String, dynamic> requestBody,
      {String? path});
  Future<Map<String, dynamic>> createPaymentIntent(
      Map<String, dynamic> requestBody);

  Future<Map<String, dynamic>> checkPaymentStatus(String bookingId);
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
    } on DioException catch (e, stackTrace) {
      // Catch DioException specifically
      // Check if the error type is a timeout
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        MyLogger.red('This is a connection timeout error: ${e.message}');
        // You can handle the timeout specifically here
      } else {
        // Handle other Dio exceptions (e.g., 404, 500)
        MyLogger.red('A non-timeout Dio error occurred: ${e.message}');
      }
      MyLogger.red(stackTrace.toString());
      return Future.error('Please try again later');
    } catch (e, stackTrace) {
      MyLogger.red(stackTrace.toString());
      return Future.error(e);
    }
  }

  // Create Payment intent
  @override
  Future<Map<String, dynamic>> createPaymentIntent(
      Map<String, dynamic> requestBody) async {
    try {
      final response = await bookingClient.post(
        EndPoints.createPaymentIntent,
        data: requestBody,
        isProtected: true,
      );
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } catch (e, stackTrace) {
      MyLogger.red(stackTrace.toString());
      return Future.error(e);
    }
  }

  // Check payment status
  @override
  Future<Map<String, dynamic>> checkPaymentStatus(String bookingId) async {
    try {
      final response = await bookingClient.get(
        '${EndPoints.checkPaymentStatus}$bookingId',
        isProtected: true,
      );
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } catch (e, stackTrace) {
      MyLogger.red(stackTrace.toString());
      return Future.error(e);
    }
  }
}

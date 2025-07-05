import 'package:graduation_project_2025/core/api/end_points.dart';
import 'package:graduation_project_2025/features/home/my_bookings/data/models/my_booking_model.dart';

import '../../../../../core/network_clients/abstract_client.dart';

abstract class MyBookingsRemote {
  Future<List<MyBookingsModel>> getMyBookings();
  Future<bool> cancelBooking(String bookingId);
}

class MyBookingsRemoteImpl implements MyBookingsRemote {
  final DioNetworkClient myBookingsClient;

  MyBookingsRemoteImpl({required this.myBookingsClient});
  @override
  Future<List<MyBookingsModel>> getMyBookings() async {
    var response =
        await myBookingsClient.get(EndPoints.getMyBookings, isProtected: true);
    if (response.statusCode == 200) {
      List<dynamic> data = response.data['data']['bookings'];
      return data.map((booking) => MyBookingsModel.fromJson(booking)).toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  @override
  Future<bool> cancelBooking(String bookingId) async {
    var response = await myBookingsClient.post(
      EndPoints.cancelBooking(bookingId),
      isProtected: true,
      data: {'reason': 'Change of plans'},
    );
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }
}

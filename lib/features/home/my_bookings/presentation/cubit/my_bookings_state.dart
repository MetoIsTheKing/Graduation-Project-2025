part of 'my_bookings_cubit.dart';

abstract class MyBookingsState {}

class MyBookingsInitial extends MyBookingsState {}

class MyBookingsLoading extends MyBookingsState {}

class MyBookingsLoaded extends MyBookingsState {
  final List<MyBookingsModel> bookings;

  MyBookingsLoaded(this.bookings);
}

class MyBookingCancelled extends MyBookingsState {
  final String message;
  MyBookingCancelled({this.message = "Booking cancelled successfully"});
}

class MyBookingFailedCancel extends MyBookingsState {
  final String message;
  MyBookingFailedCancel({this.message = "Failed To Cancel Booking"});
}

class MyBookingsError extends MyBookingsState {
  final String message;

  MyBookingsError(this.message);
}

class MyBookingsRefreshFailed extends MyBookingsState {
  final String message;

  MyBookingsRefreshFailed(this.message);
}

class MyBookingsNotLoggedIn extends MyBookingsState {}

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final String message;

  BookingSuccess(this.message);
}

class BookingFailure extends BookingState {
  final String error;

  BookingFailure(this.error);
}

class PaymentIntentLoading extends BookingState {}

class PaymentIntentSuccess extends BookingState {
  final String clientSecret;

  PaymentIntentSuccess(this.clientSecret);
}

class PaymentIntentFailure extends BookingState {
  final String error;

  PaymentIntentFailure(this.error);
}

class PaymentStatusLoading extends BookingState {}

class PaymentStatusSuccess extends BookingState {
  final String message;

  PaymentStatusSuccess(this.message);
}

class PaymentStatusFailure extends BookingState {
  final String error;

  PaymentStatusFailure(this.error);
}

class PaymentPollingInProgress extends BookingState {
  final String message;

  PaymentPollingInProgress(this.message);
}

class PaymentPollingFailure extends BookingState {
  final String error;

  PaymentPollingFailure(this.error);
}

class PaymentPollingSuccess extends BookingState {
  final String message;

  PaymentPollingSuccess(this.message);
}

class PaymentStripeInProgress extends BookingState {}

class RefreshTokenExpired extends BookingState {}

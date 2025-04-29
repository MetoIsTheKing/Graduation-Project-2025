part of 'flight_review_cubit.dart';

@immutable
sealed class FlightReviewState {}

final class FlightReviewInitial extends FlightReviewState {}

final class FlightReviewTextState extends FlightReviewState {}

part of 'flight_details_cubit.dart';

@immutable
sealed class FlightDetailsState {}

final class FlightDetailsInitial extends FlightDetailsState {}

final class BaggageSelectedState extends FlightDetailsState {}

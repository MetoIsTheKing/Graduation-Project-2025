part of 'search_flights_cubit.dart';


abstract class SearchFlightsState {}

class SearchFlightsInitial extends SearchFlightsState {}
class AirportsIsLoading extends SearchFlightsState {}
class AirportsOnNetworkError extends SearchFlightsState {}
class AirportsOnError extends SearchFlightsState {
  final String errorMessage;
  AirportsOnError({required this.errorMessage});
}
class AirportsLoaded extends SearchFlightsState {
  
  final List<AirportModel> airports;
  AirportsLoaded(  {
    required this.airports,
    });
}

part of 'search_flights_cubit.dart';


sealed class SearchFlightsState {}

class SearchFlightsInitial extends SearchFlightsState {}
class AirportsIsLoading extends SearchFlightsState {}
class AirportsOnNetworkError extends SearchFlightsState {
  final String errorMessage;
  AirportsOnNetworkError({required this.errorMessage});
}
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

// Flights
class FlightsIsLoading extends SearchFlightsState {}
class FlightsLoaded extends SearchFlightsState {
  final List<FlightResultModel> flights;
  FlightsLoaded({
    required this.flights,
  });
}
class FlightsOnError extends SearchFlightsState {
  final String errorMessage;
  FlightsOnError({required this.errorMessage});
}
class FlightsOnNetworkError extends SearchFlightsState {
  final String errorMessage;
  FlightsOnNetworkError({required this.errorMessage});
}

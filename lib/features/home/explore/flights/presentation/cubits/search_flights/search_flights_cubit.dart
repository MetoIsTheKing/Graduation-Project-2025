import 'package:bloc/bloc.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/airport_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_result_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/repository/search_airports_repo.dart';

part 'search_flights_state.dart';

class SearchFlightsCubit extends Cubit<SearchFlightsState> {
  final SearchFlightsRepo searchAirportsRepo;
  SearchFlightsCubit({required this.searchAirportsRepo})
      : super(SearchFlightsInitial()) {
    print('Cubit created!');
  }

  Future<void> searchAirports(String query) async {
    emit(AirportsIsLoading());
    try {
      final response = await searchAirportsRepo.searchAirports(query);
      if (response['statusCode'] == 200) {
        emit(AirportsLoaded(
          airports: response['airports'],
        ));
      } else {
        emit(AirportsOnNetworkError(errorMessage: 'Error fetching airports'));
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      emit(AirportsOnError(errorMessage: e.toString()));
    }
  }

  Future<void> searchFlights(Map<String, dynamic> query) async {
    emit(FlightsIsLoading());
    try {
      final response = await searchAirportsRepo.searchFlights(query);
      if (response['statusCode'] == 200) {
        emit(FlightsLoaded(
          flights: response['flights'],
        ));
      } else {
        emit(FlightsOnNetworkError(errorMessage: 'Error fetching flights'));
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      emit(FlightsOnError(errorMessage: e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/airport_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_result_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/repository/search_airports_repo.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_model.dart';

part 'search_flights_state.dart';

class SearchFlightsCubit extends Cubit<SearchFlightsState> {
  final SearchFlightsRepo searchAirportsRepo;
  SearchFlightsCubit({required this.searchAirportsRepo})
      : super(SearchFlightsInitial()) {
    print('Cubit created!');
  }

  List<FlightResultModel> _goFlights = [];
  List<FlightResultModel> _returnFlights = [];

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
        if (getIt<FlightSearchQueryParams>().isRoundTrip) {
          if (getIt<FlightSearchQueryParams>().goOrReturnIndicator == 0) {
            _goFlights = response['flights'] as List<FlightResultModel>;

            emit(FlightsGoLoaded(goFlights: _goFlights));
          } else {
            _returnFlights = response['flights'] as List<FlightResultModel>;

            emit(FlightsReturnLoaded(returnFlights: _returnFlights));
          }
        } else {
          _goFlights = response['flights'] as List<FlightResultModel>;
          emit(FlightsGoLoaded(
            goFlights: _goFlights,
          ));
        }
      } else {
        emit(FlightsOnNetworkError(errorMessage: 'Error fetching flights'));
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      emit(FlightsOnError(errorMessage: e.toString()));
    }
  }

  void toggleFlightList() {
    if (getIt<FlightSearchQueryParams>().goOrReturnIndicator == 0) {
      if (_goFlights.isNotEmpty) {
        emit(FlightsGoLoaded(goFlights: _goFlights));
      } else {
        emit(FlightsOnError(errorMessage: "No departure flights available"));
      }
    } else {
      if (_returnFlights.isNotEmpty) {
        emit(FlightsReturnLoaded(returnFlights: _returnFlights));
      } else {
        emit(FlightsOnError(errorMessage: "No return flights available"));
      }
    }
  }
}

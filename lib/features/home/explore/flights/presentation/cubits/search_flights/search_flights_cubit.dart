import 'package:bloc/bloc.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/airport_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/repository/search_airports_repo.dart';

part 'search_flights_state.dart';

class SearchFlightsCubit extends Cubit<SearchFlightsState> {
  final SearchAirportsRepo searchAirportsRepo;
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
        emit(AirportsOnError(errorMessage: 'Error fetching airports'));
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      emit(AirportsOnError(errorMessage: e.toString()));
    }
  }
}

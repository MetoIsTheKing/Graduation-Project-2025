import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/flights_data_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_model.dart';

class SearchAirportArguments {
  final FlightsDataCubit cubit;
  final String appBarTitle;
  final bool isOrigin;
  final FlightModel flightModel;
  final void Function() onBack;

  SearchAirportArguments({
    required this.cubit,
    required this.appBarTitle,
    required this.isOrigin,
    required this.flightModel,
    required this.onBack,
  });
}

class AirportsDetails{
  Map<String, dynamic>? arrAirportsDetails;
  Map<String, dynamic>? depAirportsDetails;

  AirportsDetails({
     this.arrAirportsDetails,
     this.depAirportsDetails,
  });
}
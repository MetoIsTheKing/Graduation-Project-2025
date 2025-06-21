import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_result_model.dart';

import '../../../../../../config/dependency_injection/di.dart';
import '../../../../../../config/routing/arguments.dart';
import 'package:graduation_project_2025/core/shared_functions/mapping_airlines_codes.dart';

class FlightReviewDataModel {
  final FlightResultModel flight;
  late final List<Segment> segments;
  late final String departureCode;
  late final String arrivalCode;
  // late final String departureCity;
  // late final String arrivalCity;
  late final String departureAirport;
  late final String arrivalAirport;
  late final String departureTerminal;
  late final String arrivalTerminal;
  late final String duration;
  late final String departureDateTime;
  late final String arrivalDateTime;
  late final String departureDate;
  late final String arrivalDate;
  late final String totalPrice;

  // Termianl
  // Baggage

  FlightReviewDataModel({
    required this.flight,
  }) {
    segments = flight.itineraries[0].segments;
    departureCode = flight.itineraries[0].segments[0].departure.iataCode;
    arrivalCode = flight.itineraries[0]
        .segments[flight.itineraries[0].segments.length - 1].arrival.iataCode;

    departureAirport =
        getIt<AirportsDetails>().arrAirportsDetails?['airportName'] ?? 'error';
    arrivalAirport =
        getIt<AirportsDetails>().depAirportsDetails?['airportName'] ?? 'error';
    departureTerminal =
        flight.itineraries[0].segments[0].departure.departureTerminal ?? 'N/A';
    arrivalTerminal = flight
            .itineraries[0]
            .segments[flight.itineraries[0].segments.length - 1]
            .arrival
            .arrivalTerminal ??
        'N/A';
    duration = flight.itineraries[0].totalFlightDuration
        .substring(2)
        .replaceAll("H", 'H ');
    departureDateTime = flight
        .itineraries[0].segments[0].departure.departureDateTime
        .substring(11, 16);
    arrivalDateTime = flight
        .itineraries[0]
        .segments[flight.itineraries[0].segments.length - 1]
        .arrival
        .arrivalDateTime
        .substring(11, 16);

    departureDate = flight
        .itineraries[0].segments[0].departure.departureDateTime
        .substring(0, 10);

    arrivalDate = flight
        .itineraries[0]
        .segments[flight.itineraries[0].segments.length - 1]
        .arrival
        .arrivalDateTime
        .substring(0, 10);

    totalPrice = flight.price.total;
  }
}

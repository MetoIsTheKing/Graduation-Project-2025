import 'package:graduation_project_2025/core/shared_functions/mapping_airports_codes.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_result_model.dart';

class FlightDetailsDataModel {
  final FlightResultModel flight;
  final bool isEconomy;
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
  late final String basicPrice;
  late final List<Amenity> amenities;

  // Termianl
  // Baggage

  FlightDetailsDataModel({
    required this.flight,
    required this.isEconomy,
  }) {
    segments = flight.itineraries[0].segments;
    departureCode = flight.itineraries[0].segments[0].departure.iataCode;
    arrivalCode = flight.itineraries[0]
        .segments[flight.itineraries[0].segments.length - 1].arrival.iataCode;

    departureAirport = getAirportDetails(departureCode)['name'] ?? 'error';
    arrivalAirport = getAirportDetails(arrivalCode)['name'] ?? 'error';
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

    basicPrice = flight.price.total;

    amenities = flight.travelerPricings[0].fareDetailsBySegment[0].amenities;
  }
}

List<List<Map<String, dynamic>>> baggageDetails = [
  [
    {
      'title': 'Basic Fare',
      'description': ['1 x Checked Bag (7kg)', '1 x Cabin Bag (23kg)'],
      'extra': 'No Extra price',
      'extraAmount': 0.0,
      'weight': '30kg',
    },
    {
      'title': 'Extra Bag Option',
      'description': ['2 x Checked Bag (23kg)', '1 x Cabin Bag (23kg)'],
      'extra': 'Extra Price',
      'extraAmount': 60.0,
      'weight': '69kg',
    },
    {
      'title': 'Premium Fare',
      'description': ['1 x Checked Bag (32kg)', '1 x Cabin Bag (23kg)'],
      'extra': 'Extra Price',
      'extraAmount': 85.0,
      'weight': '55kg',
    },
  ],
  [
    {
      'title': 'Standard Premium',
      'description': ['2 x Checked Bag (32kg)', '2 x Cabin Bag (10kg)'],
      'extra': 'No Extra Price',
      'extraAmount': 0.0,
      'weight': '84kg',
    },
    {
      'title': 'Extra Premium',
      'description': ['3 x Checked Bag (32kg)', '2 x Cabin Bag (10kg)'],
      'extra': 'Extra Price',
      'extraAmount': 100.0,
      'weight': '116kg',
    },
    {
      'title': 'Luxury Allowance',
      'description': [
        '2 x Checked Bag (32kg)',
        '1 x Oversized Bag (up to 158cm)',
        '2 x Extra Cabin Bag (10kg)'
      ],
      'extra': 'Extra Price',
      'extraAmount': 150.0,
      'weight': '84kg',
    },
  ]
];

import 'package:json_annotation/json_annotation.dart';

part 'flight_result_model.g.dart';

@JsonSerializable()
class FlightResultModel {
  @JsonKey(name: 'id')
  final String flightId;
  final int numberOfBookableSeats;
  final List<Itinerary> itineraries;
  final Price price;
  final List<TravellersInfo> travelerPricings;

  FlightResultModel(
      {required this.flightId,
      required this.price,  required this.travelerPricings,
      required this.numberOfBookableSeats,
      required this.itineraries});

  factory FlightResultModel.fromJson(Map<String, dynamic> json) =>
      _$FlightResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$FlightResultModelToJson(this);    
}

@JsonSerializable()
class Itinerary {
  @JsonKey(name: 'duration')
  final String totalFlightDuration;
  final List<Segment> segments;

  Itinerary({required this.totalFlightDuration, required this.segments});

  factory Itinerary.fromJson(Map<String, dynamic> json) =>
      _$ItineraryFromJson(json);
  Map<String, dynamic> toJson() => _$ItineraryToJson(this);
}

@JsonSerializable()
class Segment {
  final Departure departure;
  final Arrival arrival;
  final String carrierCode;
  @JsonKey(name: 'duration')
  final String segmentDuration;

  Segment(
      {required this.departure,
      required this.arrival,
      required this.carrierCode,
      required this.segmentDuration});

  factory Segment.fromJson(Map<String, dynamic> json) =>
      _$SegmentFromJson(json);
  Map<String, dynamic> toJson() => _$SegmentToJson(this);    
}

@JsonSerializable()
class Departure {
  final String iataCode;
  @JsonKey(defaultValue: 'N/A', name: 'terminal')
  final String? departureTerminal;
  @JsonKey(name: 'at')
  final String departureDateTime;

  Departure(
      {required this.iataCode,
      required this.departureTerminal,
      required this.departureDateTime});

  factory Departure.fromJson(Map<String, dynamic> json) =>
      _$DepartureFromJson(json);
  Map<String, dynamic> toJson() => _$DepartureToJson(this);    
}

@JsonSerializable()
class Arrival {
  final String iataCode;
  @JsonKey(defaultValue: 'N/A', name: 'terminal')
  final String? arrivalTerminal;
  @JsonKey(name: 'at')
  final String arrivalDateTime;

  Arrival(
      {required this.iataCode,
      required this.arrivalTerminal,
      required this.arrivalDateTime});
  
  factory Arrival.fromJson(Map<String, dynamic> json) =>
      _$ArrivalFromJson(json);
  Map<String, dynamic> toJson() => _$ArrivalToJson(this);
}

@JsonSerializable()
class Price {
  final String currency;
  @JsonKey(fromJson: _valueToString)
  final String total;
  @JsonKey(fromJson: _valueToString)
  final String base;

  Price({required this.currency, required this.total, required this.base});

  static String _valueToString(dynamic value) {
    if (value == null) return 'N/A';
    return value.toString();
  }

  factory Price.fromJson(Map<String, dynamic> json) =>
      _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class TravellersInfo {
  @JsonKey(defaultValue: 'N/A')
  final String travelerId;
  @JsonKey(defaultValue: 'N/A')
  final String travelerType;
  final TravelerCost price;
  final List<FareDetailsBySegment> fareDetailsBySegment;

  TravellersInfo(
      {required this.travelerId,
      required this.travelerType,
      required this.price,
      required this.fareDetailsBySegment});

  factory TravellersInfo.fromJson(Map<String, dynamic> json) =>
      _$TravellersInfoFromJson(json);
  Map<String, dynamic> toJson() => _$TravellersInfoToJson(this);    
}

@JsonSerializable()
class FareDetailsBySegment {
  final String segmentId;
  final IncludedCheckedBags? includedCheckedBags;
  final IncludedCabinBags? includedCabinBags;
  @JsonKey(defaultValue: [])
  final List<Amenity> amenities;

  FareDetailsBySegment(
      {required this.segmentId,
      this.includedCheckedBags,
      this.includedCabinBags,
      required this.amenities});

  factory FareDetailsBySegment.fromJson(Map<String, dynamic> json) =>
      _$FareDetailsBySegmentFromJson(json);
  Map<String, dynamic> toJson() => _$FareDetailsBySegmentToJson(this);    
}

@JsonSerializable()
class Amenity {
  @JsonKey(defaultValue: 'N/A')
  final String description;
  final bool isChargeable;

  Amenity({required this.description, required this.isChargeable});

  factory Amenity.fromJson(Map<String, dynamic> json) =>
      _$AmenityFromJson(json);
  Map<String, dynamic> toJson() => _$AmenityToJson(this);
}

@JsonSerializable()
class IncludedCabinBags {
  @JsonKey(defaultValue: 'N/A')
  final dynamic weight;

  IncludedCabinBags({required this.weight});

  factory IncludedCabinBags.fromJson(Map<String, dynamic> json) =>
      _$IncludedCabinBagsFromJson(json);
  Map<String, dynamic> toJson() => _$IncludedCabinBagsToJson(this);
}

@JsonSerializable()
class IncludedCheckedBags {
  @JsonKey(defaultValue: 'N/A')
  final dynamic weight;

  IncludedCheckedBags({required this.weight});

  factory IncludedCheckedBags.fromJson(Map<String, dynamic> json) =>
      _$IncludedCheckedBagsFromJson(json);
  Map<String, dynamic> toJson() => _$IncludedCheckedBagsToJson(this);
}

@JsonSerializable()
class TravelerCost {
  @JsonKey(fromJson: _valueToString)
  final String total;
  @JsonKey(fromJson: _valueToString)
  final String base;

  TravelerCost({required this.total, required this.base});
  
  static String _valueToString(dynamic value) {
    if (value == null) return 'N/A';
    return value.toString();
  }

  factory TravelerCost.fromJson(Map<String, dynamic> json) =>
      _$TravelerCostFromJson(json);
  Map<String, dynamic> toJson() => _$TravelerCostToJson(this);
}

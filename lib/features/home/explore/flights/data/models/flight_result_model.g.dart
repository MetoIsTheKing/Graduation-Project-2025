// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightResultModel _$FlightResultModelFromJson(Map<String, dynamic> json) =>
    FlightResultModel(
      flightId: (json['id'] as num).toInt(),
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      travelerPricings: (json['travelerPricings'] as List<dynamic>)
          .map((e) => TravellersInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfBookableSeats: (json['numberOfBookableSeats'] as num).toInt(),
      itineraries: (json['itineraries'] as List<dynamic>)
          .map((e) => Itinerary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FlightResultModelToJson(FlightResultModel instance) =>
    <String, dynamic>{
      'id': instance.flightId,
      'numberOfBookableSeats': instance.numberOfBookableSeats,
      'itineraries': instance.itineraries,
      'price': instance.price,
      'travelerPricings': instance.travelerPricings,
    };

Itinerary _$ItineraryFromJson(Map<String, dynamic> json) => Itinerary(
      totalFlightDuration: json['duration'] as String,
      segments: (json['segments'] as List<dynamic>)
          .map((e) => Segment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItineraryToJson(Itinerary instance) => <String, dynamic>{
      'duration': instance.totalFlightDuration,
      'segments': instance.segments,
    };

Segment _$SegmentFromJson(Map<String, dynamic> json) => Segment(
      departure: Departure.fromJson(json['departure'] as Map<String, dynamic>),
      arrival: Arrival.fromJson(json['arrival'] as Map<String, dynamic>),
      segmentDuration: json['duration'] as String,
    );

Map<String, dynamic> _$SegmentToJson(Segment instance) => <String, dynamic>{
      'departure': instance.departure,
      'arrival': instance.arrival,
      'duration': instance.segmentDuration,
    };

Departure _$DepartureFromJson(Map<String, dynamic> json) => Departure(
      iataCode: json['iataCode'] as String,
      departureTerminal: json['terminal'] as String? ?? 'N/A',
      departureDateTime: json['at'] as String,
    );

Map<String, dynamic> _$DepartureToJson(Departure instance) => <String, dynamic>{
      'iataCode': instance.iataCode,
      'terminal': instance.departureTerminal,
      'at': instance.departureDateTime,
    };

Arrival _$ArrivalFromJson(Map<String, dynamic> json) => Arrival(
      iataCode: json['iataCode'] as String,
      arrivalTerminal: json['terminal'] as String? ?? 'N/A',
      arrivalDateTime: json['at'] as String,
    );

Map<String, dynamic> _$ArrivalToJson(Arrival instance) => <String, dynamic>{
      'iataCode': instance.iataCode,
      'terminal': instance.arrivalTerminal,
      'at': instance.arrivalDateTime,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      currency: json['currency'] as String,
      total: (json['total'] as num).toDouble(),
      base: (json['base'] as num).toDouble(),
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'currency': instance.currency,
      'total': instance.total,
      'base': instance.base,
    };

TravellersInfo _$TravellersInfoFromJson(Map<String, dynamic> json) =>
    TravellersInfo(
      travelerId: json['travelerId'] as String,
      travelerType: json['travelerType'] as String,
      price: TravelerCost.fromJson(json['price'] as Map<String, dynamic>),
      fareDetailsBySegment: (json['fareDetailsBySegment'] as List<dynamic>)
          .map((e) => FareDetailsBySegment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TravellersInfoToJson(TravellersInfo instance) =>
    <String, dynamic>{
      'travelerId': instance.travelerId,
      'travelerType': instance.travelerType,
      'price': instance.price,
      'fareDetailsBySegment': instance.fareDetailsBySegment,
    };

FareDetailsBySegment _$FareDetailsBySegmentFromJson(
        Map<String, dynamic> json) =>
    FareDetailsBySegment(
      segmentId: json['segmentId'] as String,
      includedCheckedBags: json['includedCheckedBags'] == null
          ? null
          : IncludedCheckedBags.fromJson(
              json['includedCheckedBags'] as Map<String, dynamic>),
      includedCabinBags: json['includedCabinBags'] == null
          ? null
          : IncludedCabinBags.fromJson(
              json['includedCabinBags'] as Map<String, dynamic>),
      amenities: (json['amenities'] as List<dynamic>)
          .map((e) => Amenity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FareDetailsBySegmentToJson(
        FareDetailsBySegment instance) =>
    <String, dynamic>{
      'segmentId': instance.segmentId,
      'includedCheckedBags': instance.includedCheckedBags,
      'includedCabinBags': instance.includedCabinBags,
      'amenities': instance.amenities,
    };

Amenity _$AmenityFromJson(Map<String, dynamic> json) => Amenity(
      description: json['description'] as String,
      isChargeable: json['isChargeable'] as bool,
    );

Map<String, dynamic> _$AmenityToJson(Amenity instance) => <String, dynamic>{
      'description': instance.description,
      'isChargeable': instance.isChargeable,
    };

IncludedCabinBags _$IncludedCabinBagsFromJson(Map<String, dynamic> json) =>
    IncludedCabinBags(
      weight: json['weight'] as String,
    );

Map<String, dynamic> _$IncludedCabinBagsToJson(IncludedCabinBags instance) =>
    <String, dynamic>{
      'weight': instance.weight,
    };

IncludedCheckedBags _$IncludedCheckedBagsFromJson(Map<String, dynamic> json) =>
    IncludedCheckedBags(
      weight: json['weight'] as String,
    );

Map<String, dynamic> _$IncludedCheckedBagsToJson(
        IncludedCheckedBags instance) =>
    <String, dynamic>{
      'weight': instance.weight,
    };

TravelerCost _$TravelerCostFromJson(Map<String, dynamic> json) => TravelerCost(
      total: json['total'] as String,
      base: json['base'] as String,
    );

Map<String, dynamic> _$TravelerCostToJson(TravelerCost instance) =>
    <String, dynamic>{
      'total': instance.total,
      'base': instance.base,
    };

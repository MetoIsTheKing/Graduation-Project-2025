//? this is the entity used in the ui
import 'package:graduation_project_2025/core/helpers/my_logger.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_result_model.dart';

class MessageModel {
  bool isUserMessage;
  String content;
  bool isSearchFlights;
  bool isLoading;
  bool isError;
  List<FlightResultModel>? flights;

  MessageModel({
    required this.isUserMessage,
    required this.content,
    this.isSearchFlights = false,
    this.isLoading = false,
    this.isError = false,
    this.flights,
  });

  // Factory method to create a MessageModel from a MessageResponse
  factory MessageModel.fromResponse(dynamic rawResponse) {
    try {
      // If the raw response is already a MessageResponse, use it directly
      if (rawResponse is MessageResponse) {
        // Check if there are flights to show - distinguish between null and empty list
        bool attemptedFlightSearch = rawResponse.flights != null;
        bool hasValidFlights =
            attemptedFlightSearch && rawResponse.flights!.isNotEmpty;

        // Always show the original message from the API
        String responseMessage = rawResponse.message;

        return MessageModel(
          isUserMessage:
              false, // Responses are always from the bot, not the user
          content: responseMessage,
          isSearchFlights:
              hasValidFlights, // Only true if we have valid flights
          flights: hasValidFlights ? rawResponse.flights : null,
          isError:
              !rawResponse.success, // If success is false, consider it an error
        );
      }

      // If it's a Map, try to convert it to a MessageResponse
      else if (rawResponse is Map<String, dynamic>) {
        MyLogger.green('Converting raw Map to MessageResponse');
        try {
          final response = MessageResponse.fromJson(rawResponse);
          return MessageModel.fromResponse(response);
        } catch (e) {
          MyLogger.red('Error converting Map to MessageResponse: $e');
          return MessageModel.error('Please resend your request again');
        }
      }

      // If it's neither MessageResponse nor Map, return an error
      else {
        MyLogger.red('Unexpected response type: ${rawResponse.runtimeType}');
        return MessageModel.error('Please resend your request again');
      }
    } catch (e) {
      MyLogger.red('Error in MessageModel.fromResponse: $e');
      return MessageModel.error('Please resend your request again');
    }
  }

  // Helper method to create a loading message
  static MessageModel loading() {
    return MessageModel(
      isUserMessage: false,
      content: "Processing your request...",
      isLoading: true,
    );
  }

  // Helper method to create an error message
  static MessageModel error(String errorMessage) {
    return MessageModel(
      isUserMessage: false,
      content: errorMessage.isNotEmpty
          ? errorMessage
          : "Sorry, something went wrong. Please try again.",
      isError: true,
    );
  }
}

//^ response from the server
class MessageResponse {
  final bool success;
  final String message;
  final bool login;
  final List<FlightResultModel>? flights;

  MessageResponse({
    required this.success,
    required this.message,
    required this.login,
    required this.flights,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    // Helper method to deeply sanitize flight data maps, replacing nulls with empty strings
    void sanitizeFlightData(
        Map<String, dynamic> target, Map<String, dynamic> source) {
      source.forEach((key, value) {
        if (value == null) {
          target[key] = '';
        } else if (value is Map) {
          // Handle nested maps
          Map<String, dynamic> nestedMap = {};
          sanitizeFlightData(nestedMap, Map<String, dynamic>.from(value));
          target[key] = nestedMap;
        } else if (value is List) {
          // Handle lists
          List<dynamic> sanitizedList = [];
          for (var item in value) {
            if (item == null) {
              sanitizedList.add('');
            } else if (item is Map) {
              Map<String, dynamic> nestedMap = {};
              sanitizeFlightData(nestedMap, Map<String, dynamic>.from(item));
              sanitizedList.add(nestedMap);
            } else {
              sanitizedList.add(item);
            }
          }
          target[key] = sanitizedList;
        } else {
          target[key] = value;
        }
      });
    }

    List<FlightResultModel>? parseFlights() {
      try {
        // First check if we need to look in a nested response object
        Map<String, dynamic> dataSource = json;
        if (json.containsKey('response') &&
            json['response'] is Map<String, dynamic>) {
          dataSource = json['response'];
        }

        MyLogger.green('Parsing flights from JSON: ${dataSource['data']}');

        // Check if 'data' key exists and handle different possible structures
        final data = dataSource['data'];

        // If data is null, return empty list immediately
        if (data == null) {
          MyLogger.yellow('No data field found in response');
          return [];
        }

        // Try to parse flights regardless of format, with robust error handling
        try {
          // Case 1: data is already a List
          if (data is List) {
            MyLogger.green(
                'Data is a List with ${data.length} items, parsing directly');

            List<FlightResultModel> results = [];
            for (var item in data) {
              if (item is! Map) continue;

              try {
                // Sanitize the flight data to prevent null values causing cast exceptions
                Map<String, dynamic> safeFlightData = {};
                Map<String, dynamic> rawFlightData =
                    Map<String, dynamic>.from(item);

                // Process all keys in the data, replacing nulls with empty strings
                sanitizeFlightData(safeFlightData, rawFlightData);

                // Only try to parse if we have data
                if (safeFlightData.isNotEmpty) {
                  results.add(FlightResultModel.fromJson(safeFlightData));
                }
              } catch (e) {
                MyLogger.red('Skipping invalid flight item: $e');
                // Continue to next item instead of failing completely
              }
            }

            // Only return if we successfully parsed at least one flight
            if (results.isNotEmpty) {
              return results;
            }

            // If all parsing failed, return empty list
            MyLogger.red('Failed to parse any flights from list');
            return [];
          }

          // Case 2: data is a Map with a nested 'data' key
          if (data is Map) {
            if (data.containsKey('data')) {
              final nestedData = data['data'];
              MyLogger.green('Found nested data: $nestedData');

              if (nestedData is List) {
                List<FlightResultModel> results = [];
                for (var item in nestedData) {
                  if (item is! Map) continue;

                  try {
                    // Sanitize the flight data to prevent null values causing cast exceptions
                    Map<String, dynamic> safeFlightData = {};
                    Map<String, dynamic> rawFlightData =
                        Map<String, dynamic>.from(item);

                    // Process all keys in the data, replacing nulls with empty strings
                    sanitizeFlightData(safeFlightData, rawFlightData);

                    // Only try to parse if we have data
                    if (safeFlightData.isNotEmpty) {
                      results.add(FlightResultModel.fromJson(safeFlightData));
                    }
                  } catch (e) {
                    MyLogger.red('Skipping invalid nested flight item: $e');
                    // Continue to next flight
                  }
                }

                if (results.isNotEmpty) {
                  return results;
                }
                return []; // Return empty list if no valid flights
              }
            } else {
              // Try to parse data as a single flight
              MyLogger.green('Trying to parse data Map as a single flight');
              try {
                // Sanitize the flight data to prevent null values causing cast exceptions
                Map<String, dynamic> safeFlightData = {};
                Map<String, dynamic> rawFlightData =
                    Map<String, dynamic>.from(data);

                // Process all keys in the data, replacing nulls with empty strings
                sanitizeFlightData(safeFlightData, rawFlightData);

                // Only try to parse if we have data
                if (safeFlightData.isNotEmpty) {
                  final flight = FlightResultModel.fromJson(safeFlightData);
                  return [flight];
                }
              } catch (e) {
                MyLogger.red('Map does not match flight format: $e');
              }
            }
          }

          // Case 3: data is in another format we didn't anticipate
          MyLogger.yellow('Data format not recognized: ${data.runtimeType}');
          return []; // Return empty list when format not recognized
        } catch (e) {
          MyLogger.red('All flight parsing attempts failed: $e');
          return []; // Return empty list instead of null when parsing fails
        }
      } catch (e) {
        MyLogger.red('Error parsing flights list: $e');
        return [];
      }
    }

    // Debug the JSON structure
    MyLogger.green('Parsing MessageResponse from JSON: $json');

    // Check if we have a nested 'response' object as in your example
    Map<String, dynamic> responseData = json;
    if (json.containsKey('response') &&
        json['response'] is Map<String, dynamic>) {
      MyLogger.green('Found nested response object, extracting data from it');
      responseData = json['response'];
    }

    // Safely get values with fallbacks
    final bool success = responseData['success'] ?? false;
    final bool login = responseData['login'] ?? false;

    // Handle message differently since it's crucial
    String message;
    if (responseData['message'] != null) {
      message = responseData['message'].toString();
      MyLogger.green('Found message: $message');
    } else {
      MyLogger.yellow('No message found in response, using default');
      message = 'Please resend your request again';
    }

    // Parse flights and create response
    final flightsList = parseFlights();
    MyLogger.green('Parsed flights: ${flightsList?.length ?? 0} found');

    // Log when flight parsing fails but don't change the original message
    if (flightsList != null && flightsList.isEmpty) {
      MyLogger.yellow('Flights parsing attempted but returned empty list');
    }

    return MessageResponse(
      success: success,
      message: message, // Keep the original message from the API
      login: login,
      flights: flightsList != null && flightsList.isEmpty
          ? null
          : flightsList, // Set flights to null if empty list
    );
  }
}

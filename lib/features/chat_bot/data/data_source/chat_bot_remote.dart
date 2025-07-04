import 'package:graduation_project_2025/core/helpers/my_logger.dart';
import 'package:graduation_project_2025/core/network_clients/abstract_client.dart';
import 'package:graduation_project_2025/features/chat_bot/data/message_model.dart';

class ChatBotRemoteDataSource {
  final DioNetworkClient client;

  ChatBotRemoteDataSource(this.client);

  Future<MessageModel> sendMessage(Map<String, dynamic> requestBody) async {
    try {
      MyLogger.green('Sending message to chatbot REMOTE: $requestBody');
      final response =
          await client.post("chat", data: requestBody, isProtected: false);

      MyLogger.green(
          'Response from chatbot REMOTE - Status: ${response.statusCode}');
      MyLogger.green('Response from chatbot REMOTE - Data: ${response.data}');

      // Enhanced logging for response structure to help debugging
      if (response.data is Map) {
        MyLogger.green(
            'Response is a Map with keys: ${(response.data as Map).keys.toList()}');

        // Check for nested response structure
        if (response.data.containsKey('response')) {
          final nestedResponse = response.data['response'];
          if (nestedResponse is Map) {
            MyLogger.green(
                'Found nested response with keys: ${(nestedResponse).keys.toList()}');

            // Check for data field specifically
            if (nestedResponse.containsKey('data')) {
              final data = nestedResponse['data'];
              MyLogger.green('Data type: ${data?.runtimeType}');
              if (data is List) {
                MyLogger.green('Data is a list with ${data.length} items');
                // Log first item structure if available
                if (data.isNotEmpty && data[0] is Map) {
                  MyLogger.green(
                      'First item keys: ${(data[0] as Map).keys.toList()}');
                }
              } else if (data is Map) {
                MyLogger.green(
                    'Data is a map with keys: ${data.keys.toList()}');
              }
            }
          }
        }

        // Direct data field check
        if (response.data.containsKey('data')) {
          final data = response.data['data'];
          MyLogger.green('Direct data type: ${data?.runtimeType}');
        }
      } else {
        MyLogger.yellow(
            'Response is not a Map, type: ${response.data.runtimeType}');
      }

      if (response.data == null) {
        MyLogger.red('No data received from chatbot');
        return MessageModel.error('No flights found');
      } else if (response.statusCode != 200) {
        MyLogger.red('Error from chatbot: ${response.statusCode}');
        return MessageModel.error('Please resend your request again');
      }

      try {
        // Try to parse the response data with enhanced error handling
        final messageModel = MessageModel.fromResponse(response.data);

        // Log if flights were found
        if (messageModel.flights != null && messageModel.flights!.isNotEmpty) {
          MyLogger.green(
              'Successfully parsed ${messageModel.flights!.length} flights');
        }

        return messageModel;
      } catch (parseError) {
        MyLogger.red('Failed to parse chatbot response: $parseError');

        // Try to extract and preserve the original message if possible
        String originalMessage = 'Please resend your request again';
        try {
          if (response.data is Map) {
            if (response.data['message'] != null) {
              originalMessage = response.data['message'].toString();
            } else if (response.data['response'] is Map &&
                response.data['response']['message'] != null) {
              originalMessage = response.data['response']['message'].toString();
            }
          }
        } catch (e) {
          MyLogger.red('Could not extract original message: $e');
        }

        return MessageModel(
          isUserMessage: false,
          content: originalMessage,
          isError: true,
        );
      }
    } catch (e) {
      MyLogger.red('Error sending message to chatbot: $e');
      // Network error case - use a generic message
      return MessageModel.error('Network error. Please try again later.');
    }
  }
}

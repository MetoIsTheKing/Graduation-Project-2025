// part 'chat_bot_state.dart'
import 'package:graduation_project_2025/features/chat_bot/data/message_model.dart';

abstract class ChatBotState {
  final List<MessageModel> messages;
  
  ChatBotState({required this.messages});
}

class ChatBotInitial extends ChatBotState {
  // ignore: use_super_parameters
  ChatBotInitial({required List<MessageModel> messages}) : super(messages: messages);
}

class ChatBotLoading extends ChatBotState {
  // ignore: use_super_parameters
  ChatBotLoading({required List<MessageModel> messages}) : super(messages: messages);
}

class ChatBotSuccess extends ChatBotState {
  final MessageModel latestMessage;
  
  // ignore: use_super_parameters
  ChatBotSuccess({required List<MessageModel> messages, required this.latestMessage}) 
      : super(messages: messages);
}

class ChatBotError extends ChatBotState {
  final MessageModel errorMessage;
  
  // ignore: use_super_parameters
  ChatBotError({required List<MessageModel> messages, required this.errorMessage}) 
      : super(messages: messages);
}
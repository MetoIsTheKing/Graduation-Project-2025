import 'package:bloc/bloc.dart';
import 'package:graduation_project_2025/features/chat_bot/data/data_source/chat_bot_remote.dart';
import 'package:graduation_project_2025/features/chat_bot/data/message_model.dart';
import 'package:graduation_project_2025/features/chat_bot/presentation/cubit/chat_bot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  final ChatBotRemoteDataSource chatBotSource;
  
  // Initialize with a welcome message
  ChatBotCubit(this.chatBotSource) 
      : super(ChatBotInitial(messages: [
          MessageModel(
            isUserMessage: false, 
            content: "Hello! How can I help you today?"
          )
        ]));

  // Private list to store all messages
  List<MessageModel> _messages = [
    MessageModel(
      isUserMessage: false, 
      content: "Hello! How can I help you today?"
    )
  ];
  
  // Getter for messages
  List<MessageModel> get messages => _messages;

  // Send a new message
  void sendMessage(String userMessage, {Map<String, dynamic>? additionalParams}) async {
    // Add user message to the list
    final userMessageModel = MessageModel(
      isUserMessage: true,
      content: userMessage,
    );
    _addMessage(userMessageModel);
    
    // Add loading indicator
    final loadingMessage = MessageModel.loading();
    _addMessage(loadingMessage);
    
    // Prepare request body
    final requestBody = {
      'message': userMessage,
      ...?additionalParams,
    };
    
    // Make API call
    try {
      final response = await chatBotSource.sendMessage(requestBody);
      
      // Remove the loading message
      _removeLoadingMessage();
      
      // Add bot response to the list
      _addMessage(response);
      
      emit(ChatBotSuccess(messages: _messages, latestMessage: response));
    } catch (e) {
      // Remove the loading message
      _removeLoadingMessage();
      
      // Add error message
      final errorMessage = MessageModel.error(e.toString());
      _addMessage(errorMessage);
      
      emit(ChatBotError(messages: _messages, errorMessage: errorMessage));
    }
  }
  
  // Helper method to add a message and emit state
  void _addMessage(MessageModel message) {
    _messages = List.from(_messages)..add(message);
    emit(ChatBotLoading(messages: _messages));
  }
  
  // Helper method to remove loading messages
  void _removeLoadingMessage() {
    _messages = _messages.where((message) => !message.isLoading).toList();
  }
  
  // Clear the chat history except for the welcome message
  void clearChat() {
    _messages = [
      MessageModel(
        isUserMessage: false, 
        content: "Hello! How can I help you today?"
      )
    ];
    emit(ChatBotInitial(messages: _messages));
  }
}
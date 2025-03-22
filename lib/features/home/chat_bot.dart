import 'package:flutter/material.dart';

class ChatBot extends StatelessWidget {
  final ScrollController scrollController;
  const ChatBot({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Chat Bot'),
      ),
    );
  }
}

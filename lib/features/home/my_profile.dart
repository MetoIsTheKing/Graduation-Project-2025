import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  final ScrollController scrollController;
  const MyProfile({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('My Profile'),
      ),
    );
  }
}
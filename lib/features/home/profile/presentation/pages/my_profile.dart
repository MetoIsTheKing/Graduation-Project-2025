import 'package:flutter/material.dart';

import '../widgets/my_profile_body.dart';

class MyProfile extends StatelessWidget {
  final ScrollController scrollController;
  const MyProfile({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return MyProfileBody();
  }
}

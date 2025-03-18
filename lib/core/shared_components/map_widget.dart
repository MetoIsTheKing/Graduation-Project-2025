import 'package:flutter/material.dart';

class MapWidget extends StatelessWidget {
  final double topPadding;
  final double imageHeight;
  const MapWidget({
    super.key, required this.topPadding, required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Image.asset('assets/images/global_map.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: imageHeight),
    );
  }
}
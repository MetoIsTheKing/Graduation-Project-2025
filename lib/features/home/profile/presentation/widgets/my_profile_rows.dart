import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildMenuRow({
  required String title,
  String? icon,
  Widget? iconWidget,
  required var deviceInfo,
  VoidCallback? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 25),
    child: Row(
      children: [
        iconWidget ?? SvgPicture.asset(icon!),
        SizedBox(width: 10),
        Text(title),
        const Spacer(),
        InkWell(
          onTap: onTap,
          child: SvgPicture.asset("assets/images/Shevron right.svg"),
        ),
      ],
    ),
  );
}

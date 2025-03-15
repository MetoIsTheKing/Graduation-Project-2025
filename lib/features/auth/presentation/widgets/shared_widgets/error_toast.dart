import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

CherryToast errorToast({required String title, required String description}) {
  return CherryToast.error(
      title: Text(title, style: TextStyle(color: Colors.black)),
      animationCurve: Curves.easeInOutCubic,
      description: Text(description, style: TextStyle(color: Colors.black)),
      animationType: AnimationType.fromRight,
      animationDuration: Duration(milliseconds: 200),
      autoDismiss: true);
}
CherryToast successToast({required String title, required String description}) {
  return CherryToast.success(
      title: Text(title, style: TextStyle(color: Colors.black)),
      animationCurve: Curves.easeInOutCubic,
      description: Text(description, style: TextStyle(color: Colors.black)),
      animationType: AnimationType.fromRight,
      animationDuration: Duration(milliseconds: 200),
      autoDismiss: true);
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccessibilityProvider extends ChangeNotifier {
  bool enabled = true;
  String key = '';
  final FirebaseFirestore firestore;

  AccessibilityProvider({required this.firestore});

  set activeWidget(String newActive) {
    key = newActive;
    notifyListeners();
  }
}

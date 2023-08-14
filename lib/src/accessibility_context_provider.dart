import 'package:accessibility_provider/src/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccessibilityContextProvider extends StatelessWidget {
  final FirebaseFirestore firestore;
  final Widget? child;
  const AccessibilityContextProvider({
    super.key,
    required this.firestore,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AccessibilityProvider(firestore: firestore),
      child: child,
    );
  }
}

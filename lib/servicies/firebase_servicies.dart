import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> initializeFirebase(BuildContext context) async {
  try {
    await Firebase.initializeApp();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Firebase initialized successfully!'
          ),
        ),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error initializing Firebase: $e')
        ),
      );
    }
  }
}








import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

bool _isFirebaseInitialized = false;

Future<void> initializeFirebase(BuildContext context) async {

  if (_isFirebaseInitialized) return;
  try {
    await Firebase.initializeApp();
    _isFirebaseInitialized = true;

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



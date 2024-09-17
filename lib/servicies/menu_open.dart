import 'package:flutter/material.dart';

void menuOpen(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Menu'),
          ),
          body: Row(
            children: [
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => true);
              }, child: const Text('To the main page'),
              ),
              const Padding(padding: EdgeInsets.only(left: 15)),
              const Text('New menu')
            ],
          ),
        );
      },
    ),
  );
}
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.cyan[100],
        title: const Text('To do list',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const Text('Main screen',
          style: TextStyle(
            color: Colors.white,
          ),),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/todo');
              },
              child: const Text('Move further')),
        ],
      ),
    );
  }
}
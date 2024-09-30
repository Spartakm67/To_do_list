import 'package:flutter/material.dart';
import 'package:flutter_todo/routes/routes.dart';
import 'package:flutter_todo/servicies/servicies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // scaffoldMessengerKey: scaffoldMessengerKey,
        theme: ThemeData(
          primaryColor: Colors.deepOrangeAccent,
        ),
        initialRoute: '/',
        routes: AppRoutes.getRoutes(),
        builder: (context, child) {
          initializeFirebase(context);
          return child ?? Container();
       },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/home.dart';
import 'package:flutter_todo/pages/main_screen.dart';


class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => const MainScreen(),
      '/todo': (context) => const Home(),
    };
  }
}
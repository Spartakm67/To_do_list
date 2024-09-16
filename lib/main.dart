import 'package:flutter/material.dart';
import 'package:flutter_todo/routes/routes.dart';


void main() => runApp(MaterialApp(

  theme: ThemeData(
    primaryColor: Colors.deepOrangeAccent,
  ),
  initialRoute:  '/',
  routes: AppRoutes.getRoutes(),
));



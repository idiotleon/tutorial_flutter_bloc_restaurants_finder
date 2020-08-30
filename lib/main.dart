import 'package:flutter/material.dart';
import 'ui/main_screen.dart';

void main() => runApp(RestaurantFind());

class RestaurantFind extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Finder',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc_favorite.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc_location.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc_provider.dart';
import 'ui/screen_main.dart';

void main() => runApp(RestaurantFind());

class RestaurantFind extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BloCProvider<LocationBloC>(
      bloc: LocationBloC(),
      child: BloCProvider<FavoriteBloC>(
        bloc: FavoriteBloC(),
        child: MaterialApp(
          title: 'Restaurant Finder',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: MainScreen(),
        ),
      ),
    );
  }
}

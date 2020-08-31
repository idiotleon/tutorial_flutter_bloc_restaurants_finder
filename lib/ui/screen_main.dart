import 'package:flutter/material.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc_location.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc_provider.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/data_layers/location.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/ui/screen_restaurant.dart';

import 'screen_location.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Location>(
      stream: BloCProvider.of<LocationBloC>(context).locationStream,
      builder: (context, snapshot) {
        final location = snapshot.data;

        if (location == null) {
          return LocationScreen();
        }

        return RestaurantScreen(location: location);
      },
    );
  }
}

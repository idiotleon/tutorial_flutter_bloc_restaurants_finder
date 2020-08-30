import 'dart:async';

import '../data_layers/location.dart';

import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/data_layers/restaurant.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/data_layers/zomato_client.dart';

class RestaurantBloC implements BloC {
  final Location location;
  final _client = ZomatoClient();
  final _controller = StreamController<List<Restaurant>>();

  Stream<List<Restaurant>> get stream => _controller.stream;
  RestaurantBloC(this.location);

  void submitQuery(String query) async {
    final results = await _client.fetchRestaurants(location, query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
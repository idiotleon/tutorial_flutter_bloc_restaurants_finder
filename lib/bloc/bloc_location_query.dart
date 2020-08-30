import 'dart:async';

import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/data_layers/location.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/data_layers/zomato_client.dart';

class LocationQueryBloC implements BloC {
  final _controller = StreamController<List<Location>>();
  final _client = ZomatoClient();

  Stream<List<Location>> get locationStream => _controller.stream;

  void submitQuery(String query) async {
    final results = await _client.fetchLocations(query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}

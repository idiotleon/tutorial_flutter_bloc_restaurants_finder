import 'dart:async';

import 'package:tutorial_bloc_restaurants/bloc/bloc.dart';
import 'package:tutorial_bloc_restaurants/data_layers/location.dart';
import 'package:tutorial_bloc_restaurants/data_layers/zomato_client.dart';

class LocationQueryBloc implements BloC {
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

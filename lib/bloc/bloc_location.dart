import 'dart:async';

import 'package:tutorial_bloc_restaurants/bloc/bloc.dart';
import 'package:tutorial_bloc_restaurants/data_layers/location.dart';

class LocationBloc implements BloC {
  Location _location;
  Location get selectedLocation => _location;

  final _locationController = StreamController<Location>();

  Stream<Location> get locationStream => _locationController.stream;

  void selectLocation(Location location) {
    _location = location;
    _locationController.sink.add(location);
  }

  @override
  void dispose() {
    _locationController.close();
  }
}

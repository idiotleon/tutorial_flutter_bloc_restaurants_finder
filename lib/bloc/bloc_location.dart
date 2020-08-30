import 'dart:async';

import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/data_layers/location.dart';

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

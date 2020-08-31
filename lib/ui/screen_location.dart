import 'package:flutter/material.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc_location.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc_location_query.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc_provider.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/data_layers/location.dart';

class LocationScreen extends StatelessWidget {
  final bool isFullScreenDialog;

  const LocationScreen({Key key, this.isFullScreenDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = LocationQueryBloC();

    return BloCProvider<LocationQueryBloC>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Where do you want to eat?')),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter a location'),
                onChanged: (query) => bloc.submitQuery(query),
              ),
            ),
            Expanded(
              child: _buildResults(bloc),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(LocationQueryBloC bloc) {
    return StreamBuilder<List<Location>>(
        stream: bloc.locationStream,
        builder: (context, snapshot) {
          final results = snapshot.data;

          if (results == null) {
            return Center(child: Text('Enter a location'));
          }

          if (results.isEmpty) {
            return Center(child: Text('No Results'));
          }

          return _buildSearchResults(results);
        });
  }

  Widget _buildSearchResults(List<Location> results) {
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        final location = results[index];
        return ListTile(
            title: Text(location.title),
            onTap: () {
              final locationBloC = BloCProvider.of<LocationBloC>(context);
              locationBloC.selectLocation(location);

              if (isFullScreenDialog) {
                Navigator.of(context).pop();
              }
            });
      },
    );
  }
}

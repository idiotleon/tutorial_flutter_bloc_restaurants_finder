import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc_provider.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/restaurant_bloc.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/data_layers/location.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/data_layers/restaurant.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/ui/screen_favorite.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/ui/screen_location.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/ui/tile_restaurant.dart';

class RestaurantScreen extends StatelessWidget {
  final Location location;

  const RestaurantScreen({Key key, @required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => FavoriteScreen())),
          ),
        ],
      ),
      body: _buildSearch(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit_location),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LocationScreen(
                  isFullScreenDialog: true,
                ),
            fullscreenDialog: true)),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    final bloc = RestaurantBloC(location);

    return BloCProvider<RestaurantBloC>(
      bloc: bloc,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What do you want to eat?'),
              onChanged: (query) => bloc.submitQuery(query),
            ),
          ),
          Expanded(
            child: _buildStreamBuilder(bloc),
          )
        ],
      ),
    );
  }

  Widget _buildStreamBuilder(RestaurantBloC bloc) {
    return StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          final results = snapshot.data;

          if (results == null) {
            return Center(
                child: Text('Enter a restaurant name or cuisine type'));
          }

          if (results.isEmpty) {
            return Center(child: Text('No Results'));
          }

          return _buildSearchResults(results);
        });
  }

  Widget _buildSearchResults(List<Restaurant> results) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final restaurant = results[index];
        return RestaurantTile(restaurant: restaurant);
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: results.length,
    );
  }
}

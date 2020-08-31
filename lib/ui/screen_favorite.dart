import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc_provider.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc_favorite.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/data_layers/restaurant.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/ui/tile_restaurant.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BloCProvider.of<FavoriteBloC>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: StreamBuilder<List<Restaurant>>(
          stream: bloc.favoritesStream,
          initialData: bloc.favorites,
          builder: (context, snapshot) {
            List<Restaurant> favorites =
                (snapshot.connectionState == ConnectionState.waiting)
                    ? bloc.favorites
                    : snapshot.data;

            if (favorites == null || favorites.isEmpty) {
              return Center(child: Text('No Favorites'));
            }

            return ListView.separated(
                itemBuilder: (context, index) {
                  final restaurant = favorites[index];
                  return RestaurantTile(restaurant: restaurant);
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: favorites.length);
          }),
    );
  }
}

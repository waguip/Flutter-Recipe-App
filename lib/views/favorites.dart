import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/recipe_model.dart';
import 'package:flutter_application_1/repositories/favorites_repository.dart';
import 'package:flutter_application_1/views/recipe_details.dart';
import 'package:flutter_application_1/views/widgets/recipe_card.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late FavoritesRepository favoritesRep;

  @override
  Widget build(BuildContext context) {
    favoritesRep = context.watch<FavoritesRepository>();

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, _) => [appBar()],
        body: ListView(
          children: [
            favorites(),
          ],
        ),
      ),
    );
  }

  SliverAppBar appBar() {
    return const SliverAppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star),
          SizedBox(width: 10),
          Text('Receitas Favoritas',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      snap: true,
      floating: true,
    );
  }

  seeRecipeDetails(BuildContext context, RecipeModel recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetails(recipe: recipe),
      ),
    );
  }

  Column favorites() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Consumer<FavoritesRepository>(
            builder: (context, favorites, child) {
              return favorites.favRecipes.isEmpty
                  ? const Text('Ainda não existem receitas favoritas')
                  : ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: RecipeCard(
                            title: favorites.favRecipes[index].name,
                            rating: favorites.favRecipes[index].rating.toInt(),
                            imageUrl: 'nao',
                            favorited: true,
                          ),
                          onTap: () => seeRecipeDetails(
                              context, favorites.favRecipes[index]),
                          onLongPress: () {
                            favoritesRep.remove(favorites.favRecipes[index]);
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 25),
                      itemCount: favorites.favRecipes.length,
                    );
            },
          ),
        ),
      ],
    );
  }
}

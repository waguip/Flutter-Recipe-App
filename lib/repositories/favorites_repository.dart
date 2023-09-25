import 'package:flutter_application_1/models/recipe_model.dart';

class FavoritesRepository {
  static List<RecipeModel> getFavRecipes() {
    List<RecipeModel> favRecipes = [];

    favRecipes.add(RecipeModel(
      name: 'Receita A',
      image: 'a',
      rating: 2,
      time: 10,
      ingredients: 'aaa',
      steps: 'bbb',
    ));

    favRecipes.add(RecipeModel(
      name: 'Receita B',
      image: 'a',
      rating: 3,
      time: 10,
      ingredients: 'aaa',
      steps: 'bbb',
    ));

    return favRecipes;
  }
}

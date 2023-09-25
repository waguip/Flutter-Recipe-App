import '../models/recipe_model.dart';

class RecipeRepository {
  static List<RecipeModel> getRecipes() {
    List<RecipeModel> recipes = [];

    recipes.add(RecipeModel(
      name: 'Receita A',
      image: 'a',
      rating: 2,
      time: 10,
      ingredients: 'aaa',
      steps: 'bbb',
    ));

    recipes.add(RecipeModel(
      name: 'Receita B',
      image: 'a',
      rating: 3,
      time: 10,
      ingredients: 'aaa',
      steps: 'bbb',
    ));

    return recipes;
  }
}

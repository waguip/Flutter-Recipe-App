import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/recipe_model.dart';

class FavoritesRepository extends ChangeNotifier {
  final List<RecipeModel> _favRecipes = [];

  UnmodifiableListView<RecipeModel> get favRecipes =>
      UnmodifiableListView(_favRecipes);

  save(RecipeModel recipe) {
    if (!_favRecipes.contains(recipe)) _favRecipes.add(recipe);
    notifyListeners();
  }

  saveAll(List<RecipeModel> recipes) {
    for (var recipe in recipes) {
      if (!_favRecipes.contains(recipe)) _favRecipes.add(recipe);
    }
    notifyListeners();
  }

  remove(RecipeModel recipe) {
    _favRecipes.remove(recipe);
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/db.dart';
import 'package:sqflite/sqlite_api.dart';
import '../models/recipe_model.dart';
import 'package:http/http.dart' as http;

class RecipeRepository extends ChangeNotifier {
  List<RecipeModel> _recipesTable = [];

  List<RecipeModel> get recipeTable => _recipesTable;

  RecipeRepository() {
    _setupRecipeTable();
    _setupDataRecipeTable();
    _readRecipeTable();
  }

  _setupRecipeTable() async {
    const String table = '''
      CREATE TABLE IF NOT EXISTS recipe (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        image TEXT,
        rating REAL,
        time TEXT,
        ingredients TEXT,
        steps TEXT
      );
    ''';
    Database db = DB.instance.database;
    await db.execute(table);
  }

  _setupDataRecipeTable() async {
    if (await _recipesTableIsEmpty()) {
      Uri uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
          {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

      final response = await http.get(uri, headers: {
        "x-rapidapi-key": "828f2dd24dmshb55d4148d3f6819p19518ejsn2b485e6035ac",
        "x-rapidapi-host": "yummly2.p.rapidapi.com",
        "useQueryString": "true"
      });

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> recipes = json['feed'];
        Database db = await DB.instance.database;
        Batch batch = db.batch();

        recipes.forEach((recipe) {
          final ingredients =
              ingredientslist(recipe['content']['ingredientLines']);

          batch.insert('recipe', {
            'name': recipe['content']['details']['name'],
            'image': recipe['content']['details']['images'][0]
                ['hostedLargeUrl'],
            'rating': recipe['content']['details']['rating'],
            'time': recipe['content']['details']['totalTime'],
            'ingredients': ingredients,
            'steps': recipe['content']['preparationSteps'].join("\n"),
          });
        });

        await batch.commit(noResult: true);
      }
    }
  }

  _recipesTableIsEmpty() async {
    Database db = await DB.instance.database;
    List results = await db.query('recipe');
    return results.isEmpty;
  }

  String ingredientslist(List<dynamic> list) {
    String ingredients = "";
    list.forEach((ingredient) {
      ingredients += ingredient['wholeLine'] + ', ';
    });
    return ingredients;
  }

  _readRecipeTable() async {
    Database db = await DB.instance.database;
    List results = await db.query('recipe');

    _recipesTable = results.map((e) {
      return RecipeModel(
        name: e['name'],
        image: e['image'],
        rating: e['rating'],
        time: e['time'],
        ingredients: e['ingredients'],
        steps: e['steps'],
      );
    }).toList();

    notifyListeners();
  }
}

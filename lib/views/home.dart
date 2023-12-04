import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category_model.dart';
import 'package:flutter_application_1/repositories/category_repository.dart';
import 'package:flutter_application_1/repositories/favorites_repository.dart';
import 'package:flutter_application_1/repositories/recipe_repository.dart';
import 'package:flutter_application_1/views/recipe_details.dart';
import 'package:flutter_application_1/views/widgets/recipe_card.dart';
import 'package:provider/provider.dart';
import '../models/recipe_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<RecipeModel> recipeTable = [];
  late RecipeModel dayRecipeTemp;

  @override
  void initState() {
    super.initState();
  }

  late RecipeRepository recipesRep;
  late FavoritesRepository favoritesRep;
  late CategoryRepository categoriesRep;

  @override
  Widget build(BuildContext context) {
    recipesRep = context.watch<RecipeRepository>();
    favoritesRep = context.watch<FavoritesRepository>();
    categoriesRep = context.watch<CategoryRepository>();

    recipeTable = recipesRep.recipeTable;
    categories = categoriesRep.categories;

    if (recipeTable.isNotEmpty) {
      dayRecipeTemp = recipeTable[Random().nextInt(recipeTable.length - 1)];
    } else {
      dayRecipeTemp = RecipeModel(
        name: 'a',
        image: 'a',
        rating: 2,
        time: 'a',
        ingredients: 'a',
        steps: 'a',
      );
    }

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, _) => [appBar()],
        body: ListView(
          children: [
            dayRecipe(context),
            categoriesSection(),
            recipeTableColumn(),
          ],
        ),
      ),
    );
  }

  Column recipeTableColumn() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Top Receitas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  bool favorited = false;
                  if (favoritesRep.favRecipes.contains(recipeTable[index])) {
                    favorited = true;
                  }
                  return GestureDetector(
                    child: RecipeCard(
                      title: recipeTable[index].name,
                      rating: recipeTable[index].rating,
                      imageUrl: recipeTable[index].image,
                      favorited: favorited,
                    ),
                    onTap: () => seeRecipeDetails(context, recipeTable[index]),
                    onLongPress: () {
                      if (favorited) {
                        removeFavorite(recipeTable[index]);
                      } else {
                        saveFavorite(recipeTable[index]);
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 25),
                itemCount: recipeTable.length,
              ),
            ],
          ),
        ),
      ],
    );
  }

  saveFavorite(RecipeModel recipe) {
    setState(() {
      favoritesRep.save(recipe);
    });
  }

  removeFavorite(RecipeModel recipe) {
    setState(() {
      favoritesRep.remove(recipe);
    });
  }

  seeRecipeDetails(BuildContext context, RecipeModel recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetails(recipe: recipe),
      ),
    );
  }

  Padding dayRecipe(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Receita recomendada',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            child: RecipeCard(
              title: dayRecipeTemp.name,
              rating: dayRecipeTemp.rating,
              imageUrl: dayRecipeTemp.image,
              favorited: false,
            ),
            onTap: () => seeRecipeDetails(context, dayRecipeTemp),
            onLongPress: () {
              favoritesRep.save(dayRecipeTemp);
            },
          ),
        ],
      ),
    );
  }

  Column categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Categorias',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            padding: const EdgeInsets.only(left: 20),
            separatorBuilder: (context, index) => const SizedBox(width: 25),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => searchByCategory(categories[index]),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(categories[index].categoryImage),
                        fit: BoxFit.cover,
                        opacity: 0.6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(categories[index].iconImage),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                      ),
                      Text(
                        categories[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

searchByCategory(CategoryModel category) {
  print(category.tag);
}

SliverAppBar appBar() {
  return const SliverAppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.restaurant),
        SizedBox(width: 10),
        Text('Receitas', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
    snap: true,
    floating: true,
  );
}

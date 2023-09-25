import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category_model.dart';
import 'package:flutter_application_1/repositories/category_repository.dart';
import 'package:flutter_application_1/repositories/favorites_repository.dart';
import 'package:flutter_application_1/views/recipe_details.dart';
import 'package:flutter_application_1/views/widgets/recipe_card.dart';
import '../models/recipe_model.dart';

class Home extends StatelessWidget {
  Home({super.key});

  List<CategoryModel> categories = [];
  List<RecipeModel> favRecipes = [];

  RecipeModel dayRecipeTemp = RecipeModel(
    name: 'Macarrão ao molho branco',
    image: 'sla',
    rating: 5,
    time: 10,
    ingredients: 'aaaa',
    steps: 'bbbb',
  );

  void _getCategories() {
    categories = CategoryRepository.getCategories();
  }

  void _getFavRecipes() {
    favRecipes = FavoritesRepository.getFavRecipes();
  }

  void initState() {
    _getCategories();
    _getFavRecipes();
  }

  @override
  Widget build(BuildContext context) {
    _getCategories();
    _getFavRecipes();

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, _) => [appBar()],
        body: ListView(
          children: [
            searchField(),
            dayRecipe(),
            categoriesSection(),
            favorites(),
          ],
        ),
      ),
      bottomNavigationBar: bottomBar(),
    );
  }

  Container bottomBar() {
    return Container(
      color: Colors.white,
      height: 50,
    );
  }

  Column favorites() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Favoritas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: RecipeCard(
                      title: favRecipes[index].name,
                      rating: favRecipes[index].rating.toInt(),
                      imageUrl: 'nao',
                    ),
                    onTap: () => seeRecipeDetails(context, favRecipes[index]),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 25),
                itemCount: favRecipes.length,
              ),
            ],
          ),
        ),
      ],
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

  Padding dayRecipe() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Receita do dia',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          RecipeCard(
            title: dayRecipeTemp.name,
            rating: dayRecipeTemp.rating.toInt(),
            imageUrl: 'sla',
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
                    color: categories[index].boxColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                      ),
                      Text(
                        categories[index].name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
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
  print('sla');
}

Container searchField() {
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20),
    decoration: const BoxDecoration(boxShadow: [
      BoxShadow(color: Colors.black, blurRadius: 40, spreadRadius: 1.0)
    ]),
    child: const TextField(
      decoration: InputDecoration(
        hintText: 'Procurar Receitas',
        filled: true,
        prefixIcon: Icon(Icons.search),
      ),
    ),
  );
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

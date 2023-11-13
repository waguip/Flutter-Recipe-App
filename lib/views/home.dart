import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category_model.dart';
import 'package:flutter_application_1/repositories/category_repository.dart';
import 'package:flutter_application_1/repositories/favorites_repository.dart';
import 'package:flutter_application_1/repositories/recipe_repository.dart';
import 'package:flutter_application_1/views/recipe_details.dart';
import 'package:flutter_application_1/views/widgets/recipe_card.dart';
import 'package:flutter_application_1/views/widgets/search_field.dart';
import 'package:provider/provider.dart';
import '../models/recipe_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<RecipeModel> topRecipes = [];

  RecipeModel dayRecipeTemp = RecipeModel(
    name: 'Macarrão ao molho branco',
    image: 'sla',
    rating: 5,
    time: 10,
    ingredients:
        '1 cebola pequena picada,\n1 colher de margarina,\n1 caixa de creme de leite,\n1/2 litro de leite',
    steps:
        '1. Em uma panela, derreta a margarina e acrescente a cebola, o sal e a pimenta-do-reino. \n 2.  Quando a cebola estiver bem transparente, acrescente o creme de leite e misture.',
  );

  void _getTopRecipes() {
    topRecipes = RecipeRepository.getRecipes();
  }

  @override
  void initState() {
    super.initState();
    _getTopRecipes();
  }

  late FavoritesRepository favoritesRep;
  late CategoryRepository categoriesRep;

  @override
  Widget build(BuildContext context) {
    favoritesRep = context.watch<FavoritesRepository>();
    categoriesRep = context.watch<CategoryRepository>();

    _getTopRecipes();

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, _) => [appBar()],
        body: ListView(
          children: [
            const SearchField(),
            dayRecipe(context),
            categoriesSection(),
            topRecipesColumn(),
          ],
        ),
      ),
    );
  }

  Column topRecipesColumn() {
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
                  if (favoritesRep.favRecipes.contains(topRecipes[index])) {
                    favorited = true;
                  }
                  return GestureDetector(
                    child: RecipeCard(
                      title: topRecipes[index].name,
                      rating: topRecipes[index].rating.toInt(),
                      imageUrl: 'nao',
                      favorited: favorited,
                    ),
                    onTap: () => seeRecipeDetails(context, topRecipes[index]),
                    onLongPress: () => saveFavorite(topRecipes[index]);,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 25),
                itemCount: topRecipes.length,
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
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Receita do dia',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            child: RecipeCard(
              title: dayRecipeTemp.name,
              rating: dayRecipeTemp.rating.toInt(),
              imageUrl: 'sla',
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

searchByCategory(CategoryModel category) {}

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

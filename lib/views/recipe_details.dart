import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/recipe_model.dart';
import 'package:flutter_application_1/views/widgets/recipe_card.dart';

class RecipeDetails extends StatefulWidget {
  RecipeModel recipe;

  RecipeDetails({super.key, required this.recipe});

  @override
  State<StatefulWidget> createState() => RecipeDetailsState();
}

class RecipeDetailsState extends State<RecipeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.recipe.name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RecipeCard(
                title: '',
                rating: widget.recipe.rating.toInt(),
                imageUrl: widget.recipe.image,
              ),
              const SizedBox(height: 20),
              const Text(
                'Ingredientes:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(widget.recipe.ingredients),
              const SizedBox(height: 20),
              const Text(
                'Passos:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(widget.recipe.steps),
            ],
          ),
        ));
  }
}

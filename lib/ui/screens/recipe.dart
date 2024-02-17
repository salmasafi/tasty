// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../logic/components/methods.dart';
import '../../logic/components/variables.dart';
import '../../logic/objects/recipe_model.dart';
import '../../logic/services/recipe_service.dart';
import '../widgets/recipe_card.dart';
import '../widgets/recipe_image_card.dart';
import 'favs.dart';

class RecipePageBuilder extends StatefulWidget {
  final String mealName;
  final Color color;
  const RecipePageBuilder(
      {Key? key, required this.mealName, required this.color})
      : super(key: key);

  @override
  State<RecipePageBuilder> createState() => _RecipePageBuilderState();
}

class _RecipePageBuilderState extends State<RecipePageBuilder> {
  // ignore: prefer_typing_uninitialized_variables
  var future;

  @override
  void initState() {
    super.initState();
    future = RecipeService().getRecipe(mealName: widget.mealName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Recipe>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return RecipePage(
            recipe: snapshot.data!,
            color: widget.color,
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('OOPS There is a problem'),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class RecipePage extends StatelessWidget {
  final Recipe recipe;
  final Color color;

  const RecipePage({Key? key, required this.recipe, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasty - ${recipe.name}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (favRecipesList.contains(recipe.name)) {
                favRecipesList.remove(recipe.name);
                await saveFavoriteNames(favRecipesList);
                Navigator.pop(context);
                Navigator.pop(context);
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavsPageBuilder()));
            },
            icon: const Icon(Icons.heart_broken),
          ),
          IconButton(
            onPressed: () async {
              if (!favRecipesList.contains(recipe.name)) {
                favRecipesList.add(recipe.name);
                await saveFavoriteNames(favRecipesList);
                Navigator.pop(context);
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavsPageBuilder(),
                ),
              );
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              RecipeImageCard(
                  name: recipe.name,
                  image: recipe.image,
                  color: color,
                  widgetToNavigate: null),
              RecipeCard(
                color: color,
                text: 'Origin: ${recipe.origin}',
                fontSize: 22,
                maxLines: 1,
                height: 80,
              ),
              RecipeCard(
                  color: color,
                  text: recipe.ingredientsString,
                  fontSize: 18,
                  maxLines: 15,
                  height: 300),
              RecipeCard(
                  color: color,
                  text: recipe.description,
                  fontSize: 18,
                  maxLines: 23,
                  height: 600),
              RecipeCard(
                color: color,
                text: 'Source: ${recipe.source}',
                height: 75,
                fontSize: 18,
                maxLines: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}

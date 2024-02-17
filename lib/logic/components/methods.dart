import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../objects/recipe_model.dart';
import '../services/recipe_service.dart';

Future<void> saveFavoriteNames(List<String> favoriteNames) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('favorite_names', favoriteNames);
}

Future<List<String>> getFavoriteNames() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('favorite_names') ?? [];
}

Future<List<Recipe>> convertStringListToObjectList(
    List<String> favRecipesList) async {
  List<Recipe> favRecipesObjectList = [];

  for (var i = 0; i < favRecipesList.length; i++) {
    final recipe = await RecipeService().getRecipe(mealName: favRecipesList[i]);
    favRecipesObjectList.add(recipe);
  }

  return favRecipesObjectList;
}


Color getColor({required Recipe recipe}) {
  switch (recipe.category) {
    case 'Beef':
      return const Color(0xffe74c3c);
    case 'Chicken':
      return const Color.fromARGB(255, 225, 186, 100);
    case 'Dessert':
      return const Color(0xff8b4513);
    case 'Pasta':
      return const Color(0xffd35400);
    case 'Seafood':
      return const Color(0xff3498db);
    case 'Breakfast':
      return const Color(0xfff39c12);
    case 'Vegetarian':
      return const Color(0xff27ae60);
    case 'Vegan':
      return const Color(0xff16a085);
    default:
      return Colors.red;
  }
}


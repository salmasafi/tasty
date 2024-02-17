import 'package:dio/dio.dart';
import '../objects/meal_model.dart';
import '../objects/recipe_model.dart';

class RecipeService {
  Dio dio = Dio();

  Future<List<Meal>> getMeals({required String categoryName}) async {
    Response response = await dio.get(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryName');
    Map<String, dynamic> jsonData = response.data;
    List<dynamic> meals = jsonData['meals'];

    List<Meal> mealsList = [];

    for (var meal in meals) {
      String image;
      String name;

      if (meal['strMealThumb'] == null) {
        image =
            'https://w7.pngwing.com/pngs/426/730/png-transparent-logo-yellow-font-recipe-logo-art-yellow.png';
      } else {
        image = meal['strMealThumb'];
      }

      if (meal['strMeal'] == null) {
        name = 'No title';
      } else {
        name = meal['strMeal'];
      }

      mealsList.add(Meal(image: image, name: name));
    }
    return mealsList;
  }

  Future<Recipe> getRecipe({required String mealName}) async {
    String name;
    String image;
    String origin;
    String description;
    String source;
    String category;
    List<String> ingredients = [];
    List<String> measures = [];
    String ingredientsString;

    Response response = await dio
        .get('https://www.themealdb.com/api/json/v1/1/search.php?s=$mealName');
    Map<String, dynamic> jsonData = response.data;
    List<dynamic> recipes = jsonData['meals'];



    if (recipes.isNotEmpty) {
      Map<String, dynamic> recipe = recipes[0];

      name = (recipe['strMeal'] != null &&
              recipe['strMeal'] != '' &&
              recipe['strMeal'] != ' ')
          ? recipe['strMeal']
          : 'No name';
      image = (recipe['strMealThumb'] != null &&
              recipe['strMealThumb'] != '' &&
              recipe['strMealThumb'] != ' ')
          ? recipe['strMealThumb']
          : 'https://w7.pngwing.com/pngs/426/730/png-transparent-logo-yellow-font-recipe-logo-art-yellow.png';
      origin = (recipe['strArea'] != null &&
              recipe['strArea'] != '' &&
              recipe['strArea'] != ' ')
          ? recipe['strArea']
          : 'Unknown';
      description = (recipe['strInstructions'] != null &&
              recipe['strInstructions'] != '' &&
              recipe['strInstructions'] != ' ')
          ? recipe['strInstructions']
          : 'No description';
      source = (recipe['strSource'] != null &&
              recipe['strSource'] != '' &&
              recipe['strSource'] != ' ')
          ? recipe['strSource']
          : 'No source';
      category = (recipe['strCategory'] != null &&
              recipe['strCategory'] != '' &&
              recipe['strCategory'] != ' ')
          ? recipe['strCategory']
          : 'No category';

      for (var key in recipe.keys) {
        if (key.contains('strIngredient')) {
          ingredients.add(recipe[key] ?? '');
        }
      }

      for (var key in recipe.keys) {
        if (key.contains('strMeasure')) {
          measures.add(recipe[key] ?? '');
        }
      }

      String getIngredients({
        required List<String> ingredients,
        required List<String> measures,
      }) {
        String ingredientsString = '';

        for (var i = 0; i < ingredients.length; i++) {
          if (ingredients[i] != '' &&
              ingredients[i] != ' ' &&
              measures[i] != '' &&
              measures[i] != ' ') {
            ingredientsString += ingredients[i];
            ingredientsString += ': ';
            ingredientsString += measures[i];
            ingredientsString += ' | ';
          }
        }
        return ingredientsString;
      }

      ingredientsString =
          getIngredients(ingredients: ingredients, measures: measures);

      return Recipe(
        name: name,
        image: image,
        origin: origin,
        description: description,
        ingredientsString: ingredientsString,
        category: category,
        source: source,
      );
    } else {
      return Recipe(
          name: 'No name',
          image:
              'https://w7.pngwing.com/pngs/426/730/png-transparent-logo-yellow-font-recipe-logo-art-yellow.png',
          origin: 'Unknown',
          description: 'No description',
          ingredientsString: 'No ingredients',
          category: 'No category',
          source: 'No source');
    }
  }
}

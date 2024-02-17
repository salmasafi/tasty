import 'package:flutter/material.dart';
import '../../logic/objects/meal_model.dart';
import '../../logic/services/recipe_service.dart';
import '../widgets/recipe_image_card.dart';
import 'favs.dart';
import 'recipe.dart';

class MealsPageBuilder extends StatefulWidget {
  final String categoryName;
  final Color categoryColor;

  const MealsPageBuilder(
      {Key? key, required this.categoryName, required this.categoryColor})
      : super(key: key);

  @override
  State<MealsPageBuilder> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<MealsPageBuilder> {
  var future;

  @override
  void initState() {
    super.initState();
    future = RecipeService().getMeals(categoryName: widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Meal>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MealsPage(
            mealsList: snapshot.data!,
            categoryName: widget.categoryName,
            categoryColor: widget.categoryColor,
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

class MealsPage extends StatelessWidget {
  final String categoryName;
  final Color categoryColor;

  final List<Meal> mealsList;

  const MealsPage(
      {Key? key,
      required this.mealsList,
      required this.categoryName,
      required this.categoryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasty - $categoryName',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavsPageBuilder()));
              },
              icon: const Icon(Icons.favorite))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: RecipeImageCard(
              name: mealsList[index].name,
              image: mealsList[index].image,
              color: categoryColor,
              widgetToNavigate: RecipePageBuilder(mealName: mealsList[index].name, color: categoryColor,),
            ),
          );
        },
        itemCount: mealsList.length,
      ),
    );
  }
}

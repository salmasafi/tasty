import 'package:flutter/material.dart';
import '../../logic/components/methods.dart';
import '../../logic/components/variables.dart';
import '../../logic/objects/recipe_model.dart';
import '../widgets/recipe_image_card.dart';
import 'recipe.dart';

class FavsPageBuilder extends StatefulWidget {
  const FavsPageBuilder({Key? key}) : super(key: key);

  @override
  State<FavsPageBuilder> createState() => _FavsPageBuilderState();
}

class _FavsPageBuilderState extends State<FavsPageBuilder> {
  var future;
  var favRecipesObjectList;
  @override
  void initState() {
    super.initState();
    future = getFavoriteNames();
    future.then((favRecipesList) {
      convertStringListToObjectList(favRecipesList)
          .then((favRecipesObjectList) {
        setState(() {
          this.favRecipesObjectList = favRecipesObjectList;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          favRecipesList = snapshot.data!;
          return FavsPage(favRecipesList: favRecipesList);
        } else if (snapshot.hasError) {
          return const Center(child: Text('OOPS There is a problem'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class FavsPage extends StatefulWidget {
  final List<String> favRecipesList;
  const FavsPage({Key? key, required this.favRecipesList}) : super(key: key);

  @override
  State<FavsPage> createState() => _FavsPageState();
}

class _FavsPageState extends State<FavsPage> {
  List<Recipe> favRecipesObjectList = [];

  @override
  void initState() {
    super.initState();
    getFavoriteNames().then((favRecipesList) {
      convertStringListToObjectList(favRecipesList).then((recipes) {
        setState(() {
          favRecipesObjectList = recipes;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasty - Favorites',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: Future.value(favRecipesObjectList),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RecipeImageCard(
                    name: snapshot.data![index].name,
                    image: snapshot.data![index].image,
                    color: getColor(recipe: snapshot.data![index]),
                    widgetToNavigate: RecipePageBuilder(
                        mealName: snapshot.data![index].name,
                        color: getColor(recipe: snapshot.data![index])),
                  ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('OOPS There is a problem'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

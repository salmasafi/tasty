import 'package:flutter/material.dart';
import '../widgets/category_card.dart';
import 'favs.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasty - Categories', style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const FavsPageBuilder()));}, icon: const Icon(Icons.favorite))],
      ),
      body: const SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              CategoryCard(categoryName: 'Beef', categoryColor: Color(0xffe74c3c), categoryImage: 'assets/beef.png'),
              CategoryCard(categoryName: 'Chicken', categoryColor: Color.fromARGB(255, 225, 186, 100), categoryImage: 'assets/chicken.png'),
            ],
          ),
          Row(
            children: [
              CategoryCard(categoryName: 'Dessert', categoryColor: Color(0xff8b4513), categoryImage: 'assets/dessert.png'),
              CategoryCard(categoryName: 'Pasta', categoryColor: Color(0xffd35400), categoryImage: 'assets/pasta.png'),
            ],
          ),
          Row(
            children: [
              CategoryCard(categoryName: 'Seafood', categoryColor: Color(0xff3498db), categoryImage: 'assets/seafood.png'),
              CategoryCard(categoryName: 'Breakfast', categoryColor: Color(0xfff39c12), categoryImage: 'assets/breakfast.png'),
            ],
          ),
          Row(
            children: [
              CategoryCard(categoryName: 'Vegetarian', categoryColor: Color(0xff27ae60), categoryImage: 'assets/vegetarian.png'),
              CategoryCard(categoryName: 'Vegan', categoryColor: Color(0xff16a085), categoryImage: 'assets/vegan.png'),
            ],
          ),
        ]),
      ),
    );
  }
}
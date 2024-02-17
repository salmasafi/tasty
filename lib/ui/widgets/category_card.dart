import 'package:flutter/material.dart';
import '../screens/meals.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String categoryImage;
  final Color categoryColor;

  const CategoryCard(
      {Key? key,
      required this.categoryName,
      required this.categoryImage,
      required this.categoryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // استخدام MediaQuery للحصول على معلومات حول حجم الشاشة
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MealsPageBuilder(
                categoryName: categoryName,
                categoryColor: categoryColor,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: screenWidth / 2 - 16,
          height: screenHeight / 4 - 26,
          child: Card(
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: categoryColor,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Column(
                children: [
                  SizedBox(
                    height: (screenHeight / 4 - 40) * 0.67,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(20),
                        topEnd: Radius.circular(20),
                      ),
                      child: Image(
                        image: AssetImage(categoryImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight / 4 - 40) * 0.33,
                    child: Center(
                      child: Text(
                        categoryName,
                        style: TextStyle(
                            fontSize: (screenHeight / 4 - 40) * 0.15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RecipeImageCard extends StatelessWidget {
  final String name;
  final String image;
  final Color color;
  final Widget? widgetToNavigate;
  const RecipeImageCard({
    Key? key,
    required this.name,
    required this.image,
    required this.color,
    required this.widgetToNavigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (widgetToNavigate != null)
          ? () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widgetToNavigate!,
                  ));
            }
          : () {},
      child: SizedBox(
        width: double.infinity,
        height: 315,
        child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: color,
          child: Padding(padding: const EdgeInsets.only(bottom: 6),
          child: Column(
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    topEnd: Radius.circular(20),
                  ),
                  child: Image(
                    image: NetworkImage(image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),),
        ),
      ),
    );
  }
}

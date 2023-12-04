import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final double rating;
  final String imageUrl;
  final bool favorited;

  const RecipeCard({
    super.key,
    required this.title,
    required this.rating,
    required this.imageUrl,
    required this.favorited,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.multiply,
          ),
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(
                        '$rating',
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                if (favorited)
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                if (!favorited)
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.favorite_border,
                      color: Color.fromARGB(255, 125, 34, 27),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RecipeCardData {
  final String name;
  final String description;
  final String place;
  final String? thumbnailUrl;

  RecipeCardData({
    required this.name,
    required this.description,
    required this.place,
    this.thumbnailUrl, 
  });
}

class MyRecipeCardWidget extends StatelessWidget {
  final RecipeCardData data;

  MyRecipeCardWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          if (data.thumbnailUrl != null)
            Image.network(data.thumbnailUrl!),
          Text(data.name),
          Text(data.description),
          Text('Lugar: ${data.place}'),
        ],
      ),
    );
  }
}

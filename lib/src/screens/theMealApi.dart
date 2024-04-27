import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipeSelectionScreen extends StatefulWidget {
  @override
  _RecipeSelectionScreenState createState() => _RecipeSelectionScreenState();
}

class Recipe {
  final String name;
  final String thumbnailUrl;

  Recipe({required this.name, required this.thumbnailUrl});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['strMeal'] as String,
      thumbnailUrl: json['strMealThumb'] as String,
    );
  }
}

class _RecipeSelectionScreenState extends State<RecipeSelectionScreen> {
  late Future<List<Recipe>> _recipesList;

  @override
  void initState() {
    super.initState();
    _recipesList = _fetchRecipes();
  }

  Future<List<Recipe>> _fetchRecipes() async {
    final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?f=a'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Recipe> recipes = [];
      for (var item in data['meals']) {
        recipes.add(Recipe.fromJson(item));
      }
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elige una Receta'),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _recipesList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recipe = snapshot.data![index];
                return ListTile(
                  title: Text(recipe.name),
                  leading: Image.network(recipe.thumbnailUrl),
                  onTap: () {
                    // Cierra la pantalla de selección de recetas y pasa la receta seleccionada de vuelta.
                    Navigator.pop(context, recipe);
                  },
                );
              },
            );
          } else {
            return Text("No hay datos disponibles");
          }
        },
      ),
    );
  }
}

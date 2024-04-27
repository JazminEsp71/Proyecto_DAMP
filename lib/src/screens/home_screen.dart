import 'package:flutter/material.dart';
import 'package:proyecto2/src/bloc/bloc.dart';
import 'package:proyecto2/src/screens/card.dart';
import 'package:proyecto2/src/bloc/recipeCardData.dart';
import 'package:proyecto2/src/screens/theMealApi.dart'; 

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;
  List<Widget> cards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: navigateToAddCardScreen,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return cards[index];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToApiScreen,
        child: Icon(Icons.api),
        backgroundColor: Colors.blue, 
      ),
    );
  }

  void navigateToAddCardScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CustomCard(
          onSaved: (newRecipe) {
            setState(() {
              cards.add(MyRecipeCardWidget(data: newRecipe));
            });
          },
        ),
      ),
    );
  }

  void navigateToApiScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecipeSelectionScreen(),
      ),
    );
  }
}

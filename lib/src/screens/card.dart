import 'package:flutter/material.dart';
import 'package:proyecto2/src/bloc/bloc.dart';
import 'package:proyecto2/src/screens/theMealApi.dart';
import 'package:proyecto2/src/bloc/recipeCardData.dart';

class CustomCard extends StatefulWidget {
  final Function(RecipeCardData) onSaved;

  CustomCard({required this.onSaved});

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController lugar = TextEditingController();
  String? userName;
  String? selectedRecipeName;
  String? selectedRecipePhotoUrl;

  void initState() {
    super.initState();
    userName = bloc.currentUserName;
  }

  void _saveCard() {
    if (nameController.text.isEmpty ||
        descripcion.text.isEmpty ||
        lugar.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor complete todos los campos")),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Card'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(userName ?? 'Usuario desconocido'),
          selectedRecipePhotoUrl != null
              ? Image.network(selectedRecipePhotoUrl!)
              : SizedBox(),
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nombre de la receta'),
          ),
          TextField(
            controller: descripcion,
            decoration: InputDecoration(labelText: 'Descripción'),
          ),
          TextField(
            controller: lugar,
            decoration: InputDecoration(labelText: 'Lugar'),
          ),
          // Agregamos el botón aquí
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _navigateAndDisplaySelection(context),
                child: Text('Seleccionar Receta'),
              ),
              ElevatedButton(
                onPressed: _saveCard,
                child: Text('Guardar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeSelectionScreen()),
    );

    if (result != null) {
      setState(() {
        selectedRecipeName = result['name']; 
        selectedRecipePhotoUrl =
            result['photoUrl'];
        nameController.text = selectedRecipeName ??
            ''; 
      });
    }
  }
}


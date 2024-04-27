import 'package:flutter/material.dart';
import 'package:proyecto2/src/screens/home_screen.dart';
import 'package:proyecto2/src/bloc/bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightForFinite(
              height: MediaQuery.of(context).size.height,
            ),
            child: Container(
              padding: EdgeInsets.all(40.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text(
                    'WELCOME', // Texto de bienvenida
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0), // Espacio entre textos
                  Text(
                    'LOGIN', // Texto que indica la sección de inicio de sesión
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20.0), // Espacio antes del campo de email
                  emailField(),
                  passwordField(),
                  SizedBox(height: 25.0),
                  submitButton(context), 
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'You@example.com',
            labelText: 'Email',
            errorText: snapshot.error?.toString(),
          ),
          onChanged: bloc.changeEmail,
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            hintText: 'Contraseña',
            errorText: snapshot.error?.toString(),
          ),
          onChanged: bloc.changePassword,
        );
      },
    );
  }

  Widget submitButton(BuildContext context) { 
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
      ),
      child: Text('Entrar'),
      onPressed: () {
        if (bloc.validarCredenciales(_emailController.text, _passwordController.text)) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Credenciales invalidas'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cerrar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
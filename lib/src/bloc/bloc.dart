import 'dart:async';
import 'package:proyecto2/src/bloc/validators.dart';
import 'package:proyecto2/src/bloc/users.dart';

class Bloc with Validators {
  static final Bloc _singleton = Bloc._internal();

  User? _currentUser;

  factory Bloc() {
    return _singleton;
  }

  Bloc._internal() {
    _usuarios.add(User(
        email: 'jazminesp71@gmail.com', password: '12345', name: 'Jazmin'));
    _usuarios
        .add(User(email: 'jairRF@gmail.com', password: '12346', name: 'Jair'));
    _usuarios
        .add(User(email: 'guada@gmail.com', password: '12346', name: 'Guadalupe'));
  }

  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();
  final _nameController = StreamController<String>.broadcast();

  final List<User?> _usuarios = [];

  //Modificamos los parametros de estas 2 lineas
  Stream<String> get name => _nameController.stream;
  Stream<String> get email => _emailController.stream.transform(validaEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validaPassword);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeName => _nameController.sink.add;

  dispose() {
    _emailController.close();
    _passwordController.close();
    _nameController.close();
  }

  bool validarCredenciales(String email, String password) {
    final User? user = _usuarios.firstWhere(
      (user) => user?.email == email && user?.password == password,
      orElse: () =>
          null, // Esto está permitido porque ahora User? es un tipo nullable.
    );
    if (user != null) {
      _currentUser = user;
      _nameController.sink.add(user.name);
      return true;
    }
    return false;
  }

  String? get currentUserName => _currentUser?.name;
}

final bloc = Bloc();

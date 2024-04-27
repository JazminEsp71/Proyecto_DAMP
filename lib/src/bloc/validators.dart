import 'dart:async';
import 'dart:math';

mixin class Validators{
  final validaEmail = 
  StreamTransformer<String, String>
  .fromHandlers(
    handleData: (email, sink){
      if(email.contains('@')){
        sink.add(email);
      }else{
        sink.addError('Email invalido');
      }
    }
  );

  final validaPassword =
  StreamTransformer<String, String>
  .fromHandlers(
    handleData: (password, sink){
      if(password.length >= 5){
        sink.add(password);
      }else{
        sink.addError('Contraseña invalida');
      }
    }
  ); 
}
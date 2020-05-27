import 'package:firebase_auth/firebase_auth.dart';
import 'package:listaprodutos/firebase/repositorio.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class LoginBloc {

  final _repositorio = Repositorio();

  final _nome = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _senha = BehaviorSubject<String>();
  final _isLogado = BehaviorSubject<bool>();

  Stream<String> get nome => _nome.stream;
  Stream<String> get email => _email.stream.transform(_validarEmail);
  Stream<String> get senha => _senha.stream.transform(_validarSenha);
  Stream<bool> get isLogado => _isLogado.stream;

  String get endEmail => _email.value;

  Function(String) get mudarNome => _nome.sink.add;
  Function(String) get mudarEmail => _email.sink.add;
  Function(String) get mudarSenha => _senha.sink.add;
  Function(bool) get statusLogin => _isLogado.sink.add;
  Function(bool) get mostrarProgress => _isLogado.sink.add;

  final _validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError('Email inválido');
    }
  });

  final _validarSenha =
      StreamTransformer<String, String>.fromHandlers(handleData: (senha, sink) {
    if (senha.length > 5) {
      sink.add(senha);
    } else {
      sink.addError('A senha deve conter pelo menos 6 caracteres');
    }
  });

  Future<bool> entrarConta() {
    return _repositorio.fazerLogin(_email.value, _senha.value);
  }

  Future<Null> registrarConta() {
    return _repositorio.criarUsuario(_nome.value, _email.value, _senha.value);
  }

  Future<bool> estaLogado(){
    return _repositorio.isSignedIn();
  }

  Future<FirebaseUser> getUsuario(){
    return _repositorio.getUser();
  }

  fazerLogOut() {
    return _repositorio.fazerLogOut();
  }

  bool validarCamposCadastro() {
    if (_nome.value != null &&
        _nome.value.isNotEmpty &&
        _email.value != null &&
        _email.value.contains('@') &&
        _email.value.isNotEmpty &&
        _senha.value != null &&
        _senha.value.length > 5 &&
        _senha.value.isNotEmpty)
      return true;
    else
      return false;
  }

  bool validarCamposLogin() {
    if (_email.value != null &&
        _email.value.contains('@') &&
        _email.value.isNotEmpty &&
        _senha.value != null &&
        _senha.value.length > 5 &&
        _senha.value.isNotEmpty)
      return true;
    else
      return false;
  }

  void dispose() async {
    await _nome.drain();
    _nome.close();
    await _email.drain();
    _email.close();
    await _senha.drain();
    _senha.close();
    await _isLogado.drain();
    _isLogado.close();
  }
}

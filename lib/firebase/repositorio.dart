import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:listaprodutos/datas/produto.dart';
import 'package:listaprodutos/firebase/firebase_provider.dart';

class Repositorio {
  final _firebaseProvider = FirebaseProvider();

  Future<Null> criarUsuario(String nome, String email, String senha) =>
      _firebaseProvider.criarUsuario(nome, email, senha);

//  Future<Null> salvarUsuario(Map<String, dynamic> UsuarioData) =>
////      _firebaseProvider.salvarUsuario(UsuarioData);

  Future<bool> fazerLogin(String email, String senha) =>
      _firebaseProvider.fazerLogin(email, senha);

  Future<bool> isSignedIn() => _firebaseProvider.isSignedIn();

  Future<FirebaseUser> getUser() => _firebaseProvider.getUser();

  void fazerLogOut() => _firebaseProvider.fazerLogOut();

  void salvarProduto(String nome, String descricao, double preco, String imagem,
          String usuarioId) =>
      _firebaseProvider.salvarProduto(
          nome, descricao, preco, imagem, usuarioId);

  Future<QuerySnapshot> getProdutos(String usuario) =>
      _firebaseProvider.getProdutos(usuario);

  Future<List<Produto>> getListaProdutos(String usuario) =>
      _firebaseProvider.getListaProdutos(usuario);
}

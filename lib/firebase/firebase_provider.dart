import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:listaprodutos/datas/produto.dart';

class FirebaseProvider {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  Map<String, dynamic> usuarioData;

  Future<Null> criarUsuario(String nome, String email, String senha) async {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((user) async {
      _firebaseUser = user.user;
      Map<String, dynamic> usuarioData = {
        'nome': nome,
        'email': email,
        'senha': senha
      };
      _salvarUsuario(usuarioData);
    });
  }

  Future<Null> _salvarUsuario(Map<String, dynamic> UsuarioData) async {
    this.usuarioData = UsuarioData;
    await _firestore
        .collection('usuarios')
        .document(_firebaseUser.uid)
        .setData(UsuarioData);
  }

  Future<bool> fazerLogin(String email, String senha) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: senha).then((onValue){
      if (onValue.user != null){
        return true;
      }
      else{
        return false;
      }
    });
  }

  void fazerLogOut() async {
    await _firebaseAuth.signOut();
    usuarioData = Map();
    _firebaseUser = null;
  }

  void salvarProduto(String nome, String descricao, String preco, String imagem, String usuario) async {
    Map<String, dynamic> produto = {
      'usuarioId': usuario,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'imagem' : imagem
    };

    await _firestore
        .collection('usuarios')
        .document(usuario)
        .collection('produtos')
        .document()
        .setData(produto);
  }

  Future<QuerySnapshot> getProdutos(String usuario) async{
    return _firestore.collection('usuarios').document(usuario).collection('produtos').getDocuments();
  }

  Future<List<Produto>> getListaProdutos(String usuarioId) async{

    List<Produto> produtos;
    QuerySnapshot snapshot = await _firestore.collection('usuarios').document(usuarioId).collection('produtos').getDocuments();

    if (snapshot.documents.isNotEmpty)
    for (DocumentSnapshot snap in snapshot.documents){
      produtos.add(Produto.fromDocument(snap));
    }
    return produtos;
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getUser() async {
    return (await _firebaseAuth.currentUser());
  }


}

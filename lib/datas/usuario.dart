import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listaprodutos/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class Usuario extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> usuarioData = Map();
  bool isCarregando = false;

  static Usuario of(BuildContext context) => ScopedModel.of<Usuario>(context);


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _carregarUsuario();
  }

  void criarUsuario({
      @required Map<String, dynamic> usuarioData,
      @required String pass,
      @required VoidCallback onSucess,
      @required VoidCallback onFail}) {

    isCarregando = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: usuarioData['email'], password: pass)
        .then((user) async {
      firebaseUser = user.user;
      await _salvarUsuario(usuarioData);
      onSucess();
      isCarregando = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isCarregando = false;
      notifyListeners();
    });
  }

  void fazerLogin({@required String email,@required String pass,
    @required VoidCallback onSucess,@required VoidCallback onFail}) {

    isCarregando = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: pass).then((user) async{
      firebaseUser = user.user;

      await _carregarUsuario();
      onSucess();
      isCarregando = false;
      notifyListeners();
    }).catchError((e){
      onFail();
      isCarregando = false;
      notifyListeners();
    });

  }

  void fazerLogOut() async {
    await _auth.signOut();
    usuarioData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  bool isLogado() {
    //print(firebaseUser.displayName);
    return firebaseUser != null;
  }

  Future<Null> _carregarUsuario() async{
    if (firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if (firebaseUser != null)
      if (usuarioData['nome'] == null){
        DocumentSnapshot docUser =
        await Firestore.instance.collection('usuarios').document(firebaseUser.uid).get();
        usuarioData = docUser.data;
        notifyListeners();
      }
  }

  Future<Null> _salvarUsuario(Map<String, dynamic> UsuarioData) async {
    this.usuarioData = UsuarioData;
    await Firestore.instance
        .collection('usuarios')
        .document(firebaseUser.uid)
        .setData(UsuarioData);
  }
}

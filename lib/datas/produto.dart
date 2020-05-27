
import 'package:cloud_firestore/cloud_firestore.dart';

class Produto{

  String usuarioId;
  String id;
  String titulo;
  String descricao;
  String image;

  Produto.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    usuarioId = snapshot.data['usuarioId'];
    titulo = snapshot.data['titulo'];
    descricao = snapshot.data['descricao'];
    image = snapshot.data['imagem'];
  }
}
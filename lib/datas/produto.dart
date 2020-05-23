
import 'package:cloud_firestore/cloud_firestore.dart';

class Produto{

  String id;
  String titulo;
  String descricao;
  String image;

  Produto.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    titulo = snapshot.data['titulo'];
    descricao = snapshot.data['descricao'];
    image = snapshot.data['imagem'];
  }
}
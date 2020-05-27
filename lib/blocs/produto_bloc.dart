import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listaprodutos/datas/produto.dart';
import 'package:listaprodutos/firebase/repositorio.dart';
import 'package:rxdart/rxdart.dart';

class ProdutoBloc {
  final _repositorio = Repositorio();

  final _nome = BehaviorSubject<String>();
  final _descricao = BehaviorSubject<String>();
  final _preco = BehaviorSubject<String>();
  final _imagem = BehaviorSubject<String>();
  final _usuarioId = BehaviorSubject<String>();
  final _produtoList = BehaviorSubject<List<Produto>>();

  Stream<String> get nome => _nome.stream;
  Stream<String> get descricao => _descricao.stream;
  Stream<String> get preco => _preco.stream;
  Stream<String> get imagem => _imagem.stream;
  Stream<String> get usuarioId => _imagem.stream;
  Stream<List<Produto>> get produtoList => _produtoList.stream;

  Function(String) get mudarNome => _nome.sink.add;
  Function(String) get mudarDescricao => _descricao.sink.add;
  Function(String) get mudarPreco => _preco.sink.add;
  Function(String) get mudarImagem => _imagem.sink.add;
  Function(String) get mudarUsuarioId => _usuarioId.sink.add;

  registrarProduto() {
    return _repositorio.salvarProduto(_nome.value, _descricao.value, double.parse(_preco.value),
        _imagem.value, _usuarioId.value);
  }

  Future<QuerySnapshot> getPodutos(){
    return _repositorio.getProdutos(_usuarioId.value);
  }

  Future<List<Produto>> getListaProdutos() async {
    List<Produto> list;
    _repositorio.getListaProdutos(_usuarioId.value).then((value){
      list = value;
      _produtoList.sink.add(list);
    });
  }

  bool validarCampos(){
    if (_nome.value != null && _nome.value.isNotEmpty &&
        _descricao.value != null && _descricao.value.isNotEmpty &&
        _preco.value != null){
      return true;
    }
    else return false;
  }

  void dispose() async{
    await _nome.drain();
    _nome.close();
    await _descricao.drain();
    _descricao.close();
    await _preco.drain();
    _preco.close();
    await _imagem.drain();
    _imagem.close();
    await _usuarioId.drain();
    _usuarioId.close();
  }
}


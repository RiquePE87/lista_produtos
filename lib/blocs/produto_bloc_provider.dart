import 'package:flutter/material.dart';
import 'package:listaprodutos/blocs/produto_bloc.dart';

class ProdutoBlocProvider extends InheritedWidget{
  final bloc = ProdutoBloc();

  @override
  bool updateShouldNotify(_) => true;

  ProdutoBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  static ProdutoBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ProdutoBlocProvider) as ProdutoBlocProvider).bloc;
  }
}
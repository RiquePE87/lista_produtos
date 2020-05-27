import 'package:flutter/material.dart';
import 'package:listaprodutos/blocs/login_bloc.dart';
import 'package:listaprodutos/blocs/login_bloc_provider.dart';
import 'package:listaprodutos/blocs/produto_bloc.dart';
import 'package:listaprodutos/blocs/produto_bloc_provider.dart';
import 'package:listaprodutos/datas/produto.dart';
import 'package:listaprodutos/ui/cadastro_form.dart';
import 'package:listaprodutos/widgets/card_produto.dart';

import 'cadastro.dart';

class ProdutosForm extends StatefulWidget {
  @override
  _ProdutosFormState createState() => _ProdutosFormState();
}

class _ProdutosFormState extends State<ProdutosForm> {
  ProdutoBloc _bloc;
  LoginBloc _loginBloc;
  @override
  Widget build(BuildContext context) {
    return listProduto();
  }

  Widget listProduto() {
    return StreamBuilder(
      stream: _bloc.produtoList,
      builder: (context, AsyncSnapshot<List<Produto>> snapshot) {
        if (snapshot.hasData)
        return ListView.builder(
          itemBuilder: (context, index) {
            return CardProduto(snapshot.data[index]);
          },
          itemCount: snapshot.data.length,
        );
        else
           return Container(
             child: RaisedButton(
              child: Text('Cadastrar Produto'),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Cadastro()));
              },
          ),
           );

      },
    );
  }


  @override
  void initState() {
    super.initState();
//    _bloc = ProdutoBlocProvider.of(context);
//    _loginBloc = LoginBlocProvider.of(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = ProdutoBlocProvider.of(context);
    _loginBloc = LoginBlocProvider.of(context);
    _loginBloc.getUsuario().then((onValue){
      _bloc.mudarUsuarioId(onValue.uid);
      _bloc.getListaProdutos();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}

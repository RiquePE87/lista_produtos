import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class CadastroProdutosScreen extends StatefulWidget {
  @override
  _CadastroProdutosScreenState createState() => _CadastroProdutosScreenState();
}

class _CadastroProdutosScreenState extends State<CadastroProdutosScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _descricaoCtrl = TextEditingController();
  final _precoCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Produto'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: AspectRatio(
                      aspectRatio: 0.9,
                      child: Carousel(
                        images: [],
                        boxFit: BoxFit.cover,
                        defaultImage: Image.asset('images/placeholder.png'),
                        dotSize: 4.0,
                        dotSpacing: 15.0,
                        dotBgColor: Colors.transparent,
                        dotColor: Theme.of(context).primaryColor,
                        autoplay: false,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Text('Adicionar Imagem', style: TextStyle(fontSize: 12.0),)),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _nomeCtrl,
                    decoration: InputDecoration(
                      hintText: 'Nome',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: _descricaoCtrl,
                    decoration: InputDecoration(
                      hintText: 'Descrição',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: _precoCtrl,
                    decoration: InputDecoration(
                      hintText: 'Preço',
                      prefixText: 'R\$',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    onPressed: (){},
                    child: Text(
                      'Salvar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

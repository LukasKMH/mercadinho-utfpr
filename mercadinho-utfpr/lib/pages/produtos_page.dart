// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_mercadinho/models/produto.dart';
import 'package:projeto_mercadinho/pages/home_page.dart';
import 'package:projeto_mercadinho/repositories/produtos_repository.dart';
import 'package:provider/provider.dart';
import '../pages/item_page.dart';
import 'carrinho_page.dart';
import 'editar_dados_page.dart';
import 'login_page.dart';

// ignore: camel_case_types
class Produtos_Page extends StatefulWidget {
  final String texto;

  const Produtos_Page({Key? key, required this.texto}) : super(key: key);

  @override
  State<Produtos_Page> createState() => _BebidasPageState();
}

class _BebidasPageState extends State<Produtos_Page> {
  List<Produto> produtos = [];
  late ProdutosRepository listaProdutos;

  @override
  Widget build(BuildContext context) {
    listaProdutos = context.watch<ProdutosRepository>();

    if (widget.texto == "Bebidas") {
      produtos = listaProdutos.produtos
          .where((produto) =>
              produto.categoria == 'bebida' && produto.quantidade > 0)
          .toList();
    } else if (widget.texto == "Salgadinhos \ne Bolachas") {
      produtos = listaProdutos.produtos
          .where((produto) =>
              produto.categoria == 'salgadinho' && produto.quantidade > 0)
          .toList();
    } else if (widget.texto == "Remédios") {
      produtos = listaProdutos.produtos
          .where((produto) =>
              produto.categoria == 'remédio' && produto.quantidade > 0)
          .toList();
    } else {
      produtos = listaProdutos.produtos
          .where((produto) => produto.quantidade > 0)
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saldo R\$: 108,20"),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home_Page()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: 'foto_perfil',
              child: GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset('images/foto_perfil.png'),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.yellow.shade400,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                margin: const EdgeInsets.only(top: 15, left: 15),
                decoration: BoxDecoration(
                  color: Colors.amber.shade300,
                  border: Border.all(
                    color: Colors.black,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Text(
                  widget.texto,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                    // Conteúdo da parte direita
                    ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250, // Largura
                mainAxisExtent: 250, // Altura
                crossAxisSpacing: 20, // Espaçamento horizontal
                mainAxisSpacing: 20, // Espaçamento vertical
              ),
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                // Botões que são os icones dos produtos
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemPage(
                          produto: produtos[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 250, 252, 232),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          child: Image.asset(
                            produtos[index].icone,
                            fit: BoxFit.contain,
                            height: 130,
                            width: 120,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                produtos[index].nome,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "R\$ " + produtos[index].preco.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.yellow.shade100,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.yellow.shade400,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home_Page(),
                    ),
                  );
                  // adicione aqui o código a ser executado ao clicar no ícone
                },
                child: Column(
                  children: [
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: Icon(
                        Icons.home,
                        key: UniqueKey(),
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CarrinhoPage(),
                    ),
                  );
                  // adicione aqui o código a ser executado ao clicar no ícone
                },
                child: Column(
                  children: [
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: Icon(
                        CupertinoIcons.cart,
                        key: UniqueKey(),
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                    Text(
                      "Carrinho",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Editar_Dados_Page()),
                  );
                  // adicione aqui o código a ser executado ao clicar no ícone
                },
                child: Column(
                  children: [
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: Icon(
                        Icons.person,
                        key: UniqueKey(),
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                    Text(
                      "Perfil",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login_Page()),
                  );
                  // adicione aqui o código a ser executado ao clicar no ícone
                },
                child: Column(
                  children: [
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: Icon(
                        Icons.logout,
                        key: UniqueKey(),
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

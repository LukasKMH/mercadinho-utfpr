import 'dart:collection';
import 'package:flutter/material.dart';
import '../models/produto.dart';

class CarrinhoRepository extends ChangeNotifier {
  List<Produto> _listaCarrinho = [];

  UnmodifiableListView<Produto> get lista =>
      UnmodifiableListView(_listaCarrinho);

  double getValorTotal() {
    double valorTotal = 0;
    if (_listaCarrinho.isEmpty) return 0;
    for (int i = 0; i < _listaCarrinho.length; i++) {
      valorTotal += _listaCarrinho[i].preco * _listaCarrinho[i].quantidade;
    }
    return valorTotal;
  }

  void adicionarProduto(Produto produto, int quantidade) {
  int index = _listaCarrinho.indexWhere((p) => p.nome == produto.nome);
  if (index != -1) {
    _listaCarrinho[index].quantidade += quantidade;
  } else {
    produto.quantidade = quantidade;
    _listaCarrinho.add(produto);
  }
  notifyListeners();
}


  void aumentarQuantidade(Produto produto) {
    int index = _listaCarrinho.indexWhere((p) => p.nome == produto.nome);
    if (index != -1) {
      _listaCarrinho[index].quantidade++;
      notifyListeners();
    }
  }

  void diminuirQuantidade(Produto produto) {
    int index = _listaCarrinho.indexWhere((p) => p.nome == produto.nome);
    if (index != -1) {
      if (_listaCarrinho[index].quantidade > 1) {
        _listaCarrinho[index].quantidade--;
      } else {
        _listaCarrinho.removeAt(index);
      }
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import '../models/monster_model.dart';

class CartItem {
  final Monster monster;
  int quantidade;

  CartItem({required this.monster, this.quantidade = 1});
}

class CartController with ChangeNotifier {
  final List<CartItem> _itens = [];

  List<CartItem> get itens => _itens;

  int get quantidadeTotal {
    return _itens.fold(0, (total, item) => total + item.quantidade);
  }

  // Calcula o valor total do carrinho baseado no preço fixo
  double get valorTotal {
    return _itens.fold(0.0, (total, item) => total + (item.quantidade * 12.90));
  }

  void adicionarAoCarrinho(Monster monster) {
    final index = _itens.indexWhere((item) => item.monster.id == monster.id);
    if (index >= 0) {
      _itens[index].quantidade++;
    } else {
      _itens.add(CartItem(monster: monster));
    }
    notifyListeners();
  }

  // Diminui a quantidade. Se chegar a 0, remove o item.
  void diminuirQuantidade(String id) {
    final index = _itens.indexWhere((item) => item.monster.id == id);
    if (index >= 0) {
      if (_itens[index].quantidade > 1) {
        _itens[index].quantidade--;
      } else {
        _itens.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Remove o item direto (Lixeira)
  void removerItemCompleto(String id) {
    _itens.removeWhere((item) => item.monster.id == id);
    notifyListeners();
  }

  void limparCarrinho() {
    _itens.clear();
    notifyListeners();
  }
}
import 'package:flutter/material.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesController extends ChangeNotifier {
  static const String _key = 'favoritos_monster';
  List<String> _favoritos = [];

  // Getters para acessar a lista
  List<String> get favoritos => _favoritos;

  // carrega os favoritos assim que a classe é criada
  FavoritesController() {
    _loadFavorites();
  }

  // Carrega a lista do armazenamento interno
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoritos = prefs.getStringList(_key) ?? [];
    notifyListeners(); 
  }

  // Salva ou remove um ID da lista de favoritos
  Future<void> toggleFavorite(String monsterId) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (_favoritos.contains(monsterId)) {
      _favoritos.remove(monsterId);
    } else {
      _favoritos.add(monsterId);
    }

    await prefs.setStringList(_key, _favoritos);
    
    notifyListeners();
  }

  // Verifica se um item é favorito
  bool isFavorite(String monsterId) {
    return _favoritos.contains(monsterId);
  }
}
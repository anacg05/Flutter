import 'package:shared_preferences/shared_preferences.dart';

class FavoritesController {
  // Persistir dados em dispositivos móveis
  static const String _key = 'favoritos_monster';

  // Salva ou remove um ID da lista de favoritos
  Future<void> toggleFavorite(String monsterId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoritos = prefs.getStringList(_key) ?? [];

    if (favoritos.contains(monsterId)) {
      favoritos.remove(monsterId);
    } else {
      favoritos.add(monsterId);
    }

    // modificações no armazenamento interno
    await prefs.setStringList(_key, favoritos);
  }

  // Verifica se um item é favorito
  Future<bool> isFavorite(String monsterId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoritos = prefs.getStringList(_key) ?? [];
    return favoritos.contains(monsterId);
  }
}
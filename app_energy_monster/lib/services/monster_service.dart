import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; 
import '../models/monster_model.dart';

class MonsterService {
  final String url =
      "https://api-monster-dag3.onrender.com/db.json";
  
  // Chave para salvar o cache local do catálogo
  static const String _cacheKey = "monster_catalog_cache";

  // comunicação GET COM CACHE LOCAL
  Future<List<Monster>> fetchMonsters() async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_cacheKey, response.body);

        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Monster.fromJson(json)).toList();
      } else {
        throw Exception();
      }
    } catch (e) {
      // CACHE LOCAL
      final prefs = await SharedPreferences.getInstance();
      final String? cacheSalvo = prefs.getString(_cacheKey);

      if (cacheSalvo != null && cacheSalvo.isNotEmpty) {
        List<dynamic> data = jsonDecode(cacheSalvo);
        return data.map((json) => Monster.fromJson(json)).toList();
      } else {
        throw Exception('Sem conexão com a internet e sem dados em cache.');
      }
    }
  }

  // comunicação POST
  Future<bool> addMonster(Monster monster) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(monster.toJson()), 
    );
    return response.statusCode == 201;
  }

  // comunicação PUT 
  Future<bool> updateMonster(Monster monster) async {
    final response = await http.put(
      Uri.parse("$url/${monster.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(monster.toJson()),
    );
    return response.statusCode == 200;
  }

  // comunicação DELETE
  Future<bool> deleteMonster(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$url/$id"),
        headers: {"Content-Type": "application/json"},
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      return false;
    }
  }

  // SEGUNDA API
  Future<Map<String, dynamic>?> buscarCep(String cep) async {
    try {
      final cepLimpo = cep.replaceAll(RegExp(r'[^0-9]'), '');
      if (cepLimpo.length != 8) return null;

      final response = await http.get(Uri.parse("https://viacep.com.br/ws/$cepLimpo/json/"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['erro'] == true) return null;
        return data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
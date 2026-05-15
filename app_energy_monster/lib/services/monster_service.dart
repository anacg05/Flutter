import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/monster_model.dart';

class MonsterService {
  final String url =
      "https://api-monster-dag3.onrender.com/db.json";

  // comunicação GET
  Future<List<Monster>> fetchMonsters() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Monster.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar dados da API');
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
}

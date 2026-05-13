import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/monster.dart';

class MonsterService {
  // Simulação de uma URL
  final String url =
      "https://6643c6836c6a6513132479f4.mockapi.io/api/v1/monsters";

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

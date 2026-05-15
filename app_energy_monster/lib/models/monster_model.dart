class Monster {
  final String id;
  final String nome;
  final String descricao;
  final String imagemUrl;
  final String hexColor;

  Monster({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.imagemUrl,
    required this.hexColor,
  });

  // Converte JSON da API para o Objeto 
  factory Monster.fromJson(Map<String, dynamic> json) {
    return Monster(
      id: json['id'].toString(),
      nome: json['nome'] ?? '',
      descricao: json['descricao'] ?? '',
      imagemUrl: json['imagemUrl'] ?? '',
      hexColor: json['hexColor'] ?? '0xFFFFFFFF',
    );
  }

  // Converte o Objeto para JSON 
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'imagemUrl': imagemUrl,
      'hexColor': hexColor,
    };
  }
}
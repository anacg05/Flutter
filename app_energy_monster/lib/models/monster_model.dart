// Classe Base 
class Monster {
  final String id;
  final String nome;
  final String descricao;
  final String imagemUrl;
  final String hexColor;
  final String tipo;

  Monster({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.imagemUrl,
    required this.hexColor,
    required this.tipo,
  });

  factory Monster.fromJson(Map<String, dynamic> json) {
    final tipoJson = (json['tipo'] ?? 'CLASSIC').toString().toUpperCase();
    
    switch (tipoJson) {
      case 'JUICE':
        return MonsterJuice.fromJson(json);
      case 'ULTRA':
        return MonsterUltra.fromJson(json);
      default:
        return Monster(
          id: json['id'].toString(),
          nome: json['nome'] ?? '',
          descricao: json['descricao'] ?? '',
          imagemUrl: json['imagemUrl'] ?? '',
          hexColor: json['hexColor'] ?? '0xFFFFFFFF',
          tipo: 'CLASSIC',
        );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'imagemUrl': imagemUrl,
      'hexColor': hexColor,
      'tipo': tipo,
    };
  }
}

class MonsterJuice extends Monster {
  final int porcentagemSuco;

  MonsterJuice({
    required super.id,
    required super.nome,
    required super.descricao,
    required super.imagemUrl,
    required super.hexColor,
    this.porcentagemSuco = 15,
  }) : super(tipo: 'JUICE');

  factory MonsterJuice.fromJson(Map<String, dynamic> json) {
    return MonsterJuice(
      id: json['id'].toString(),
      nome: json['nome'] ?? '',
      descricao: json['descricao'] ?? '',
      imagemUrl: json['imagemUrl'] ?? '',
      hexColor: json['hexColor'] ?? '0xFFFFB300',
      porcentagemSuco: json['porcentagemSuco'] ?? 15,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['porcentagemSuco'] = porcentagemSuco;
    return data;
  }
}

class MonsterUltra extends Monster {
  final bool zeroAcucar;

  MonsterUltra({
    required super.id,
    required super.nome,
    required super.descricao,
    required super.imagemUrl,
    required super.hexColor,
    this.zeroAcucar = true,
  }) : super(tipo: 'ULTRA');

  factory MonsterUltra.fromJson(Map<String, dynamic> json) {
    return MonsterUltra(
      id: json['id'].toString(),
      nome: json['nome'] ?? '',
      descricao: json['descricao'] ?? '',
      imagemUrl: json['imagemUrl'] ?? '',
      hexColor: json['hexColor'] ?? '0xFFFFFFFF',
      zeroAcucar: json['zeroAcucar'] ?? true,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['zeroAcucar'] = zeroAcucar;
    return data;
  }
}
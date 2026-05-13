class Monster {
  final String id;
  final String nome;
  final String sabor;
  final String imagemUrl;
  final double preco;

  Monster({
    required this.id,
    required this.nome,
    required this.sabor,
    required this.imagemUrl,
    required this.preco,
  });

  factory Monster.fromJson(Map<String, dynamic> json) {
    return Monster(
      id: json['id'],
      nome: json['nome'],
      sabor: json['sabor'],
      imagemUrl: json['imagemUrl'],
      preco: json['preco'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'sabor': sabor,
      'imagemUrl': imagemUrl,
      'preco': preco,
    };
  }
}
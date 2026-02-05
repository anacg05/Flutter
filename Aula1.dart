// sempre importar a biblioteca ao começar

import "dart:io";

// precisa da função principal

void main(){
  print("Olá Mundo!");

  // STDOUT coloca o poximo comando na frente do anterior
  stdout.write("Olá");
  stdout.write("Mundo");
  print("");

  print("Insira o seu nome:");
  String? nome = stdin.readLineSync(); // Como não sei o que o usuario digitar
  // A variavel nome pode ser nula

  // A segunda forma é dizer que a variavel precisa ter dados
  // String nome = stdin.readLineSync()!;

  print("Olá $nome");

  print("Digite a sua idade:");
  int idade = int.parse(stdin.readLineSync()!);
  print("Sua idade é $idade");



}
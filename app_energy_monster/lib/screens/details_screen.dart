import 'package:app_energy_monster/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/monster_model.dart';
import '../theme/colors.dart';
import '../services/monster_service.dart';
import '../controllers/favorites_controller.dart';
import '../controllers/cart_controller.dart';

class DetailsScreen extends StatefulWidget {
  final Monster monster;

  const DetailsScreen({super.key, required this.monster});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _cepController = TextEditingController();
  String _resultadoFrete = "";
  bool _carregandoFrete = false;

  void _calcularFrete(Color accentColor) async {
    if (_cepController.text.trim().isEmpty) return;

    setState(() {
      _carregandoFrete = true;
      _resultadoFrete = "";
    });

    final dadosCep = await MonsterService().buscarCep(_cepController.text);

    setState(() {
      _carregandoFrete = false;
      if (dadosCep != null) {
        String logradouro = dadosCep['logradouro'] != "" ? "${dadosCep['logradouro']}, " : "";
        String localidade = dadosCep['localidade'] ?? "";
        String uf = dadosCep['uf'] ?? "";
        
        _resultadoFrete = "Entrega para: $logradouro$localidade - $uf\nFrete: R\$ 8,90 (Chega em até 2 dias)";
      } else {
        _resultadoFrete = "CEP não localizado ou inválido.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Color(int.parse(widget.monster.hexColor));
    const Color primaryNeon = MonsterColors.mangoLoco;

    String categoryTag = "CLASSIC ENERGY";
    IconData categoryIcon = Icons.flash_on;

    if (widget.monster is MonsterJuice) {
      categoryTag = "JUICE - ${(widget.monster as MonsterJuice).porcentagemSuco}% SUCO";
      categoryIcon = Icons.bakery_dining;
    } else if (widget.monster is MonsterUltra) {
      categoryTag = "ULTRA - ZERO AÇÚCAR";
      categoryIcon = Icons.bolt;
    }

    return Scaffold(
      backgroundColor: MonsterColors.backgroundBlack,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
          shadows: [Shadow(color: accentColor, blurRadius: 10)],
        ),
        title: GestureDetector(
          onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
          child: const Text(
            "MONSTER STORE",
            style: TextStyle(
              color: primaryNeon,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              shadows: [
                Shadow(
                  color: primaryNeon,
                  blurRadius: 15,
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Consumer<CartController>(
              builder: (context, cartController, child) {
                final totalItens = cartController.quantidadeTotal;
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      if (totalItens > 0)
                        Positioned(
                          right: 0,
                          top: 12,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: primaryNeon,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              "$totalItens",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withOpacity(0.4),
                              blurRadius: 100,
                              spreadRadius: 20,
                            ),
                          ],
                        ),
                      ),
                      Hero(
                        tag: widget.monster.id,
                        child: SizedBox(
                          height: 420,
                          child: widget.monster.imagemUrl.startsWith('assets')
                              ? Image.asset(widget.monster.imagemUrl, fit: BoxFit.contain)
                              : Image.network(
                                  widget.monster.imagemUrl,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.local_drink, size: 100, color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: MonsterColors.cardGrey.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(color: accentColor.withOpacity(0.1), blurRadius: 20)
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: accentColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: accentColor.withOpacity(0.5)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(categoryIcon, color: accentColor, size: 14),
                                const SizedBox(width: 6),
                                Text(
                                  categoryTag,
                                  style: TextStyle(color: accentColor, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.monster.nome.toUpperCase(),
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 26, letterSpacing: 1),
                                ),
                              ),
                              Text(
                                "R\$ 12,90",
                                style: TextStyle(color: accentColor, fontWeight: FontWeight.bold, fontSize: 24, shadows: [Shadow(color: accentColor, blurRadius: 10)]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.monster.descricao,
                            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 15, height: 1.6),
                          ),
                          const SizedBox(height: 25),
                          
                          Divider(color: Colors.white.withOpacity(0.1)),
                          const SizedBox(height: 15),

                          Text(
                            "CALCULAR FRETE",
                            style: TextStyle(color: accentColor, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.5),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 48,
                                  child: TextField(
                                    controller: _cepController,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.white, fontSize: 14),
                                    decoration: InputDecoration(
                                      hintText: "00000-000",
                                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                                      prefixIcon: Icon(Icons.location_on_outlined, color: accentColor, size: 18),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: accentColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: accentColor.withOpacity(0.15),
                                    foregroundColor: accentColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(color: accentColor.withOpacity(0.5)),
                                    ),
                                  ),
                                  onPressed: _carregandoFrete ? null : () => _calcularFrete(accentColor),
                                  child: _carregandoFrete
                                      ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: accentColor, strokeWidth: 2))
                                      : const Text("CALCULAR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                ),
                              ),
                            ],
                          ),
                          if (_resultadoFrete.isNotEmpty) ...[
                            const SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.03),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white.withOpacity(0.05)),
                              ),
                              child: Text(
                                _resultadoFrete,
                                style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13, height: 1.4),
                              ),
                            ),
                          ],
                          const SizedBox(height: 35),

                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                foregroundColor: Colors.black,
                                elevation: 10,
                                shadowColor: accentColor.withOpacity(0.4),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: () {
                                Provider.of<CartController>(context, listen: false)
                                    .adicionarAoCarrinho(widget.monster);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${widget.monster.nome.toUpperCase()} ADICIONADO AO CARRINHO!",
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    backgroundColor: accentColor,
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: const Text("ADICIONAR AO CARRINHO", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Consumer<FavoritesController>(
                          builder: (context, favController, child) {
                            final isFav = favController.isFavorite(widget.monster.id);
                            return IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                              color: isFav ? accentColor : Colors.white,
                              iconSize: 30,
                              onPressed: () => favController.toggleFavorite(widget.monster.id),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/colors.dart';
import '../controllers/cart_controller.dart';
import 'details_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryNeon = MonsterColors.mangoLoco;

    return Scaffold(
      backgroundColor: MonsterColors.backgroundBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: GestureDetector(
          child: const Text(
            "MINHA SACOLA",
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
      ),
      body: Consumer<CartController>(
        builder: (context, cartController, child) {
          final itens = cartController.itens;

          if (itens.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "SUA SACOLA ESTÁ VAZIA",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: itens.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = itens[index];
                    final Color cardColor = Color(int.parse(item.monster.hexColor));

                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(monster: item.monster),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        height: 155,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              MonsterColors.cardGrey,
                              cardColor.withOpacity(0.2),
                            ],
                            begin: Alignment.topLeft,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: cardColor,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: cardColor.withOpacity(0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Hero(
                              tag: item.monster.id,
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: cardColor.withOpacity(0.3),
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  item.monster.imagemUrl,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.monster.nome.toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 17,
                                            shadows: [Shadow(color: cardColor, blurRadius: 10)],
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          item.monster.descricao,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.8),
                                            fontSize: 13,
                                            height: 1.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: cardColor.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: cardColor.withOpacity(0.6), width: 1.5),
                                      ),
                                      child: Text(
                                        "R\$ ${(12.90 * item.quantidade).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: cardColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: const Icon(Icons.remove_circle_outline, color: Colors.white24, size: 22),
                                      onPressed: () => cartController.diminuirQuantidade(item.monster.id),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "${item.quantidade}",
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    const SizedBox(width: 4),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: Icon(Icons.add_circle_outline, color: cardColor, size: 22),
                                      onPressed: () => cartController.adicionarAoCarrinho(item.monster),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: GestureDetector(
                                    onTap: () => cartController.removerItemCompleto(item.monster.id),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.redAccent.withOpacity(0.4),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: MonsterColors.cardGrey,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    )
                  ],
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "TOTAL VALOR:",
                            style: TextStyle(color: Colors.white60, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            "R\$ ${cartController.valorTotal.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: primaryNeon,
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                              shadows: [Shadow(color: primaryNeon, blurRadius: 10)],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryNeon,
                            foregroundColor: Colors.black,
                            elevation: 10,
                            shadowColor: primaryNeon.withOpacity(0.4),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {
                            cartController.limparCarrinho();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "PEDIDO ENVIADO! SUA ENERGIA ESTÁ A CAMINHO.",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: primaryNeon,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "FINALIZAR COMPRA",
                            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
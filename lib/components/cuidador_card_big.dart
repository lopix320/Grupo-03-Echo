import 'package:flutter/material.dart';
import 'package:pi_flutter/views/paciente_page.dart';

class CuidadorCardBig extends StatelessWidget {
  String nome;

  CuidadorCardBig({super.key, required this.nome});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Imagem de perfil
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, width: 2),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Center(
                  child:
                      Icon(Icons.person, size: 240, color: Colors.grey[500])),
            ),
          ),

          SizedBox(height: 10),

          // Ícones abaixo da imagem

          SizedBox(height: 10),

          // Nome e nível de dependência

          SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                nome,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,

                  color: Colors.black, // Cor do texto específica
                ),
              ),
            ),
          ),
          // SizedBox(height: 10),

          // Barra de nível de dependência
        ],
      ),
    );
  }

  // Função auxiliar para criar as barras de nível de dependência
  Widget _buildBar(Color color, width) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        width: 4,
        height: width,
        color: color,
      ),
    );
  }
}

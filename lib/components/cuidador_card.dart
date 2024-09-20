import 'package:flutter/material.dart';
import 'package:pi_flutter/views/cuidador_page.dart';
import 'package:pi_flutter/views/paciente_page.dart';

class CuidadorCard extends StatelessWidget {
  String nome;

  CuidadorCard({super.key, required this.nome});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
            //-- Para eliminar o botao voltar da HomePage
            MaterialPageRoute(builder: (context) => CuidadorPage()));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Imagem de perfil
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child:
                        Icon(Icons.person, size: 50, color: Colors.grey[500]),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Ícones abaixo da imagem
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    size: 24,
                    color: Colors.yellow,
                  ),
                  SizedBox(width: 10),
                  const Icon(
                    Icons.star,
                    size: 24,
                    color: Colors.yellow,
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.star,
                    size: 24,
                    color: Colors.grey[300],
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: 10),

              // Nome e nível de dependência
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  nome,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,

                    color: Colors.black, // Cor do texto específica
                  ),
                ),
              ),
              SizedBox(height: 5),

              // SizedBox(height: 10),

              // Barra de nível de dependência
            ],
          ),
        ),
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

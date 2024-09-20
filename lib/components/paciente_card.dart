import 'package:flutter/material.dart';
import 'package:pi_flutter/views/paciente_page.dart';

class PacienteCard extends StatelessWidget {
  String nome;

  PacienteCard({super.key, required this.nome});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
            //-- Para eliminar o botao voltar da HomePage
            MaterialPageRoute(builder: (context) => PacientePage()));
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assist_walker, size: 24),
                  SizedBox(width: 10),
                  Icon(Icons.local_convenience_store, size: 24),
                  SizedBox(width: 10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.other_houses, size: 24),
                      Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Icon(
                          Icons.favorite,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),

              // Nome e nível de dependência
              Align(
                alignment: Alignment.centerLeft,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Nível de dependência:',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ...List.generate(
                          3, (index) => _buildBar(Colors.lightGreen, 18.0)),
                      ...List.generate(
                          2, (index) => _buildBar(Colors.orange, 20.0)),
                      ...List.generate(
                          1, (index) => _buildBar(Colors.red, 22.0)),
                    ],
                  ),
                ],
              ),
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

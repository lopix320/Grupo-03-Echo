import 'package:flutter/material.dart';
import 'package:pi_flutter/util/FontSizeProvider.dart';
import 'package:pi_flutter/views/cuidador_page.dart';
import 'package:pi_flutter/views/paciente_page.dart';
import 'package:provider/provider.dart';

class CuidadorCard extends StatelessWidget {
  dynamic cuidador;

  CuidadorCard({super.key, required this.cuidador});

  double calcularMediaNotas() {
    // Acessar o array 'contratacoes'
    List<dynamic> contratacoes = this.cuidador['cuidador'][0]['contratacoes'];

    // Verificar se o array é válido e contém elementos
    if (contratacoes.isNotEmpty) {
      double somaNotas =
          contratacoes.fold(0.0, (soma, item) => soma + item['nota']);
      return somaNotas / contratacoes.length;
    } else {
      return 0.0; // Retorna 0.0 se não houver notas
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);

    var mediaNota = this.cuidador['cuidador'][0]['contratacoes'];

    print("meu cuidador $cuidador");
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          //-- Para eliminar o botao voltar da HomePage
          MaterialPageRoute(
            builder: (context) => CuidadorPage(
              cuidador: this.cuidador,
            ),
          ),
        );
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
                children: List.generate(3, (index) {
                  return Icon(
                    Icons.star,
                    color: index < calcularMediaNotas()
                        ? Colors.yellow
                        : Colors.grey,
                    size: 40,
                  );
                }),
              ),
              SizedBox(height: 10),

              // Nome e nível de dependência
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  cuidador['nome'],
                  style: TextStyle(
                    fontSize: fontSizeProvider.fontSize,
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

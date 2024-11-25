import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:pi_flutter/components/cuidador_card.dart';
import 'package:pi_flutter/components/paciente_card.dart';

import 'package:http/http.dart' as http;
import 'package:pi_flutter/util/FontSizeProvider.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');

    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  Future<List<dynamic>> fetchUsers() async {
    try {
      // URL da API (substitua pelo endpoint real)
      dynamic user = await getUser();
      dynamic paciente = user['user'][0]['paciente'].length > 0;

      dynamic url;
      dynamic response;
      if (paciente) {
        url = Uri.parse('http://10.0.2.2:4445/usuario/getAll');
        response = await http.get(url);
      } else {
        dynamic id_cuidador = user['user'][0]['cuidador'][0]['id_cuidador'];
        url = Uri.parse('http://10.0.2.2:4445/usuario/getPacientesCuidador');
        response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'id_cuidador': id_cuidador}),
        );
      }

      // Realizando a requisição GET

      // Verifica se a resposta foi bem-sucedida
      if (response.statusCode == 200) {
        // Decodifica o corpo da resposta
        final data = jsonDecode(response.body);
        print(data);
        // Mapeando a lista de pacientes (ajuste a chave conforme o formato da sua API)
        List<dynamic> usuarios = List<dynamic>.from(data['usuarios']);

        dynamic user = await getUser();

        print(usuarios);

        dynamic filteredUsers;

        if (user['user'][0]['paciente'].length > 0) {
          filteredUsers = usuarios
              .where((usuario) => usuario['cuidador'].length > 0)
              .toList();
        }
        if (user['user'][0]['cuidador'].length > 0) {
          filteredUsers = usuarios
              .where((usuario) => usuario['paciente'].length > 0)
              .toList();
        }

        return filteredUsers;
      } else {
        throw Exception(
            'Erro ao buscar pacientes: Código ${response.statusCode}');
      }
    } catch (e) {
      // Lida com erros de conexão ou outros
      throw Exception('Erro ao buscar pacientes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          children: [
            FutureBuilder(
              future: getUser(),
              builder: (context, snapshot) {
                print('teste 2: ${snapshot.data}');
                var usuario = snapshot.data!['user'][0];
                if (usuario['paciente'].length > 0) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        Text(
                          "Cuidadores:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  );
                } else if (usuario['cuidador'].length > 0) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        Text(
                          "Pacientes que querem entrar em contato:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      Text(
                        "Cuidador:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                );
              },
            ),
            FutureBuilder<List<dynamic>>(
              future: fetchUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Erro: ${snapshot.error}"),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("Nenhum dado encontrado."),
                  );
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 colunas
                      crossAxisSpacing: 4, // Espaçamento entre colunas
                      mainAxisSpacing: 4, // Espaçamento entre linhas
                      childAspectRatio:
                          0.7, // Proporção da largura para a altura do card
                    ),
                    itemBuilder: (context, index) {
                      if (snapshot.data![index]['paciente'].length > 0) {
                        return PacienteCard(paciente: snapshot.data![index]);
                      } else {
                        return CuidadorCard(
                          cuidador: snapshot.data![index],
                        );
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}





// Container(
//               height: MediaQuery.of(context).size.height * 1.4,
//               child: FutureBuilder(
//                 future: ProductRepository(
//                         apiProduct: ApiProduct(httpClient: http.Client()))
//                     .getProduct(8),
//                 builder: (context, snapshot) {
//                   // print(product);
//                   if (snapshot.hasError) {
//                     return Text('${snapshot.error}');
//                   } else if (snapshot.hasData) {
//                     product = snapshot.data as List<dynamic>;
//                     return GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: productFiltered.isNotEmpty
//                           ? productFiltered.length
//                           : product.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithMaxCrossAxisExtent(
//                               maxCrossAxisExtent: 200,
//                               childAspectRatio: 0.6,
//                               crossAxisSpacing: 20,
//                               mainAxisSpacing: 30),
//                       primary: false,
//                       padding: const EdgeInsets.all(8),
//                       itemBuilder: ((context, index) {
//                         return GestureDetector(
//                           onTap: () => Navigator.of(context).push(
//                             //-- Para eliminar o botao voltar da HomePage
//                             MaterialPageRoute(
//                               builder: (context) => ProdutoPage(
//                                 product: product[index],
//                               ),
//                             ),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 height: 170,
//                                 width: 150,
//                                 padding: const EdgeInsets.all(8),
//                                 // color: Colors.teal[100],
//                                 decoration: BoxDecoration(
//                                   color: Color.fromARGB(255, 255, 255, 255),
//                                   image: DecorationImage(
//                                     image: NetworkImage(
//                                         productFiltered.isNotEmpty
//                                             ? productFiltered[index].image
//                                             : product[index].image),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
//                                 child: Text(
//                                   productFiltered.isNotEmpty
//                                       ? productFiltered[index].title
//                                       : product[index].title,
//                                   style: const TextStyle(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
//                                 child: Text(
//                                   "R\$ ${productFiltered.isNotEmpty ? productFiltered[index].price : product[index].price}",
//                                   style: const TextStyle(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.red),
//                                 ),
//                               )
//                             ],
//                           ),
//                         );
//                       }),
//                     );
//                   } else {
//                     return GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: 5,
//                       gridDelegate:
//                           const SliverGridDelegateWithMaxCrossAxisExtent(
//                               maxCrossAxisExtent: 200,
//                               childAspectRatio: 0.6,
//                               crossAxisSpacing: 20,
//                               mainAxisSpacing: 30),
//                       primary: false,
//                       padding: const EdgeInsets.all(8),
//                       itemBuilder: ((context, index) {
//                         return GestureDetector(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Shimmer.fromColors(
//                                 baseColor: Color.fromARGB(255, 193, 193, 193),
//                                 highlightColor:
//                                     Color.fromARGB(255, 255, 255, 255),
//                                 child: Container(
//                                   height: 170,
//                                   width: 150,
//                                   padding: const EdgeInsets.all(8),
//                                   // color: Colors.teal[100],
//                                   decoration: BoxDecoration(
//                                     color: Color.fromARGB(255, 221, 221, 221),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
//                                 child: Shimmer.fromColors(
//                                   baseColor: Color.fromARGB(255, 193, 193, 193),
//                                   highlightColor:
//                                       Color.fromARGB(255, 255, 255, 255),
//                                   child: Container(
//                                     height: 30,
//                                     width: 150,
//                                     padding: const EdgeInsets.all(8),
//                                     // color: Colors.teal[100],
//                                     decoration: BoxDecoration(
//                                       color: Color.fromARGB(255, 221, 221, 221),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
//                                 child: Shimmer.fromColors(
//                                   baseColor: Color.fromARGB(255, 193, 193, 193),
//                                   highlightColor:
//                                       Color.fromARGB(255, 255, 255, 255),
//                                   child: Container(
//                                     height: 20,
//                                     width: 60,
//                                     padding: const EdgeInsets.all(8),
//                                     // color: Colors.teal[100],
//                                     decoration: BoxDecoration(
//                                       color: Color.fromARGB(255, 221, 221, 221),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }),
//                     );
//                   }
//                 },
//               ),
//             )
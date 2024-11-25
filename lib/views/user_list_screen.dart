import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  dynamic users;
  bool isLoading = true;
  int selectedStars = 0;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<bool> onSubmit(stars, comment, id_cuidador) async {
    try {
      dynamic user = await getUser();
      dynamic id_paciente = user['user'][0]['paciente'][0]['id_paciente'];

      Map body = {
        'stars': stars,
        'comment': comment,
        'id_cuidador': id_cuidador,
        'id_paciente': id_paciente
      };

      print(body);

      final response = await http.post(
        Uri.parse('http://10.0.2.2:4445/usuario/setAvaliacao'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['ok']) {
          print('Contratacao feita ');
        }

        // Salvar informações do usuário no SharedPreferences

        return true;
      } else {
        print('Erro na requisição: ${response.statusCode} ');
        return false;
      }
    } catch (e) {
      print('Erro na requisição: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');

    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  Future<void> fetchUsers() async {
    dynamic user = await getUser();
    dynamic id_paciente = user['user'][0]['paciente'][0]['id_paciente'];

    Map body = {
      'id_paciente': id_paciente,
    };

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:4445/usuario/getCuidadores'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        // print(json.decode(response.body));
        setState(() {
          users = json.decode(response.body);

          isLoading = false;
        });
      } else {
        throw Exception('Failed to load users');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print(error);
    }
  }

  void showRatingModal(
      BuildContext context, String userName, dynamic id_cuidador) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(builder: (context, setModalState) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).viewInsets.bottom, // Adapta ao teclado
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Avaliar $userName',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return IconButton(
                      onPressed: () {
                        setModalState(() {
                          selectedStars = index + 1;
                        });
                        print(selectedStars);
                        // Navigator.pop(context, selectedStars);
                      },
                      icon: Icon(
                        Icons.star,
                        color:
                            index < selectedStars ? Colors.yellow : Colors.grey,
                        size: 40,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Deixe um comentário (opcional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Lógica para enviar a avaliação para o backend
                    print("Usuário avaliado com $selectedStars estrela(s)");
                    print("comment: ${commentController.value.text}");
                    await onSubmit(selectedStars, commentController.value.text,
                        id_cuidador);
                    Navigator.pop(context);
                  },
                  child: const Text('Confirmar Avaliação'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    'Lista de cuidadores contratados:',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: users['usuarios'].length,
                  itemBuilder: (context, index) {
                    print("meu user: $users");
                    final user =
                        users['usuarios'][index]['cuidador']['usuario'];
                    final id_cuidador =
                        users['usuarios'][index]['cuidador']['id_cuidador'];
                    return ListTile(
                      title: Text(user['nome']),
                      subtitle: Text(user['email']),
                      onTap: () =>
                          showRatingModal(context, user['nome'], id_cuidador),
                    );
                  },
                ),
              ],
            ),
    );
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:listafilmes/models/filme.dart';

class FilmeController {
  final String baseUrl =
      "https://lista-de-filmes-e422c-default-rtdb.firebaseio.com/";
  final List<Filme> _filmes = [];

  Future<List<Filme>> getItems({bool? assistido}) async {
    final response = await http.get(Uri.parse('$baseUrl/filmes.json'));
    _filmes.clear();

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      bool filtraDados = assistido != null;

      data.forEach((filmeId, filmeData) {
        bool mostraDados = true;
        if (filtraDados) {
          if (filmeData['assistido'] != assistido) {
            mostraDados = false;
          }
        }
        if (mostraDados) {
          _filmes.add(Filme(
            id: filmeId,
            titulo: filmeData['titulo'],
            genero: filmeData['genero'],
            anoLancamento: filmeData['anoLancamento'],
            assistido: filmeData['assistido'],
          ));
        }
      });

      return _filmes;
    } else {
      throw Exception('Erro ao obter os dados: ${response.statusCode}');
    }
  }

  Future<void> addItem(Filme filme) async {
    final response = await http.post(
      Uri.parse('$baseUrl/filmes.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(filme.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao adicionar filme: ${response.statusCode}');
    }
  }

  Future<void> updateItem(Filme filme) async {
    final response = await http.put(
      Uri.parse('$baseUrl/filmes/${filme.id}.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(filme.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar filme: ${response.statusCode}');
    }
  }

  Future<void> deleteItem(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/filmes/$id.json'),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar filme: ${response.statusCode}');
    }
  }
}

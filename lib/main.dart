import 'package:flutter/material.dart';
import 'package:listafilmes/controller/FilmeController.dart';
import 'package:listafilmes/models/filme.dart';

main() {
  runApp(const ListaFilmes());
}

class ListaFilmes extends StatelessWidget {
  const ListaFilmes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lista de Filmes",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListaFilmesPage(),
    );
  }
}

class ListaFilmesPage extends StatefulWidget {
  const ListaFilmesPage({super.key});

  @override
  State<ListaFilmesPage> createState() => _ListaFilmesPageState();
}

class _ListaFilmesPageState extends State<ListaFilmesPage> {
  final FilmeController filmeController = FilmeController();
  late Future<List<Filme>> _listaFilmes;
  bool _mostraSomenteNaoAssistidos = false;

  @override
  void initState() {
    super.initState();
    _listaFilmes = filmeController.getItems();
  }

  void _chamaItens() {
    setState(() {
      _listaFilmes = filmeController.getItems(
          assistido: _mostraSomenteNaoAssistidos ? false : null);
    });
  }

  void _refreshList() {
    setState(() {
      _listaFilmes = filmeController.getItems();
    });
  }

  void _showForm([Filme? film]) {
    final formKey = GlobalKey<FormState>();
    String titulo = film?.titulo ?? '';
    String genero = film?.genero ?? '';
    int anoLancamento = film?.anoLancamento ?? 0;
    bool assistido = film?.assistido ?? false;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(film == null ? "Adicionar Filme" : "Editar Filme"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: titulo,
                  decoration: const InputDecoration(labelText: "Título"),
                  onSaved: (value) => titulo = value!,
                ),
                TextFormField(
                  initialValue: genero,
                  decoration: const InputDecoration(labelText: "Gênero"),
                  onSaved: (value) => genero = value!,
                ),
                TextFormField(
                  initialValue: anoLancamento.toString(),
                  decoration:
                      const InputDecoration(labelText: "Ano de Lançamento"),
                  onSaved: (value) => anoLancamento = int.parse(value!),
                  keyboardType: TextInputType.number,
                ),
                CheckboxListTile(
                  value: assistido,
                  title: const Text('Assistido'),
                  onChanged: (value) => setState(() => assistido = value!),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar")),
            TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    final novoFilme = Filme(
                      id: film?.id,
                      titulo: titulo,
                      genero: genero,
                      anoLancamento: anoLancamento,
                      assistido: assistido,
                    );
                    if (film == null) {
                      filmeController
                          .addItem(novoFilme)
                          .then((_) => _refreshList());
                    } else {
                      filmeController
                          .updateItem(novoFilme)
                          .then((value) => _refreshList());
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Salvar"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Filmes'),
        actions: [
          Switch(
            value: _mostraSomenteNaoAssistidos,
            onChanged: (value) {
              setState(() {
                _mostraSomenteNaoAssistidos = value;
                _chamaItens();
              });
            },
            activeColor: Colors.green,
            inactiveThumbColor: Colors.red,
          ),
        ],
      ),
      body: FutureBuilder<List<Filme>>(
        future: _listaFilmes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Sem filmes!'),
            );
          }

          final filmeslista = snapshot.data!;
          return ListView.builder(
            itemCount: filmeslista.length,
            itemBuilder: (context, index) {
              final filme = filmeslista[index];
              return ListTile(
                title: Text(filme.titulo),
                subtitle: Text('Ano de lançamento: ${filme.anoLancamento}'),
                trailing: Checkbox(
                  value: filme.assistido,
                  onChanged: (value) {
                    setState(() {
                      filme.assistido = value!;
                    });
                    filmeController.updateItem(filme);
                  },
                ),
                onLongPress: () => _showForm(filme),
                onTap: () => _showForm(filme),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

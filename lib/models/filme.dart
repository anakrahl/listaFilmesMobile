class Filme {
  final String? id;
  final String titulo;
  final String genero;
  final int anoLancamento;
  bool assistido;

  Filme(
      {this.id,
      required this.titulo,
      required this.genero,
      required this.anoLancamento,
      required this.assistido});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'genero': genero,
      'anoLancamento': anoLancamento,
      'assistido': assistido
    };
  }
}

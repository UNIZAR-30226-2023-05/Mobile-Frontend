// Crea una clase para representar la respuesta completa
class RankingResponse {
  bool ok;
  String message;
  List<Ranking> ranking;

  RankingResponse(
      {required this.ok, required this.message, required this.ranking});

  factory RankingResponse.fromJson(Map<String, dynamic> json) {
    return RankingResponse(
      ok: json['ok'],
      message: json['message'],
      ranking:
          (json['ranking'] as List).map((i) => Ranking.fromJson(i)).toList(),
    );
  }
}

// Crea una clase para representar a cada jugador en el ranking
class Ranking {
  String usuario;
  int vecesoca;

  Ranking({required this.usuario, required this.vecesoca});

  factory Ranking.fromJson(Map<String, dynamic> json) {
    return Ranking(
      usuario: json['usuario'],
      vecesoca: json['vecesoca'],
    );
  }
}

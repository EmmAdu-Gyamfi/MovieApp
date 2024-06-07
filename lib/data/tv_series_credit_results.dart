import 'package:movie_app/data/tv_series_credits.dart';

class TvSeriesCreditResults {
  TvSeriesCreditResults({
    required this.cast,
    required this.crew,
    required this.id,
  });
  late final List<Cast> cast;
  late final List<dynamic> crew;
  late final int id;

  TvSeriesCreditResults.fromJson(Map<String, dynamic> json){
    cast = List.from(json['cast']).map((e)=>Cast.fromJson(e)).toList();
    crew = List.castFrom<dynamic, dynamic>(json['crew']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cast'] = cast.map((e)=>e.toJson()).toList();
    _data['crew'] = crew;
    _data['id'] = id;
    return _data;
  }
}


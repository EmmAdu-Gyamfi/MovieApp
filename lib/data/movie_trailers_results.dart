import 'package:movie_app/data/movie_trailers.dart';

class MovieTrailersResults {
  MovieTrailersResults({
    required this.id,
    required this.results,
  });
  late final int id;
  late final List<MovieTrailers>? results;

  MovieTrailersResults.fromJson(Map<String, dynamic> json){
    id = json['id'];
    results = List.from(json['results']).map((e)=>MovieTrailers.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['results'] = results!.map((e)=>e.toJson()).toList();
    return _data;
  }
}


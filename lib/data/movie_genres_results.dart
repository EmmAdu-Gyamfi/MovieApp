import 'package:movie_app/data/movie_genres.dart';

class MovieGenresResults {
  MovieGenresResults({
    required this.genres,
  });
  late final List<MovieGenres> genres;

  MovieGenresResults.fromJson(Map<String, dynamic> json){
    genres = List.from(json['genres']).map((e)=>MovieGenres.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['genres'] = genres.map((e)=>e.toJson()).toList();
    return _data;
  }
}
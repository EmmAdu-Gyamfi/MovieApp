import 'package:movie_app/data/tv_series_genres.dart';

class TvSeriesGenresResults {
  TvSeriesGenresResults({
    required this.genres,
  });
  late final List<TvSeriesGenres> genres;

  TvSeriesGenresResults.fromJson(Map<String, dynamic> json){
    genres = List.from(json['genres']).map((e)=>TvSeriesGenres.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['genres'] = genres.map((e)=>e.toJson()).toList();
    return _data;
  }
}


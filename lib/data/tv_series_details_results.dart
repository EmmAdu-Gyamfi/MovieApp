import 'package:movie_app/data/tv_series_genre_details.dart';

class TvSeriesDetailsResults {
  TvSeriesDetailsResults({
    required this.genres,
  });
  late final List<Genres> genres;


  TvSeriesDetailsResults.fromJson(Map<String, dynamic> json){

    genres = List.from(json['genres']).map((e)=>Genres.fromJson(e)).toList();

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['genres'] = genres.map((e)=>e.toJson()).toList();

    return _data;
  }
}

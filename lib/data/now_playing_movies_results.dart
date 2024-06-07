import 'package:movie_app/data/now_playing_movies.dart';

class NowPlayingMoviesResults {
  NowPlayingMoviesResults({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
  late final Dates dates;
  late final int page;
  late final List<NowPlayingMovies> results;
  late final int totalPages;
  late final int totalResults;

  NowPlayingMoviesResults.fromJson(Map<String, dynamic> json){
    dates = Dates.fromJson(json['dates']);
    page = json['page'];
    results = List.from(json['results']).map((e)=>NowPlayingMovies.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dates'] = dates.toJson();
    _data['page'] = page;
    _data['results'] = results.map((e)=>e.toJson()).toList();
    _data['total_pages'] = totalPages;
    _data['total_results'] = totalResults;
    return _data;
  }
}

class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });
  late final String maximum;
  late final String minimum;

  Dates.fromJson(Map<String, dynamic> json){
    maximum = json['maximum'];
    minimum = json['minimum'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['maximum'] = maximum;
    _data['minimum'] = minimum;
    return _data;
  }
}


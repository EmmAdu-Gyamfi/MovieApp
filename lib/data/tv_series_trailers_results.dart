import 'package:movie_app/data/tv_series_trailers.dart';

class TvSeriesTrailersResults {
  TvSeriesTrailersResults({
    required this.id,
    required this.results,
  });
  late final int id;
  late final List<TvSeriesTrailers>? results;

  TvSeriesTrailersResults.fromJson(Map<String, dynamic> json){
    id = json['id'];
    results = List.from(json['results']).map((e)=>TvSeriesTrailers.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['results'] = results!.map((e)=>e.toJson()).toList();
    return _data;
  }
}


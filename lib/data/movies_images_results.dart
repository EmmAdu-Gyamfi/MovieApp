import 'movie_images.dart';

class MovieImagesResults {
  MovieImagesResults({
    required this.backdrops,
    required this.id,
    required this.logos,
    required this.posters,
  });
  late final List<MovieImages> backdrops;
  late final int id;
  late final List<Logos> logos;
  late final List<Posters> posters;

  MovieImagesResults.fromJson(Map<String, dynamic> json){
    backdrops = List.from(json['backdrops']).map((e)=>MovieImages.fromJson(e)).toList();
    id = json['id'];
    logos = List.from(json['logos']).map((e)=>Logos.fromJson(e)).toList();
    posters = List.from(json['posters']).map((e)=>Posters.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['backdrops'] = backdrops.map((e)=>e.toJson()).toList();
    _data['id'] = id;
    _data['logos'] = logos.map((e)=>e.toJson()).toList();
    _data['posters'] = posters.map((e)=>e.toJson()).toList();
    return _data;
  }
}



class Logos {
  Logos({
    required this.aspectRatio,
    required this.height,
    required this.iso_639_1,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });
  late final double aspectRatio;
  late final int height;
  late final String iso_639_1;
  late final String filePath;
  late final double? voteAverage;
  late final int voteCount;
  late final int width;

  Logos.fromJson(Map<String, dynamic> json){
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso_639_1 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = double.tryParse(json['vote_average'].toString());
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['aspect_ratio'] = aspectRatio;
    _data['height'] = height;
    _data['iso_639_1'] = iso_639_1;
    _data['file_path'] = filePath;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    _data['width'] = width;
    return _data;
  }
}

class Posters {
  Posters({
    required this.aspectRatio,
    required this.height,
    required this.iso_639_1,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });
  late final double aspectRatio;
  late final int height;
  late final String? iso_639_1;
  late final String filePath;
  late final double? voteAverage;
  late final int voteCount;
  late final int width;

  Posters.fromJson(Map<String, dynamic> json){
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso_639_1 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['aspect_ratio'] = aspectRatio;
    _data['height'] = height;
    _data['iso_639_1'] = iso_639_1;
    _data['file_path'] = filePath;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    _data['width'] = width;
    return _data;
  }
}
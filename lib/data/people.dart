class People {
  People({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.gender,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });
  late final bool adult;
  late final List<String> alsoKnownAs;
  late final String biography;
  late final String birthday;
  late final String deathday;
  late final int gender;
  late final String homepage;
  late final int id;
  late final String imdbId;
  late final String knownForDepartment;
  late final String name;
  late final String placeOfBirth;
  late final double popularity;
  late final String profilePath;

  People.fromJson(Map<String, dynamic> json){
    adult = json['adult'];
    alsoKnownAs = List.castFrom<dynamic, String>(json['also_known_as']);
    biography = json['biography'];
    birthday = json['birthday'];
    deathday = json['deathday'];
    gender = json['gender'];
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    placeOfBirth = json['place_of_birth'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['adult'] = adult;
    _data['also_known_as'] = alsoKnownAs;
    _data['biography'] = biography;
    _data['birthday'] = birthday;
    _data['deathday'] = deathday;
    _data['gender'] = gender;
    _data['homepage'] = homepage;
    _data['id'] = id;
    _data['imdb_id'] = imdbId;
    _data['known_for_department'] = knownForDepartment;
    _data['name'] = name;
    _data['place_of_birth'] = placeOfBirth;
    _data['popularity'] = popularity;
    _data['profile_path'] = profilePath;
    return _data;
  }
}
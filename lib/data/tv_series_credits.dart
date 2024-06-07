class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.character,
    required this.creditId,
    required this.order,
  });
  late final bool adult;
  late final int gender;
  late final int id;
  late final String knownForDepartment;
  late final String name;
  late final String originalName;
  late final double popularity;
  late final String? profilePath;
  late final String character;
  late final String creditId;
  late final int order;

  Cast.fromJson(Map<String, dynamic> json){
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['adult'] = adult;
    _data['gender'] = gender;
    _data['id'] = id;
    _data['known_for_department'] = knownForDepartment;
    _data['name'] = name;
    _data['original_name'] = originalName;
    _data['popularity'] = popularity;
    _data['profile_path'] = profilePath;
    _data['character'] = character;
    _data['credit_id'] = creditId;
    _data['order'] = order;
    return _data;
  }
}
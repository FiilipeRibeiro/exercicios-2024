class ChuvaModel {
  final String title;
  final String description;
  final String category;
  final String? color;
  final String start;
  final String end;
  final String type;
  final List<LocationModel> location;
  final List<PeopleModel> people;
  bool isSaved;

  ChuvaModel({
    required this.title,
    required this.description,
    required this.category,
    this.color,
    required this.start,
    required this.end,
    required this.type,
    required this.location,
    required this.people,
    this.isSaved = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isSaved': isSaved ? 1 : 0,
    };
  }
}

class PeopleModel {
  final String? name;
  final String? institution;
  final String? picture;
  final String? bio;
  final String? role;

  PeopleModel({
    required this.name,
    this.institution,
    this.picture,
    this.bio,
    this.role,
  });
}

class LocationModel {
  final String title;

  LocationModel({
    required this.title,
  });
}

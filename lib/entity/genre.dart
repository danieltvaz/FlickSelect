class Genre {
  final String name;
  final String id;

  Genre({required this.name, required this.id});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      name: json['name'],
      id: json['id'],
    );
  }
}

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterUrl;
  final dynamic rate;
  final String releaseDate;

  Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterUrl,
      required this.rate,
      required this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        posterUrl: "https://image.tmdb.org/t/p/w500${json['poster_path']}",
        rate: json['vote_average'],
        releaseDate: json['release_date']);
  }
}

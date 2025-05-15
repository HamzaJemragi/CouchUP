class Movie {
  final int id;
  final String title;
  final String backdrop_path;
  final String poster_path;
  final String overview;
  final double popularity;
  final String release_date;
  final double vote_average;
  final int vote_count;

  Movie({
    required this.id,
    required this.title,
    required this.backdrop_path,
    required this.poster_path,
    this.overview = '',
    this.popularity = 0.0,
    this.release_date = '',
    this.vote_average = 0.0,
    this.vote_count = 0,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      backdrop_path: 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}',
      poster_path: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      overview: json['overview'],
      popularity: json['popularity'],
      release_date: json['release_date'],
      vote_average: json['vote_average'],
      vote_count: json['vote_count'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'backdrop_path': backdrop_path,
      'release_date': release_date,
      'popularity': popularity,
      'vote_average': vote_average,
      'vote_count': vote_count,
    };
  }
}
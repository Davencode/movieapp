class MovieModel {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final List<int> genreIds;

  MovieModel({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.genreIds,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? 'No title',
      originalTitle: json['original_title'] ?? 'No original title',
      overview: json['overview'] ?? 'No description',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      popularity: (json['popularity'] as num).toDouble(),
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      releaseDate: json['release_date'] ?? 'TBA',
      genreIds: List<int>.from(json['genre_ids'] ?? []),
    );
  }
}

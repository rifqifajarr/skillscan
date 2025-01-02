class Movie {
  final int movieId;
  final String movieName;
  final String posterPath;

  Movie({
    required this.movieId,
    required this.movieName,
    required this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'movie_id': int movieId,
        'movie_name': String movieName,
        'poster_path': String posterPath,
      } =>
        Movie(movieId: movieId, movieName: movieName, posterPath: posterPath),
      _ => throw FormatException('Wrong JSON Format'),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'movie_id': movieId,
      'movie_name': movieName,
      'poster_path': posterPath,
    };
  }
}

class MovieResponse {
  final List<Movie> result;

  MovieResponse({required this.result});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      result: List<Movie>.from(
        json['result'].map(
          (movie) => Movie.fromJson(movie),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result.map((movie) => movie.toJson()).toList(),
    };
  }
}

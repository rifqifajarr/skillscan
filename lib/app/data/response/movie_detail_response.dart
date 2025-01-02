class MovieDetail {
  final String desc;
  final int movieId;
  final String movieName;
  final String posterLink;
  final double rating;
  final String releaseDate;
  final int tmdbId;

  MovieDetail({
    required this.desc,
    required this.movieId,
    required this.movieName,
    required this.posterLink,
    required this.rating,
    required this.releaseDate,
    required this.tmdbId,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    final result = json['result'] as Map<String, dynamic>?;

    if (result == null) {
      throw FormatException('Missing "result" key in JSON');
    }

    try {
      return MovieDetail(
        desc: result['desc'] as String,
        movieId: result['movie_id'] as int,
        movieName: result['movie_name'] as String,
        posterLink: result['poster_link'] as String,
        rating: (result['rating'] as num).toDouble(),
        releaseDate: result['release_date'] as String,
        tmdbId: result['tmdb_id'] as int,
      );
    } catch (e) {
      throw FormatException('Error parsing MovieDetail: ${e.toString()}');
    }
  }

  // factory MovieDetail.fromJson(Map<String, dynamic> json) {
  //   return switch (json) {
  //     {
  //       'desc': String desc,
  //       'movie_id': int movieId,
  //       'movie_name': String movieName,
  //       'poster_link': String posterLink,
  //       'rating': double rating,
  //       'release_date': String releaseDate,
  //       'tmdb_id': int tmdbId
  //     } =>
  //       MovieDetail(
  //         desc: desc,
  //         movieId: movieId,
  //         movieName: movieName,
  //         posterLink: posterLink,
  //         rating: rating,
  //         releaseDate: releaseDate,
  //         tmdbId: tmdbId,
  //       ),
  //     _ => throw FormatException('Wrong JSON Format'),
  //   };
  // }
}

class MovieModel {
  final int id;
  final String title;
  final String year;
  final String overview;
  final String type;
  final String poster;
  final double rate;
  final int count;
  final String backdrop;
  final String favorite;

  MovieModel({
    required this.id,
    required this.title,
    required this.year,
    required this.overview,
    required this.type,
    required this.poster,
    required this.rate,
    required this.count,
    required this.backdrop,
    required this.favorite,
  });

  static MovieModel fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] is int ? json['id'] : 0,

      title: (json['title'] ?? json['name'] ?? 'Unknown').toString(),

      year: (json['release_date'] ?? json['first_air_date'] ?? 'Unknown Year')
          .toString(),

      overview: (json['overview'] ?? 'No overview available').toString(),

      type: (json['media_type'] ?? 'Unknown').toString(),

      poster: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : 'https://tse2.mm.bing.net/th/id/OIP.Skr-oJ6BWg_K65k5uDiMdgHaHa?rs=1&pid=ImgDetMain&o=7&rm=3',

      rate: json['vote_average'] != null
          ? double.tryParse(json['vote_average'].toString()) ?? 0.0
          : 0.0,

      count: json['vote_count'] != null
          ? int.tryParse(json['vote_count'].toString()) ?? 0
          : 0,

      backdrop: json['backdrop_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}'
          : 'https://tse2.mm.bing.net/th/id/OIP.Skr-oJ6BWg_K65k5uDiMdgHaHa?rs=1&pid=ImgDetMain&o=7&rm=3',

      favorite: (json['favorite'] ?? 'false').toString(),
    );
  }

  /// ✅ للتخزين في قاعدة البيانات
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'overview': overview,
      'type': type,
      'poster': poster,
      'backdrop': backdrop,
      'rate': rate,
      'count': count,
      'favorite': favorite,
    };
  }

  /// ✅ لاسترجاع البيانات من SQLite
  factory MovieModel.fromDatabaseJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      year: json['year'],
      overview: json['overview'],
      type: json['type'],
      poster: json['poster'],
      rate: json['rate'] is double
          ? json['rate']
          : double.tryParse(json['rate'].toString()) ?? 0.0,
      count: json['count'] is int
          ? json['count']
          : int.tryParse(json['count'].toString()) ?? 0,
      backdrop: json['backdrop'] ?? '',
      favorite: json['favorite'] ?? 'false',
    );
  }
}

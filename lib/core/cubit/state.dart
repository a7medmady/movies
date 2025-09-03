abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieChangeIndex extends MovieState {}

class MovieChangeTheme extends MovieState {}


class MovieLoadingGetMovies extends MovieState {}
class MovieGetMoviesSuccess extends MovieState {}
class MovieGetMoviesError extends MovieState {
  final String errorMessage;
  MovieGetMoviesError(this.errorMessage);
}

class MovieChangePage extends MovieState {}

class MovieGetNowPlayingSuccess extends MovieState {}
class MovieGetTrendingSuccess extends MovieState {}
class MovieGetAiringTodaySuccess extends MovieState {}
class MovieGetPopularSuccess extends MovieState {}
class MovieGetTopRatedSuccess extends MovieState {}

class MovieCreateDatabase extends MovieState {}
class MovieOpenDatabase extends MovieState {}
class MovieInsertToDatabase extends MovieState {}
class MovieGetFromDatabase extends MovieState {}
class MovieUpdateDatabase extends MovieState {}
class MovieDeleteFromDatabase extends MovieState {}
class MovieGetUpComingSuccess extends MovieState {}
class MovieGetSearchSuccess extends MovieState {}


class MovieSearchLoading extends MovieState {}
class MovieSearchSuccess extends MovieState {}
class MovieSearchError extends MovieState {}
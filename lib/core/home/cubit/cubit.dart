import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:movie/core/home/cubit/state.dart';
import 'package:movie/core/home/model/movieModel.dart';
import 'package:movie/core/home/screen/favouirte.dart';
import 'package:movie/core/home/screen/home.dart';
import 'package:movie/core/home/screen/nowPlay.dart';
import 'package:movie/core/database/cachehelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());

  // define cubit to use it in the app
  static MovieCubit get(context) => BlocProvider.of(context);


  // LogIn
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future signIn() async{
    try {
      emit(SignInLoading());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text,
        );
      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignInError(e.code));
    } catch (e) {
      emit(SignInError(e.toString()));
    }
  }

  // Register 
  TextEditingController nameController = TextEditingController();
  TextEditingController emailUpController = TextEditingController();
  // TextEditingController locationController = TextEditingController();
  TextEditingController passwordUpController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  Future signUp() async{
    try {
      emit(SignUpLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailUpController.text, 
        password: passwordUpController.text,
        ); 
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignUpError(e.code));
    } catch (e) {
      emit(SignUpError(e.toString())); 
    }
  }

  // email forget
  TextEditingController emailForgetController = TextEditingController();
  Future forgetPassword() async{
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: emailForgetController.text,
      );
  }
  // signin with google
  Future<UserCredential> signInWithGoogle() async {
   try {
    emit(SignInWithGoogleLoading());
    // Trigger the authentication flow
   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  // Once signed in, return the UserCredential
  emit(SignInWithGoogleSuccess());
  return await FirebaseAuth.instance.signInWithCredential(credential);
 } on FirebaseAuthException catch (e) {
  emit(SignInWithGoogleError(e.code));
  throw Exception(e.code);
 } 
}


 // signin with facebook
  Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();
  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}


// //signin with anonymous
//   Future<void> signInAnonymously() async {
//     try {
//   final UserCredential userCredential =
//       await FirebaseAuth.instance.signInAnonymously();
//   debugPrint("Signed in with temporary account.");
// } on FirebaseAuthException catch (e) {
//   switch (e.code) {
//     case "operation-not-allowed":
//       debugPrint("Anonymous auth hasn't been enabled for this project.");
//       break;
//     default:
//       debugPrint("Unknown error.");
//   }
// }
//   }

// signout
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }


  // change body
  int currentIndex = 1;
  List<Widget> screens = [NowPlay(), HomeScreen(), Favouirte()];

  List<String> titles = ['Now Playing', 'Movie', 'Favouirte'];

  int changeIndex(int index) {
    currentIndex = index;
    emit(MovieChangeIndex());
    return currentIndex;
  }

  // change mode (dark- light)
  bool isDark = Cachehelper.getData(key: 'isDark') ?? false;
  void changeTheme() {
    isDark = !isDark;
    Cachehelper.saveData(key: 'isDark', value: isDark);
    emit(MovieChangeTheme());
  }

  // pagination
  List<String> pages = ['1', '2', '3', '4', '5'];
  String indexPage = '1';
  void changeIndexPage(int index) {
    indexPage = pages[index];
    emit(MovieChangePage());
    getMovies();
    getAiringToday();
    getUpComing();
    getNowPlaying();
    getPopularMovies();
    getTopRatedMovies();
  }

  int getSelectedIndex() {
    return pages.indexOf(indexPage);
  }

  final Dio dio = Dio();

  // trending
  List<MovieModel> movies = [];
  Future<void> getMovies() async {
    try {
      emit(MovieLoadingGetMovies());
      final response = await dio.get(
        'https://api.themoviedb.org/3/trending/movie/day',
        queryParameters: {
          'api_key': '63474a134d42a1598125192db516f9e9',
          "adult": false,
          'page': indexPage,
        },
      );
      movies.clear();
      for (var item in response.data['results']) {
        movies.add(MovieModel.fromJson(item));
      }
      emit(MovieGetMoviesSuccess());
    } catch (e) {
      emit(MovieGetMoviesError(e.toString()));
    }
  }

  // popular
  List<MovieModel> moviesPopular = [];
  Future<void> getPopularMovies() async {
    try {
      emit(MovieLoadingGetMovies());
      final response = await dio.get(
        'https://api.themoviedb.org/3/tv/popular',
        queryParameters: {
          'api_key': '63474a134d42a1598125192db516f9e9',
          "adult": false,
          'language': 'en-US',
          'page': indexPage,
        },
      );
      moviesPopular.clear();
      for (var item in response.data['results']) {
        moviesPopular.add(MovieModel.fromJson(item));
      }
      emit(MovieGetPopularSuccess());
    } catch (e) {
      emit(MovieGetMoviesError(e.toString()));
    }
  }

  // top rated
  List<MovieModel> moviesTopRated = [];
  Future<void> getTopRatedMovies() async {
    try {
      emit(MovieLoadingGetMovies());
      final response = await dio.get(
        'https://api.themoviedb.org/3/tv/top_rated',
        queryParameters: {
          'api_key': '63474a134d42a1598125192db516f9e9',
          "adult": false,
          'language': 'en-US',
          'page': indexPage,
        },
      );
      moviesTopRated.clear();
      for (var item in response.data['results']) {
        moviesTopRated.add(MovieModel.fromJson(item));
      }
      emit(MovieGetTopRatedSuccess());
    } catch (e) {
      emit(MovieGetMoviesError(e.toString()));
    }
  }

  // airing today
  List<MovieModel> airingToday = [];
  Future<void> getAiringToday() async {
    try {
      emit(MovieLoadingGetMovies());
      final response = await dio.get(
        'https://api.themoviedb.org/3/tv/airing_today',
        queryParameters: {
          'api_key': '63474a134d42a1598125192db516f9e9',
          "adult": false,
          'language': 'en-US',
          'page': indexPage,
        },
      );
      airingToday.clear();
      for (var item in response.data['results']) {
        airingToday.add(MovieModel.fromJson(item));
      }
      //print(response.data);
      emit(MovieGetAiringTodaySuccess());
    } catch (e) {
      emit(MovieGetMoviesError(e.toString()));
    }
  }

  // upcoming
  List<MovieModel> upComing = [];
  Future<void> getUpComing() async {
    try {
      emit(MovieLoadingGetMovies());
      final response = await dio.get(
        'https://api.themoviedb.org/3/movie/upcoming',
        queryParameters: {
          'api_key': '63474a134d42a1598125192db516f9e9',
          "adult": false,
          'language': 'en-US',
          'page': indexPage,
        },
      );
      upComing.clear();
      for (var item in response.data['results']) {
        upComing.add(MovieModel.fromJson(item));
      }
      //print(response.data);
      emit(MovieGetUpComingSuccess());
    } catch (e) {
      emit(MovieGetMoviesError(e.toString()));
    }
  }

  // now playing
  List<MovieModel> nowPlaying = [];
  Future<void> getNowPlaying() async {
    try {
      emit(MovieLoadingGetMovies());
      final response = await dio.get(
        'https://api.themoviedb.org/3/movie/now_playing',
        queryParameters: {
          'api_key': '63474a134d42a1598125192db516f9e9',
          "adult": false,
          'page': indexPage,
        },
      );
      nowPlaying.clear();
      for (var item in response.data['results']) {
        nowPlaying.add(MovieModel.fromJson(item));
      }
      emit(MovieGetNowPlayingSuccess());
    } catch (e) {
      emit(MovieGetMoviesError(e.toString()));
    }
  }

  // search
  List<MovieModel> moviesSearch = [];
  Future<void> searchMovies({required String query}) async {
    try {
      emit(MovieSearchLoading());
      final response = await dio.get(
        'https://api.themoviedb.org/3/search/movie',
        queryParameters: {
          'api_key': '63474a134d42a1598125192db516f9e9',
          "adult": false,
          'language': 'en-US',
          'query': query,
        },
      );
      moviesSearch.clear();
      for (var item in response.data['results']) {
        moviesSearch.add(MovieModel.fromJson(item));
      }
      emit(MovieSearchSuccess());
    } catch (e) {
      emit(MovieSearchError());
    }
  }

  // ---------------------------------------------------------------
  // database
  late Database database;

  // create database
  Future<void> createDatabase() async {
    await openDatabase(
      'movies.db',
      version: 1,
      onCreate: (database, version) async {
        debugPrint('database created');
        await database
            .execute('''CREATE TABLE movie (
      id INTEGER PRIMARY KEY,
      title TEXT,
      year TEXT,
      overview TEXT,
      type TEXT,
      poster TEXT,
      backdrop TEXT,
      rate REAL,
      count INTEGER,
      favorite TEXT
    )''')
            .then((value) {
              debugPrint('table created');
              emit(MovieCreateDatabase());
            });
      },

      onOpen: (db) {
        database = db;
        getDataFromDatabase(database);
        debugPrint("Database Opened");
      },
    ).then((value) {
      database = value;
      emit(MovieCreateDatabase());
    });
  }

  // get data from database
  List<MovieModel> moviesDatabase = [];
  Future<void> getDataFromDatabase(database) async {
    moviesDatabase.clear();
    final response = await database.rawQuery('SELECT * FROM movie');
    for (var item in response) {
      moviesDatabase.add(MovieModel.fromDatabaseJson(item));
    }
    emit(MovieGetFromDatabase());
  }

  // insert to database
  Future<void> insertToDatabase({
    required int id,
    required String title,
    required String year,
    required String overview,
    required String type,
    required String poster,
    required String backdrop,
    required double rate,
    required int count,
    required String favorite,
  }) async {
    final movie = MovieModel(
      id: id,
      title: title,
      year: year,
      overview: overview,
      type: type,
      poster: poster,
      backdrop: backdrop,
      rate: rate,
      count: count,
      favorite: favorite,
    );

    final data = movie.toJson();
    // debugPrint('Inserting movie: $data');
    await database
        .rawInsert(
          '''INSERT INTO movie (
          id, title, year, overview, type, poster, backdrop, rate, count, favorite
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)''',
          [
            data['id'],
            data['title'],
            data['year'],
            data['overview'],
            data['type'],
            data['poster'],
            data['backdrop'],
            data['rate'],
            data['count'],
            data['favorite'],
          ],
        )
        .then((value) {
          getDataFromDatabase(database);
          emit(MovieInsertToDatabase());
        });
  }

  // update database
  Future<void> updateDatabase({
    required String title,
    required String favorite,
  }) async {
    await database
        .rawUpdate('UPDATE movie SET favorite = ? WHERE title = ?', [
          favorite,
          title,
        ])
        .then((value) {
          getDataFromDatabase(database);
          emit(MovieUpdateDatabase());
        });
  }

  // delete from database
  Future<void> deleteFromDatabase({required String title}) async {
    await database.rawDelete('DELETE FROM movie WHERE title = ?', [title]).then(
      (value) async {
        await getDataFromDatabase(database);
        emit(MovieDeleteFromDatabase());
      },
    );
  }

  // check exist movie in database
  // Future<bool> isMovieExists(String title) async {
  //   final result = await database.rawQuery(
  //     'SELECT * FROM movie WHERE title = ?',
  //     [title],
  //   );
  //   return result.isNotEmpty;
  // }
}

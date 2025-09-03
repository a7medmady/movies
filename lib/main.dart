import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/cubit/cubit.dart';
import 'package:movie/core/cubit/state.dart';
import 'package:movie/core/database/cachehelper.dart';
import 'package:movie/core/splash/splash.dart';

// images link {poster - backdrop}
// https://image.tmdb.org/t/p/w500/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cachehelper.initial();
  runApp(
    BlocProvider(
      create: (context) => MovieCubit()
        ..createDatabase()
        ..getMovies()
        ..getAiringToday()
        ..getPopularMovies()
        ..getTopRatedMovies()
        ..getUpComing()
        ..getNowPlaying(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
          home: Splash(),
        );
      },
    );
  }
}

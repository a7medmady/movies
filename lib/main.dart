import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/authentication/screens/forgetPassword.dart';
import 'package:movie/core/authentication/screens/login.dart';
import 'package:movie/core/authentication/screens/onboarding.dart';
import 'package:movie/core/authentication/screens/otp.dart';
import 'package:movie/core/authentication/screens/passwordChange.dart';
import 'package:movie/core/authentication/screens/register.dart';
import 'package:movie/core/authentication/screens/successchange.dart';
import 'package:movie/core/database/cachehelper.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';
import 'package:movie/core/home/screen/display.dart';
import 'package:movie/core/home/screen/search.dart';
import 'package:movie/core/splash/splash.dart';
import 'package:movie/firebase_options.dart';

// images link {poster - backdrop}
// https://image.tmdb.org/t/p/w500/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        return SafeArea(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            routes: {
              'login': (context) => const Login(),
              'splash': (context) => const Splash(),
              'display': (context) => const Display(),
              'forgetpassword': (context) => const Forgetpassword(),
              'onboarding': (context) => const Onboarding(),
              'register': (context) => const Register(),
              'search': (context) => const Search(),
              'changepassword': (context) => const ChangePassword(),
              'otp': (context) => const Otp(),
              'successchange': (context) => const SuccessChange(),
            },
            initialRoute: 'splash',
          ),
        );
      },
    );
  }
}

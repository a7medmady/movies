import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constant/color.dart';
import 'package:movie/core/constant/size.dart';
import 'package:movie/core/cubit/cubit.dart';
import 'package:movie/core/cubit/state.dart';
import 'package:movie/core/widget/listView.dart';
import 'package:movie/core/widget/page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Screensize.init(context);
    return Scaffold(
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          var cubit = MovieCubit.get(context);
          // debugPrint('Popular Movies: ${cubit.moviesPopular.length}');
          // debugPrint(cubit.getMovies().toString());
          // debugPrint('trending Movies: ${cubit.movies.length}');
          // debugPrint('topRated Movies: ${cubit.moviesTopRated.length}');
          // debugPrint('Popular Movies: ${cubit.moviesPopular.length}');
          List<Widget> items = cubit.moviesPopular.map((movie) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movie.poster}',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          }).toList();
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
                  child: CarouselSlider(
                    items: items,
                    options: CarouselOptions(
                      height: 300,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 2),
                      autoPlayAnimationDuration: Duration(seconds: 2),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 2,
                    color: cubit.isDark ? Colors.white : Colors.black,
                    indent: 50,
                    endIndent: 50,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Airing Today',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: Listview(movies: cubit.airingToday)),
              SliverToBoxAdapter(
                child: Divider(
                  thickness: 1,
                  color: cubit.isDark ? Colors.white : Colors.black,
                  indent: 35,
                  endIndent: 35,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Trending',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: Listview(movies: cubit.movies)),
              SliverToBoxAdapter(
                child: Divider(
                  thickness: 1,
                  color: cubit.isDark ? Colors.white : Colors.black,
                  indent: 35,
                  endIndent: 35,
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Up Coming',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: Listview(movies: cubit.upComing)),
              SliverToBoxAdapter(
                child: Divider(
                  thickness: 1,
                  color: cubit.isDark ? Colors.white : Colors.black,
                  indent: 35,
                  endIndent: 35,
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Popular',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: Listview(movies: cubit.moviesPopular)),
              SliverToBoxAdapter(
                child: Divider(
                  thickness: 1,
                  color: cubit.isDark ? Colors.white : Colors.black,
                  indent: 35,
                  endIndent: 35,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Top Rated',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: Listview(movies: cubit.moviesTopRated)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 100,
                    right: 100,
                    bottom: 20,
                  ),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: cubit.isDark
                          ? AppColors.primaryColorDarkMode
                          : AppColors.primaryColorLightMode,
                    ),
                    child: PageInedx(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

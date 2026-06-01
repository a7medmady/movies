import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/home/constant/color.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';
import 'package:movie/core/home/model/movieModel.dart';

class Fav extends StatefulWidget {
  final List<MovieModel> movies;
  final int index;
  final double size;

  const Fav({
    super.key,
    required this.movies,
    required this.index,
    required this.size,
  });

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {
  void showSnack(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        final cubit = MovieCubit.get(context);

        // // تأكد أن الـ index صحيح
        // if (index < 0 || index >= movies.length) {
        //   showSnack(context, '⚠️ حدث خطأ: الفيلم غير موجود.');
        //   return const SizedBox();
        // }

        final movie = widget.movies[widget.index];

        // لو movie نفسه null
        // if (movie == null) {
        //   showSnack(context, '⚠️ حدث خطأ: لا يوجد فيلم في هذا الموقع.');
        //   return const SizedBox();
        // }

        bool isFav = cubit.moviesDatabase.contains(movie);

        return IconButton(
          onPressed: () async {
            // // تحقق من اكتمال البيانات
            // if (movie.title == null ||
            //     movie.year == null ||
            //     movie.overview == null ||
            //     movie.type == null ||
            //     movie.poster == null ||
            //     movie.rate == null ||
            //     movie.count == null) {
            //   showSnack(context, '⚠️ بيانات الفيلم غير مكتملة، لا يمكن الإضافة.');
            //   return;
            // }

            // اتاكد من وجود الفيلم في قاعدة البيانات
            if (isFav) {
              final deletedMovie = movie;
              // cubit.updateDatabase(title: movie.title, favorite: 'false');
              cubit.deleteFromDatabase(title: movie.title);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:const Text(
                    'Delete Movie from favourite succesfully!',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      cubit.insertToDatabase(
                        title: deletedMovie.title,
                        year: deletedMovie.year,
                        overview: deletedMovie.overview,
                        type: deletedMovie.type,
                        poster: deletedMovie.poster,
                        rate: deletedMovie.rate,
                        count: deletedMovie.count,
                        favorite: 'true',
                        backdrop: deletedMovie.backdrop,
                        id: deletedMovie.id,
                      );
                      showSnack(
                        context,
                        'Add Movie for favourite successfully! ',
                        Colors.green,
                      );
                    },
                  ),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.red,
                ),
              );
            } else {
              cubit.insertToDatabase(
                title: movie.title,
                year: movie.year,
                overview: movie.overview,
                type: movie.type,
                poster: movie.poster,
                rate: movie.rate,
                count: movie.count,
                favorite: 'true',
                backdrop: movie.backdrop,
                id: movie.id,
              );

              showSnack(
                context,
                'Add Movie for favourite successfully! ',
                Colors.green,
              );
            }
          },
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            size: widget.size,
            color: cubit.isDark
                ? AppColors.primaryColorDarkMode
                : AppColors.primaryColorLightMode,
          ),
        );
      },
    );
  }
}

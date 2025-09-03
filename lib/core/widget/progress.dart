import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/cubit/cubit.dart';
import 'package:movie/core/cubit/state.dart';

class Progress extends StatelessWidget {
  final String text;
  const Progress({super.key, required this.text});

  //widget.movies[index].rate.toString().substring(0, 3)

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        return CircleAvatar(
          backgroundColor: cubit.isDark ? Colors.black : Colors.white,
          radius: 18,
          child: Text(
            text,
            maxLines: 1,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}

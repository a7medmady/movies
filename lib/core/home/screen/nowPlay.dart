import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';
import 'package:movie/core/home/widget/card.dart';

class NowPlay extends StatelessWidget {
  const NowPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView.separated(
            itemCount: cubit.nowPlaying.length,
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Divider(
                  thickness: 1,
                  color: Colors.grey,
                  indent: 35,
                  endIndent: 35,
                ),
              );
            },

            itemBuilder: (context, index) {
              return ItemCard(movies: cubit.nowPlaying, index: index);
            },
          ),
        );
      },
    );
  }
}

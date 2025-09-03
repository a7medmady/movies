import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/cubit/cubit.dart';
import 'package:movie/core/cubit/state.dart';
import 'package:movie/core/widget/card.dart';

class NowPlay extends StatefulWidget {
  const NowPlay({super.key});

  @override
  State<NowPlay> createState() => _NowPlayState();
}

class _NowPlayState extends State<NowPlay> {
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

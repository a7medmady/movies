import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/cubit/cubit.dart';
import 'package:movie/core/cubit/state.dart';
import 'package:movie/core/widget/card.dart';

class Favouirte extends StatelessWidget {
  const Favouirte({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        return Scaffold(
          body: cubit.moviesDatabase.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No Favourite'),
                      SizedBox(height: 20),
                      Icon(Icons.favorite_outline_sharp, size: 100),
                    ],
                  ),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return ItemCard(movies: cubit.moviesDatabase, index: index);
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                        indent: 35,
                        endIndent: 35,
                      ),
                    );
                  },
                  itemCount: cubit.moviesDatabase.length,
                ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';
import 'package:movie/core/home/widget/card.dart';

class Favouirte extends StatelessWidget {
  const Favouirte({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        return Scaffold(
          body: cubit.moviesDatabase.isEmpty
              ?const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_outline_sharp, size: 100),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Text(
                          'No Favourite Movies',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return ItemCard(movies: cubit.moviesDatabase, index: index);
                  },
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
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

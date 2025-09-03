import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/cubit/cubit.dart';
import 'package:movie/core/cubit/state.dart';

class PageInedx extends StatelessWidget {
  const PageInedx({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        final cubit = MovieCubit.get(context);
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cubit.pages.length,
          itemBuilder: (context, index) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 4.0,
                  bottom: 4.0,
                ),
                child: InkWell(
                  onTap: () {
                    cubit.changeIndexPage(index);
                  },
                  child: CircleAvatar(
                    backgroundColor: cubit.getSelectedIndex() == index
                        ? const Color.fromARGB(255, 71, 86, 155)
                        : const Color.fromARGB(255, 85, 123, 84),
                    radius: 18,
                    child: Text(
                      cubit.pages[index],
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: cubit.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

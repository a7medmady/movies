import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/authentication/constants/color.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';

class Topscreen extends StatelessWidget {
  final String destination;
  const Topscreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                top: 10,
                bottom: 20,
                right: 5,
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, destination),
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: .5),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 25,
                    color: !cubit.isDark ? AppColor.lightColor : AppColor.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

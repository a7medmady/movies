import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';

class Button extends StatelessWidget {
  final String text;
  final Color color;
  final void Function() onTap;
  final TextStyle style;
  const Button({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        return InkWell(
          onTap: onTap,
          child: Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              // border: BoxBorder.all(color: AppColor.primaryColor, width: 1.5),
            ),
            child: Center(child:
            (state is SignUpLoading || state is SignInLoading) ? 
            const CircularProgressIndicator(color: Colors.white,)
             : Text(text, style: style)),
          ),
        );
      },
    );
  }
}

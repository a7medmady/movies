import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/authentication/constants/color.dart';
import 'package:movie/core/authentication/constants/font.dart';
import 'package:movie/core/authentication/constants/size.dart';
import 'package:movie/core/authentication/widgets/button.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';

String routename = "successchange";
class SuccessChange extends StatelessWidget {
  const SuccessChange({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.initial(context);
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 100,
                    color: Colors.green,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Password Changed!',
                    style: AppFont.primary.copyWith(
                      color: !cubit.isDark
                          ? AppColor.lightColor
                          : AppColor.primaryColor,
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: ScreenSize.width * 0.9,
                    child: Text(
                      'Your password has been changed successfully',
                      textAlign: TextAlign.center,
                      style: AppFont.secondary.copyWith(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Button(
                    text: 'Back to Login',
                    color: cubit.isDark
                        ? AppColor.primaryColor
                        : AppColor.lightColor,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'login', (route) => false);
                    },
                    style: AppFont.primary.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

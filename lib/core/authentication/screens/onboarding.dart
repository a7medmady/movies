import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/authentication/constants/color.dart';
import 'package:movie/core/authentication/constants/font.dart';
import 'package:movie/core/authentication/constants/size.dart';
import 'package:movie/core/authentication/widgets/button.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';

String routename = "onboarding";

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.initial(context);
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        return Scaffold(
          body: Column(
            children: [
              Container(
                width: ScreenSize.width,
                height: ScreenSize.height * 0.6,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/DALL·E-2025-03-21-09.37.34-A-vibrant-and-modern-digital-illustration-representing-MoviesJoy-an-online-movie-streaming-platform.-The-image-features-a-large-glowing-play-button.webp",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              SizedBox(height: ScreenSize.height * 0.04),

              Padding(
                padding: EdgeInsets.only(
                  left: ScreenSize.width * 0.07,
                  right: ScreenSize.width * 0.07,
                ),
                child: Button(
                  text: "Login",
                  color: cubit.isDark ?
                   AppColor.primaryColor : AppColor.lightColor,
                  style: AppFont.primary.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'login');
                  },
                ),
              ),

              SizedBox(height: ScreenSize.height * 0.025),

              Padding(
                padding: EdgeInsets.only(
                  left: ScreenSize.width * 0.07,
                  right: ScreenSize.width * 0.07,
                ),
                child: Button(
                  text: "Register",
                  color: Colors.white,
                  style: AppFont.primary.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: !cubit.isDark ? AppColor.lightColor : AppColor.primaryColor,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'register');
                  },
                ),
              ),

              SizedBox(height: ScreenSize.height * 0.06),

              TextButton(
                onPressed: () {
                  //cubit.signInAnonymously();
                },
                child: Text(
                  "Continue as a guest",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: !cubit.isDark ?
                     AppColor.blackLightColor : AppColor.blackColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.secondaryColor,
                    decorationThickness: 1,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

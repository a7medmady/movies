import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/authentication/constants/size.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';

class LoginIcons extends StatelessWidget {
  const LoginIcons({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.initial(context);
    return BlocConsumer<MovieCubit, MovieState>(
      listener: (context, state) {
        if (state is SignInWithGoogleSuccess){
          Navigator.pushNamed(context, 'display');
        }
      },
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                cubit.signInWithFacebook();
              },
              child: Container(
                width: ScreenSize.width * 0.25,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: Colors.grey, width: .5),
                  image:const DecorationImage(
                    image: AssetImage("assets/Facebook (Button) (1).png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: () {
                cubit.signInWithGoogle();
              },
              child: Container(
                width: ScreenSize.width * 0.25,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: .5),
                  image:const DecorationImage(
                    image: AssetImage("assets/Google (Button).png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Container(
              width: ScreenSize.width * 0.25,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: .5),
                image: const DecorationImage(
                  image: AssetImage("assets/Microsoft-02.jpg"),
                  // fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

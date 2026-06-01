import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/authentication/constants/color.dart';
import 'package:movie/core/authentication/constants/font.dart';
import 'package:movie/core/authentication/constants/size.dart';
import 'package:movie/core/authentication/widgets/button.dart';
import 'package:movie/core/authentication/widgets/customForm.dart';
import 'package:movie/core/authentication/widgets/topscreen.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';

String routename = "forgetpassword";

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    final cubit = MovieCubit.get(context);
    cubit.emailForgetController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    ScreenSize.initial(context);
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Topscreen(destination: 'login'),
                    SizedBox(height: ScreenSize.height * 0.015),

                    Container(
                      alignment: Alignment.topLeft,
                      width: ScreenSize.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Forgot Password?',
                        style: AppFont.primary.copyWith(
                          color: !cubit.isDark ?
                           AppColor.lightColor : AppColor.primaryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: ScreenSize.height * 0.015),

                    Container(
                      alignment: Alignment.topLeft,
                      width: ScreenSize.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Don\'t worry! It occurs. Please enter the email address linked with your account.',
                        style: AppFont.secondary.copyWith(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    SizedBox(height: ScreenSize.height * 0.025),

                    CustomForm(
                      controller: cubit.emailForgetController,
                      label: 'Email',
                      hint: "Enter your email",
                    ),

                    SizedBox(height: ScreenSize.height * 0.04),

                    Button(
                      text: "Send Code",
                      color: !cubit.isDark ? AppColor.lightColor : AppColor.primaryColor,
                      style: AppFont.primary.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          cubit.forgetPassword();
                          Navigator.pushNamed(context, 'otp');
                        }
                      },
                    ),

                    SizedBox(height: ScreenSize.height * 0.4),

                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Remeber Password? ',
                            style: AppFont.primary.copyWith(
                              color: cubit.isDark?
                               AppColor.primaryColor: AppColor.lightColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  Navigator.pushNamed(context, 'login'),
                            text: 'Login',
                            style: AppFont.primary.copyWith(
                              color: cubit.isDark ?
                               AppColor.blackColor : AppColor.blackLightColor,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

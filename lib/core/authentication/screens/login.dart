import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/authentication/constants/color.dart';
import 'package:movie/core/authentication/constants/font.dart';
import 'package:movie/core/authentication/constants/size.dart';
import 'package:movie/core/authentication/widgets/button.dart';
import 'package:movie/core/authentication/widgets/customForm.dart';
import 'package:movie/core/authentication/widgets/loginIcons.dart';
import 'package:movie/core/authentication/widgets/secretForm.dart';
import 'package:movie/core/authentication/widgets/topscreen.dart';
import 'package:movie/core/database/cachehelper.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';

String routename = "login";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
  void dispose() {
    context.read<MovieCubit>().emailController.clear();
    context.read<MovieCubit>().passwordController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    ScreenSize.initial(context);
    return BlocConsumer<MovieCubit, MovieState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sign In Success'),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushNamed(context, 'display');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please verify your email'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        } else if (state is SignInError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
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
                    Topscreen(destination: 'onboarding'),

                    Container(
                      alignment: Alignment.topLeft,
                      width: ScreenSize.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Welcome back! Again!',
                        style: AppFont.primary.copyWith(
                          color: !cubit.isDark
                              ? AppColor.lightColor
                              : AppColor.primaryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: ScreenSize.height * 0.04),

                    CustomForm(
                      controller: cubit.emailController,
                      label: 'Email',
                      hint: 'Enter your email',
                    ),

                    SizedBox(height: ScreenSize.height * 0.03),
                    SecretForm(
                      controller: cubit.passwordController,
                      label: 'Password',
                      hint: 'Enter your password',
                      textInputAction: TextInputAction.done,
                      parent_controller: null,
                    ),

                    SizedBox(height: ScreenSize.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'forgetpassword');
                          },
                          child: Text(
                            'Forgot Password?',
                            style: AppFont.primary.copyWith(
                              color: AppColor.secondaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenSize.height * 0.06),

                    Padding(
                      padding: EdgeInsets.only(
                        left: ScreenSize.width * 0.02,
                        right: ScreenSize.width * 0.02,
                      ),
                      child: Button(
                        text: "Login",
                        color: cubit.isDark
                            ? AppColor.primaryColor
                            : AppColor.lightColor,
                        style: AppFont.primary.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            Cachehelper.saveData(
                              key: 'email', 
                              value: cubit.emailController.text, 
                              );
                            Cachehelper.saveData(
                              key: 'password', 
                              value: cubit.passwordController.text, 
                              );
                            cubit.signIn();
                          }
                        },
                      ),
                    ),

                    SizedBox(height: ScreenSize.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Divider(
                            indent: 2,
                            endIndent: 2,
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          'Or Login with',
                          style: AppFont.primary.copyWith(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            indent: 2,
                            endIndent: 2,
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: ScreenSize.height * 0.04),

                    LoginIcons(),

                    SizedBox(height: ScreenSize.height * 0.06),

                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don\'t have an account? ',
                            style: AppFont.primary.copyWith(
                              color: cubit.isDark
                                  ? AppColor.primaryColor
                                  : AppColor.lightColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  Navigator.pushNamed(context, 'register'),
                            text: 'Register Now',
                            style: AppFont.primary.copyWith(
                              color: !cubit.isDark
                                  ? AppColor.blackLightColor
                                  : AppColor.blackColor,
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

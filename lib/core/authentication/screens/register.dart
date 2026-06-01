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
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';

String routename = "register";

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
      final cubit = MovieCubit.get(context);
  cubit.emailUpController.dispose();
  cubit.passwordUpController.dispose();
  cubit.confirmPasswordController.dispose();
  cubit.nameController.dispose();
    super.dispose();
  }
 

  @override
  Widget build(BuildContext context) {
    ScreenSize.initial(context);
    return BlocConsumer<MovieCubit, MovieState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sign Up Success go to verify your email'),
              duration: Duration(seconds: 1),
              backgroundColor: Colors.green,
              ),
          );
          Navigator.pushNamed(context, 'login');
        } else if (state is SignUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.red,
            )
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
                        'Hello! Register to get started',
                        style: AppFont.primary.copyWith(
                          color: !cubit.isDark ? AppColor.lightColor : AppColor.primaryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: ScreenSize.height * 0.02),

                    CustomForm(
                      controller: cubit.nameController,
                      label: 'Username',
                      hint: 'Enter your username',
                    ),

                    SizedBox(height: ScreenSize.height * 0.015),
                    CustomForm(
                      controller: cubit.emailUpController,
                      label: 'Email',
                      hint: 'Enter your Email',
                    ),

                    SizedBox(height: ScreenSize.height * 0.015),
                    SecretForm(
                      controller: cubit.passwordUpController,
                      label: 'Password',
                      hint: 'Enter your password',
                      textInputAction: TextInputAction.next,
                      parent_controller: null,
                    ),
                    SizedBox(height: ScreenSize.height * 0.015),
                    SecretForm(
                      controller: cubit.confirmPasswordController,
                      label: 'Confirm Password',
                      hint: 'Enter your confirm password',
                      textInputAction: TextInputAction.done,
                      parent_controller: cubit.passwordUpController,
                    ),

                    SizedBox(height: ScreenSize.height * 0.025),

                    Padding(
                      padding: EdgeInsets.only(
                        left: ScreenSize.width * 0.02,
                        right: ScreenSize.width * 0.02,
                      ),
                      child: Button(
                        text: "Register",
                        color: !cubit.isDark ? AppColor.lightColor : AppColor.primaryColor,
                        style: AppFont.primary.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cubit.signUp();
                          }
                        },
                      ),
                    ),

                    SizedBox(height: ScreenSize.height * 0.02),
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
                          'Or Register with',
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

                    SizedBox(height: ScreenSize.height * 0.03),

                    LoginIcons(),

                    SizedBox(height: ScreenSize.height * 0.05),

                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: AppFont.primary.copyWith(
                              color: !cubit.isDark ? AppColor.lightColor : AppColor.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  Navigator.pushNamed(context, 'login'),
                            text: 'Login Now',
                            style: AppFont.primary.copyWith(
                              color: !cubit.isDark ?
                               AppColor.blackLightColor : AppColor.blackColor,
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

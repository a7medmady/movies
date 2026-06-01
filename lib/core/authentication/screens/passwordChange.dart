import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/authentication/constants/color.dart';
import 'package:movie/core/authentication/constants/font.dart';
import 'package:movie/core/authentication/constants/size.dart';
import 'package:movie/core/authentication/widgets/button.dart';
import 'package:movie/core/authentication/widgets/secretForm.dart';
import 'package:movie/core/authentication/widgets/topscreen.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';

String routename = "changepassword";

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    password.clear();
    confirmpassword.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    ScreenSize.initial(context);
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        return Form(
          key: formKey,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Topscreen(destination: 'otp'),
                    SizedBox(height: ScreenSize.height * 0.02),
                    Container(
                          alignment: Alignment.topLeft,
                          width: ScreenSize.width ,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Create new password',
                            style: AppFont.primary.copyWith(
                              color: !cubit.isDark ?
                               AppColor.lightColor : AppColor.primaryColor,
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                
                    SizedBox(height: ScreenSize.height * 0.02),
                    Container(
                          alignment: Alignment.topLeft,
                          width: ScreenSize.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Your new password must be unique from those previously used',
                            style: AppFont.secondary.copyWith(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                    SizedBox(height: ScreenSize.height * 0.02),
                    SecretForm(
                      label: 'Password', 
                      hint: 'Enter your new password', 
                      controller: password, 
                      textInputAction: TextInputAction.next, 
                      parent_controller: null,
                      ),
                    SizedBox(height: ScreenSize.height * 0.03),
                    SecretForm(
                      label: 'Confirm Password', 
                      hint: 'Confirm your new password', 
                      controller: confirmpassword, 
                      textInputAction: TextInputAction.done, 
                      parent_controller: password,
                      ),
                    SizedBox(height: ScreenSize.height * 0.05),
                    Button(
                      text: 'Reset Password', 
                      color: cubit.isDark ? AppColor.primaryColor : AppColor.lightColor, 
                      onTap: () {
                        if(formKey.currentState!.validate()){
                          Navigator.pushNamed(context, 'successchange');
                        }
                      }, 
                      style: AppFont.primary.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/authentication/constants/color.dart';
import 'package:movie/core/authentication/constants/font.dart';
import 'package:movie/core/authentication/constants/size.dart';
import 'package:movie/core/authentication/widgets/button.dart';
import 'package:movie/core/authentication/widgets/topscreen.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

String routename = "otp";

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenSize.initial(context);
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Topscreen(destination: 'forgetpassword'),
                  SizedBox(height: ScreenSize.height * 0.02),
                  Container(
                        alignment: Alignment.topLeft,
                        width: ScreenSize.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'OTP Verification',
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
                          'Enter the verification code we just sent to your email address',
                          style: AppFont.secondary.copyWith(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                  SizedBox(height: ScreenSize.height * 0.02),
                  PinCodeTextField(
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 70,
                      fieldWidth: ScreenSize.width / 5.5,
                      activeFillColor: cubit.isDark ? const Color.fromARGB(255, 19, 19, 19) : Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: cubit.isDark ? const Color.fromARGB(255, 19, 19, 19) : Colors.white,
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    onCompleted: (v) {
                      debugPrint("Completed");
                      // Navigator.pushNamed(context, 'changepassword');
                    },
                    onChanged: (value) {
                      // print(value);
                      // setState(() {
                      //   currentText = value;
                      // });
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    }, appContext: context,
                  ),
                  SizedBox(height: ScreenSize.height * 0.02),
                  Button(
                    text: 'Verify', 
                    color: cubit.isDark ? AppColor.primaryColor : AppColor.lightColor, 
                    onTap: () {
                      Navigator.pushNamed(context, 'changepassword');
                    }, 
                    style: AppFont.primary.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.5),
                  Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Didn\t received code? ',
                              style: AppFont.primary.copyWith(
                                color: cubit.isDark?
                                 AppColor.primaryColor: AppColor.lightColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {},
                              text: 'Resend',
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
        );
      },
    );
  }
}

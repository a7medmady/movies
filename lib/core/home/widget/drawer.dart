import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/authentication/constants/font.dart';
import 'package:movie/core/database/cachehelper.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: !cubit.isDark ? Colors.white : Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        size: 30,
                        color: cubit.isDark ? Colors.white : Colors.black,
                      ),
                      Text(
                        'Settings',
                        style: AppFont.primary.copyWith(
                          color: cubit.isDark ? Colors.white : Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SwitchListTile(
                value: cubit.isDark,
                onChanged: (value) {
                  cubit.changeTheme();
                },
                title: Text(
                  'Dark Mode',
                  style: AppFont.primary.copyWith(
                    fontSize: 20,
                    color: cubit.isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),

              ListTile(
                title: Text(
                  'Search',
                  style: AppFont.primary.copyWith(
                    color: cubit.isDark ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'search');
                },
                trailing: Icon(Icons.search, size: 30),
              ),

              ListTile(
                title: Text(
                  'Profile',
                  style: AppFont.primary.copyWith(
                    color: cubit.isDark ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  //Navigator.pushNamed(context, 'search');
                },
                trailing: Icon(Icons.person, size: 30),
              ),

              ListTile(
                title: Text(
                  'Log Out',
                  style: AppFont.primary.copyWith(
                    color: cubit.isDark ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: 'Logout',
                    desc: 'Do you want to logout?',
                    btnCancelOnPress: () {
                      Navigator.of(context).pop();
                    },
                    btnOkOnPress: () async {
                      Cachehelper.removeData(key: 'email');
                      Cachehelper.removeData(key: 'password');
                      cubit.signOut();

                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pop(); // اقفل الديالوج
                      Future.delayed(Duration(milliseconds: 100), () {
                        Navigator.pushNamed(context, 'login');
                      });
                    },
                  ).show();
                },

                trailing: Icon(Icons.logout, size: 30),
              ),
            ],
          ),
        );
      },
    );
  }
}

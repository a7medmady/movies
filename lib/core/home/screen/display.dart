import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/database/cachehelper.dart';
import 'package:movie/core/home/constant/color.dart';
import 'package:movie/core/home/cubit/cubit.dart';
import 'package:movie/core/home/cubit/state.dart';
import 'package:movie/core/home/widget/bottomNavigation.dart';
import 'package:movie/core/home/widget/drawer.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        Cachehelper.initial();
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: cubit.isDark
                  ? AppColors.primaryColorDarkMode
                  : AppColors.primaryColorLightMode,
              title: Text(
                cubit.titles[cubit.currentIndex],
                style:const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),

            drawer: const Settings(),

            body: cubit.screens[cubit.currentIndex],

            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: cubit.isDark
                      ? AppColors.colorDarkMode
                      : AppColors.colorLightMode,
                  boxShadow:const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, -4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: BottomNavigationBar(
                  currentIndex: cubit.currentIndex,
                  onTap: cubit.changeIndex,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: cubit.isDark
                      ? AppColors.primaryColorLightMode
                      : AppColors.primaryColorDarkMode,
                  unselectedItemColor: cubit.isDark
                      ? AppColors.secondaryColorLightMode
                      : AppColors.secondaryColorDarkMode,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      icon: BuildCircularNavItem(
                        icon: Icons.play_arrow_outlined,
                        index: 0,
                        currentIndex: cubit.currentIndex,
                      ),
                      label: 'Now Playing',
                    ),
                    BottomNavigationBarItem(
                      icon: BuildCircularNavItem(
                        icon: Icons.home,
                        index: 1,
                        currentIndex: cubit.currentIndex,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: BuildCircularNavItem(
                        icon: Icons.favorite,
                        index: 2,
                        currentIndex: cubit.currentIndex,
                      ),
                      label: 'Favourite',
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

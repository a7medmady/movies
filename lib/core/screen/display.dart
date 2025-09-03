import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constant/color.dart';
import 'package:movie/core/cubit/cubit.dart';
import 'package:movie/core/cubit/state.dart';
import 'package:movie/core/database/cachehelper.dart';
import 'package:movie/core/screen/search.dart';
import 'package:movie/core/widget/bottomNavigation.dart';

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
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Search()),
                  );
                },
                icon: Icon(Icons.search, size: 35),
              ),
              backgroundColor: cubit.isDark
                  ? AppColors.primaryColorDarkMode
                  : AppColors.primaryColorLightMode,
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    cubit.changeTheme();
                  },
                  icon: cubit.isDark
                      ? Icon(Icons.light_mode)
                      : Icon(Icons.dark_mode),
                ),
              ],
            ),

            body: cubit.screens[cubit.currentIndex],

            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: cubit.isDark
                      ? AppColors.colorDarkMode
                      : AppColors.colorLightMode,
                  boxShadow: [
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

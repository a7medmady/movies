import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constant/color.dart';
import 'package:movie/core/constant/size.dart';
import 'package:movie/core/cubit/cubit.dart';
import 'package:movie/core/cubit/state.dart';
import 'package:movie/core/widget/card.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Screensize.init(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: MovieCubit.get(context).isDark
              ? AppColors.primaryColorDarkMode
              : AppColors.primaryColorLightMode,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new, size: 30),
          ),
          title: Text(
            'Search',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: BlocBuilder<MovieCubit, MovieState>(
              builder: (context, state) {
                var cubit = MovieCubit.get(context);
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 30),
                      Text.rich(
                        TextSpan(
                          text: '    Search ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Movies',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: cubit.isDark
                                    ? AppColors.primaryColorDarkMode
                                    : AppColors.primaryColorLightMode,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      TextFormField(
                        controller: search,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: cubit.isDark
                                  ? Colors.white
                                  : AppColors.primaryColorLightMode,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: cubit.isDark
                                  ? Colors.white
                                  : AppColors.primaryColorLightMode,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: cubit.isDark
                                ? AppColors.primaryColorDarkMode
                                : AppColors.primaryColorLightMode,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: cubit.isDark
                                  ? AppColors.primaryColorDarkMode
                                  : AppColors.primaryColorLightMode,
                            ),
                            onPressed: () {
                              search.clear();
                              cubit.moviesSearch.clear();
                              setState(() {});
                            },
                          ),
                          labelText: 'Search',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.isEmpty) {
                            cubit.moviesSearch.clear();
                            setState(() {});
                          } else {
                            cubit.searchMovies(query: value);
                          }
                        },
                      ),

                      Container(
                        height: Screensize.height * 0.7,
                        width: Screensize.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: state is MovieSearchLoading
                            ? const Center(child: CircularProgressIndicator())
                            : cubit.moviesSearch.isEmpty
                            ? Center(
                                child: Text(
                                  'No Movies Found',
                                  style: TextStyle(
                                    color: cubit.isDark
                                        ? AppColors.primaryColorDarkMode
                                        : AppColors.primaryColorLightMode,
                                    fontSize: 25,
                                  ),
                                ),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  return ItemCard(
                                    movies: cubit.moviesSearch,
                                    index: index,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                    indent: 35,
                                    endIndent: 35,
                                  );
                                },
                                itemCount: cubit.moviesSearch.length,
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

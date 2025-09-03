import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constant/size.dart';
import 'package:movie/core/cubit/cubit.dart';
import 'package:movie/core/cubit/state.dart';
import 'package:movie/core/model/movieModel.dart';
import 'package:movie/core/screen/detail.dart';
import 'package:movie/core/widget/dialog.dart';
import 'package:movie/core/widget/fav.dart';
import 'package:movie/core/widget/progress.dart';
import 'package:radial_progress/radial_progress.dart';

class Listview extends StatefulWidget {
  final List<MovieModel> movies;
  const Listview({super.key, required this.movies});

  @override
  State<Listview> createState() => _ListviewState();
}

class _ListviewState extends State<Listview> {
  @override
  Widget build(BuildContext context) {
    Screensize.init(context);
    return SizedBox(
      height: Screensize.height * 0.35,
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if ( state is MovieLoadingGetMovies) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            physics: ClampingScrollPhysics(),
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          InkWell(
                            onTap: () {
                              //debugPrint('Movies length: ${widget.movies.length}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detail(
                                    index: index,
                                    movies: widget.movies,
                                  ),
                                ),
                              );
                            },
                            onDoubleTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return DialogShow(
                                    index: index,
                                    movies: widget.movies,
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: Screensize.height * 0.2,
                              width: Screensize.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    widget.movies[index].poster,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Fav(movies: widget.movies, index: index),
                          ),
                          Positioned(
                            bottom: -15,
                            left: -15,
                            child: RadialProgressWidget(
                              percent: widget.movies[index].rate / 10,
                              diameter: 40,
                              bgLineColor: Colors.grey,
                              progressLineWidth: 5,
                              startAngle: StartAngle.top,
                              progressLineColors: const [Colors.green],
                              centerChild: Center(
                                child: Progress(
                                  text: widget.movies[index].rate
                                      .toString()
                                      .substring(0, 3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: Screensize.width * 0.3,
                        child: Center(
                          child: Text(
                            widget.movies[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        widget.movies[index].year,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

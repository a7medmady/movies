import 'package:flutter/material.dart';
import 'package:movie/core/constant/size.dart';
import 'package:movie/core/model/movieModel.dart';
import 'package:movie/core/screen/detail.dart';
import 'package:movie/core/widget/dialog.dart';
import 'package:movie/core/widget/fav.dart';

class ItemCard extends StatelessWidget {
  final List<MovieModel> movies;
  final int index;
  const ItemCard({super.key, required this.movies, required this.index});

  @override
  Widget build(BuildContext context) {
    Screensize.init(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Detail(index: index, movies: movies),
            ),
          );
        },
        onDoubleTap: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogShow(index: index, movies: movies);
            },
          );
        },
        child: Container(
          height: Screensize.height * 0.2,
          width: Screensize.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(251, 158, 158, 158),
          ),

          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: Screensize.height * 0.17,
                  width: Screensize.width * 0.27,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(movies[index].poster),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: Screensize.width * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 8.0,
                          top: 8.0,
                          bottom: 8.0,
                        ),
                        child: Text(
                          movies[index].title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Type: ${movies[index].type}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Release Date: ${movies[index].year}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Rate: ${movies[index].rate.toString().substring(0, 3)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Count: ${movies[index].count.toString()}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Fav(movies: movies, index: index),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

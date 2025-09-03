import 'package:flutter/material.dart';
import 'package:movie/core/constant/size.dart';
import 'package:movie/core/model/movieModel.dart';

class DialogShow extends StatelessWidget {
  final List<MovieModel> movies;
  final int index;
  const DialogShow({super.key, required this.movies, required this.index});

  @override
  Widget build(BuildContext context) {
    Screensize.init(context);
    return AlertDialog(
      title: Center(
        child: Text(
          movies[index].title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: Screensize.height * 0.2,
              width: Screensize.width * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500${movies[index].poster}',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              movies[index].overview,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              maxLines: 9,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Rate: ${movies[index].rate}'),
              Text('Count: ${movies[index].count}'),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

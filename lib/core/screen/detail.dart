import 'package:flutter/material.dart';
import 'package:movie/core/model/movieModel.dart';
import 'package:movie/core/widget/fav.dart';

class Detail extends StatefulWidget {
  final List<MovieModel> movies;
  final int index;
  const Detail({super.key, required this.index, required this.movies});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new, size: 30),
          ),
          actions: [Fav(index: widget.index, movies: widget.movies)],
        ),

        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SizedBox(
                height: 290,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  child: Image.network(
                    widget.movies[widget.index].backdrop,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 250,
              left: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.movies[widget.index].poster,
                      height: 170,
                      width: 125,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        widget.movies[widget.index].title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 260,
              right: 20,
              child: Container(
                alignment: Alignment.center,
                width: 75,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 2),
                    Text(
                      widget.movies[widget.index].rate.toString().substring(
                        0,
                        3,
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 430,
              left: MediaQuery.of(context).size.width * 0.09,
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.9,
                // اى كلام
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.grey,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.movies[widget.index].year,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    VerticalDivider(thickness: 1, color: Colors.grey),
                    Icon(Icons.people, color: Colors.grey, size: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.movies[widget.index].count.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    VerticalDivider(thickness: 1, color: Colors.grey),
                    Icon(
                      Icons.local_movies_outlined,
                      color: Colors.grey,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.movies[widget.index].type.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 470,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    widget.movies[widget.index].overview,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                    maxLines: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

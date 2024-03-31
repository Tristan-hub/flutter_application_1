import 'package:flutter/material.dart';
import '../models/movies.dart';   
class MovieCard extends StatelessWidget {
  final Movies movie;
  final int rank;  

  const MovieCard({
    Key? key,
    required this.movie,
    required this.rank,   
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 359,
      height: 153,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(30, 50, 67, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Image.network(
                  movie.imageUrl,
                  width: 128.86,   
                  height: 153,  
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10, 
                left: 10, 
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 129, 0, 1),   
                    borderRadius: BorderRadius.circular(20),   
                  ),
                  child: Text(
                    '#$rank',  
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${movie.releaseDate}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${movie.runtime}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

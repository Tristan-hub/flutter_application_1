import 'package:flutter/material.dart';
import '../widgets/movie_card.dart';   
import '../widgets/bottom_nav_bar.dart';   
import '../comicvine_api.dart';   
import '../models/movies.dart';   
import 'home_screen.dart'; 
import '../screens/series_list_screen.dart';
import '../screens/comic_list_screen.dart';
class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({Key? key}) : super(key: key);

  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  int _selectedIndex = 3;   

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const  HomeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const  ComicsListScreen()));
        break;
      case 2 :
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SeriesListScreen()));
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MoviesListScreen()));
        break;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15232E),
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0),   
        child: Column(
          children: [
            const Text(
              "Les films les plus populaires",
              style: TextStyle(
                color: Colors.white,   
                fontFamily: "Nunito-Bold",   
                fontSize: 30,   
                fontWeight: FontWeight.bold,   
                letterSpacing: 0,   
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Movies>>(
                future: ComicVineApi().fetchMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Erreur: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Movies movie = snapshot.data![index];
                        return MovieCard(
                          movie: movie,
                          rank: index + 1,
                        );
                      },
                    );
                  } else {
                    return const Text("Aucun film trouvé.", style: TextStyle(color: Colors.white));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}

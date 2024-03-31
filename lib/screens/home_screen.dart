import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_card.dart';
import '../widgets/section_with_cards.dart';
import '../comicvine_api.dart';
import '../models/comics.dart';
import '../models/series.dart';
import '../models/movies.dart';
import'../screens/movies_list_screen.dart';
import '../screens/series_list_screen.dart';
import '../screens/comic_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Comics>> futureComics;
  late Future<List<Series>> futureSeries;
  late Future<List<Movies>> futureMovies;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureComics = ComicVineApi().fetchComics();   
    futureSeries = ComicVineApi().fetchSeries();   
    futureMovies = ComicVineApi().fetchMovies();   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15232E),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 34.0, right: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Bienvenue !',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nunito-Bold',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/astronaut.svg',
                    width: 121.85,
                    height: 159.68,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            buildSectionWithCards<Comics>(
              futureComics, 
              'Dernières Sorties Comics', 
              (comic) => CustomCard(
                imageUrl: comic.imageUrl ?? 'assets/default_image.png',
                title: comic.name ?? 'No Title',
              ),
            ),
            const SizedBox(height: 20),
            buildSectionWithCards<Series>(
              futureSeries,
              'Séries Populaires',
              (series) => CustomCard(
                imageUrl: series.imageUrl ?? 'assets/default_image.png',
                title: series.name ?? 'No Title',
              ),
            ),
            const SizedBox(height: 20),
            buildSectionWithCards<Movies>(
              futureMovies,
              'Films À la Une',
              (movie) => CustomCard(
                imageUrl: movie.imageUrl ?? 'assets/default_image.png',
                title: movie.name ?? 'No Title',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
      selectedIndex: _selectedIndex,
      onItemSelected: (index) {
        
        if (index == 0) { 
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          setState(() {
            _selectedIndex = index;
          });
        }
        if (index == 1) { 
          Navigator.push(context, MaterialPageRoute(builder: (context) => ComicsListScreen()));
        } else {
          setState(() {
            _selectedIndex = index;
          });
        }
        if (index == 2) { 
          Navigator.push(context, MaterialPageRoute(builder: (context) => SeriesListScreen()));
        } else {
          setState(() {
            _selectedIndex = index;
          });
        }
        if (index == 3) { 
          Navigator.push(context, MaterialPageRoute(builder: (context) => MoviesListScreen()));
        } else {
          setState(() {
            _selectedIndex = index;
          });
        }
      },
    ),
    );
  }

  Widget buildSectionWithCards<T>(
    Future<List<T>> futureList, 
    String title, 
    Widget Function(T) buildCard,
  ) {
    return FutureBuilder<List<T>>(
      future: futureList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<Widget> cards = snapshot.data!
              .take(5)
              .map(buildCard)
              .toList();

          return SectionWithCards(
            title: title,
            onViewMorePressed: () {

            },
            cards: cards,
          );
        } else {
          return Text('Aucun(e) $title trouvé(e).');
        }
      },
    );
  }
}

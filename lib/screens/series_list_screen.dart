import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/movies_list_screen.dart';
import '../models/series.dart'; 
import '../widgets/series_card.dart'; 
import '../widgets/bottom_nav_bar.dart'; 
import '../comicvine_api.dart'; 
import 'home_screen.dart'; 
import '../screens/comic_list_screen.dart';


class SeriesListScreen extends StatefulWidget {
  const SeriesListScreen({Key? key}) : super(key: key);

  @override
  State<SeriesListScreen> createState() => _SeriesListScreenState();
}

class _SeriesListScreenState extends State<SeriesListScreen> {
  int _selectedIndex = 2; 

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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Les séries les plus populaires',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Series>>(
              future: ComicVineApi().fetchSeries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Erreur: ${snapshot.error}', style: const TextStyle(color: Colors.white));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return SeriesCard(
                        series: snapshot.data![index],
                        rank: index + 1, 
                      );
                    },
                  );
                } else {
                  return const Text('Aucune série trouvée.', style: TextStyle(color: Colors.white));
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/section_with_cards.dart';
import '../widgets/custom_card.dart';
import '../comicvine_api.dart'; // Assurez-vous que le chemin est correct
import '../models/comic.dart'; // Assurez-vous que le chemin est correct

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late Future<List<Comic>> futureComics; // Déclaration de la future liste de comics

  @override
  void initState() {
    super.initState();
    futureComics = ComicVineApi().fetchComics(); // Chargement des comics à l'initialisation
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15232E),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 32.0, top: 34.0, right: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bienvenue !',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nunito-Bold',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SvgPicture.asset(
                    'lib/assets/svg/astronaut.svg',
                    width: 121.85,
                    height: 159.68,
                  ),
                ],
              ),
            ),
            FutureBuilder<List<Comic>>(
              future: futureComics,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Création des CustomCard avec les images de l'API
                  List<Widget> cards = snapshot.data!.take(5).map((comic) {
                    // Limite à 5 comics ou moins, selon les données disponibles
                    return CustomCard(
                      imageUrl: comic.imageUrl, // Utilisez les URLs d'images de l'API
                      title: comic.name,
                    );
                  }).toList();

                  return SectionWithCards(
                    title: 'Dernières Sorties',
                    onViewMorePressed: () {}, // Implémentez une action pour "Voir plus" si nécessaire
                    cards: cards,
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // Affiche un indicateur de chargement en attendant les données
                return CircularProgressIndicator();
              },
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

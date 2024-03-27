import 'package:flutter/material.dart';
import 'custom_card.dart'; // Assurez-vous que le chemin est correct

class SectionWithCards extends StatelessWidget {
  final String title;
  final VoidCallback onViewMorePressed;
  final List<Widget> cards; // Cette liste doit être fournie lors de la création de l'instance de SectionWithCards

  SectionWithCards({
    required this.title,
    required this.onViewMorePressed,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 424, // Largeur spécifiée pour le conteneur de la section
      height: 329,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Arrondi des angles
        color: Color.fromRGBO(30, 50, 67, 1), // Couleur de fond
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Petit cercle orange
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),
                      margin: EdgeInsets.only(right: 8),
                    ),
                    // Titre de la section
                    Text(
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                // Bouton "Voir plus"
                GestureDetector(
                  onTap: onViewMorePressed,
                  child: Container(
                    width: 57,
                    height: 19,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Center(
                      child: Text(
                        'Voir plus',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 242, // Hauteur spécifiée pour le conteneur des cartes
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: cards, // Ici, vous insérez votre liste de CustomCard
            ),
          ),
        ],
      ),
    );
  }
}

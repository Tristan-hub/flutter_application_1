class Comic {
  final int id;
  final String name;
  final String coverDate;
  final String imageUrl; // Ajout de la propriété imageUrl

  Comic({
    required this.id,
    required this.name,
    required this.coverDate,
    required this.imageUrl, // Ajout du paramètre imageUrl
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'],
      name: json['name'] ?? 'Unknown',
      coverDate: json['cover_date'],
      imageUrl: json['image']['medium_url'], // Récupération de l'URL de l'image
    );
  }
}

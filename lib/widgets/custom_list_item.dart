import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CustomListItem({
    Key? key,
    required this.title,
    required this.imageUrl, required String subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            ),
          ),
          Text(title, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

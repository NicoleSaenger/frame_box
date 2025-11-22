import 'package:flutter/material.dart';

import '../../models/photo_model.dart';
import '../../models/user_model.dart';
import '../post/post.dart';

class PhotoGridItem extends StatelessWidget {
  final PhotoModel photo;
  final UserModel user;

  const PhotoGridItem({super.key, required this.photo, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PostScreen(photo: photo, user: user),
          ),
        );
      },

      child: ClipRRect(
        borderRadius: BorderRadius.circular(1.0), // Borda arredondada
        child: Image.network(
          photo.thumbnailUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
                color: const Color(0xFF60107B),
              ),
            );
          },
          // Tratamento de erro (caso o Picsum não retorne a imagem)
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFe8d9f0), // Cor de fundo do grid mockado
              child: const Center(
                child: Icon(Icons.broken_image, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }
}

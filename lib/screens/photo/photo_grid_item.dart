import 'package:flutter/material.dart';

import '../../models/photo_model.dart';
import '../post/post.dart';

class PhotoGridItem extends StatelessWidget {
  final PhotoModel photo;

  const PhotoGridItem({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegação para a tela de post (foto ampliada)
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => PostScreen(photo: photo)));
      },
      // 💡 CORPO DO CARD DE IMAGEM
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Borda arredondada
        child: Image.network(
          // ⚠️ AQUI ESTÁ A CHAVE: Usa o URL da miniatura do seu db.json
          photo.thumbnailUrl,
          fit: BoxFit.cover,
          // Placeholder enquanto a imagem carrega
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

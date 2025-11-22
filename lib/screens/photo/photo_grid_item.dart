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
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => PostScreen(photo: photo)));
      },
      child: ClipRRect(),
    );
  }
}

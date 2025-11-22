import 'package:flutter/material.dart';
import 'package:frame_box/models/album_model.dart';

import '../../models/user_model.dart';
import '../photo/photo.dart';

class AlbumCard extends StatelessWidget {
  final AlbumModel album;
  final UserModel user;

  const AlbumCard({super.key, required this.album, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PhotoScreen(album: album, user: user),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFe8d9f0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.collections_bookmark_rounded,
                color: Color(0xFF60107B),
                size: 24,
              ),
            ),

            Expanded(
              child: Text(
                album.title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF60107B),
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

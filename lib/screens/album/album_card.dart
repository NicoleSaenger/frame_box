import 'package:flutter/material.dart';
import 'package:frame_box/models/album_model.dart';

class AlbumCard extends StatelessWidget {
  final AlbumModel album;

  const AlbumCard({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFbf9fca),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
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
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

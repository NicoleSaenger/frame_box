import 'package:flutter/material.dart';
import 'package:frame_box/models/user_model.dart';
import 'package:frame_box/screens/album/album.dart';

class HomeCard extends StatelessWidget {
  final UserModel user;
  final int index;

  const HomeCard({super.key, required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => AlbumScreen(user: user)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          padding: EdgeInsets.all(10),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFbf9fca),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: .start,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/300?img=${index.toString()}',
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      user.username,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

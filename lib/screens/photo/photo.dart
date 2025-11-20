import 'package:flutter/material.dart';

import '../../models/album_model.dart';
import '../../models/user_model.dart';

class PhotoScreen extends StatefulWidget {
  final UserModel user;
  final AlbumModel album;

  const PhotoScreen({super.key, required this.user, required this.album});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const Divider(height: 1, color: Color(0xFFe8d9f0)),
            _buildPhotoGrid(),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildCustomAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6.0,
              offset: const Offset(0, 2.0),
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Álbum',
            style: TextStyle(
              color: Color(0xFF60107B),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Color(0xFF60107B)),
          actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () {})],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final userImageIndex = widget.user.id;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.user.username,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF60107B),
            ),
          ),
          const SizedBox(height: 15),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/300?img=${userImageIndex.toString()}',
                ),
              ),
              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.album.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Text(
                      '20 photos',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const Row(
                children: [
                  Icon(Icons.person_add_alt_1, color: Color(0xFF60107B)),
                  SizedBox(width: 10),
                  Icon(Icons.notifications_none, color: Color(0xFF60107B)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemBuilder: (context, index) {
          return Container(
            color: const Color(0xFFe8d9f0),
            child: const Center(
              child: Icon(Icons.photo_outlined, color: Color(0xFFe8d9f0)),
            ),
          );
        },
      ),
    );
  }
}

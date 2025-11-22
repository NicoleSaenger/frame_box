import 'package:flutter/material.dart';
import 'package:frame_box/screens/photo/photo_bloc.dart';
import 'package:frame_box/screens/photo/photo_grid_item.dart';

import '../../models/album_model.dart';
import '../../models/photo_model.dart';
import '../../models/user_model.dart';

class PhotoScreen extends StatefulWidget {
  final UserModel user;
  final AlbumModel album;

  const PhotoScreen({super.key, required this.user, required this.album});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final PhotoBloc _bloc = PhotoBloc();

  @override
  void initState() {
    super.initState();
    _bloc.get(widget.album.id);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
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
    return StreamBuilder<dynamic>(
      stream: _bloc.output,
      builder: (_, snapshot) {
        //Carregando
        if (!snapshot.hasData || snapshot.data == true) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 80.0),
              child: CircularProgressIndicator(color: Color(0xFF60107B)),
            ),
          );
        }

        //Erro ou Falha
        if (snapshot.data == false || !(snapshot.data is List)) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Erro ao carregar fotos ou álbum vazio.'),
            ),
          );
        }

        //Sucesso: Carrega a lista real de fotos
        final List<PhotoModel> photos = snapshot.data as List<PhotoModel>;

        if (photos.isEmpty) {
          return const Center(child: Text('Este álbum não possui fotos.'));
        }

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: photos.length,
            // Usa a contagem real!
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemBuilder: (context, index) {
              final photo = photos[index];
              // 💡 Renderiza o widget final que carrega a imagem real
              return PhotoGridItem(photo: photo);
            },
          ),
        );
      },
    );
  }
}

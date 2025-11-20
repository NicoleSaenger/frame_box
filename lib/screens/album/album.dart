import 'package:flutter/material.dart';

import '../../models/album_model.dart';
import '../../models/user_model.dart';
import 'album_bloc.dart';
import 'album_card.dart';

class AlbumScreen extends StatefulWidget {
  final UserModel user;

  const AlbumScreen({super.key, required this.user});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final AlbumBloc _bloc = AlbumBloc();

  @override
  void initState() {
    super.initState();
    _bloc.get(widget.user.id);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
            title: Text(
              'Álbuns de ${widget.user.username}',
              style: const TextStyle(
                color: Color(0xFF60107B),
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Color(0xFF60107B)),
          ),
        ),
      ),

      body: StreamBuilder<dynamic>(
        stream: _bloc.output,
        builder: (_, snapshot) {
          // Carregando
          if (!snapshot.hasData || snapshot.data == true) {
            return Center(child: CircularProgressIndicator());
          }

          // Erro
          if (snapshot.hasData && snapshot.data == false) {
            return Center(child: Text("Erro ao carregar álbuns."));
          }

          // Sucesso
          final List<AlbumModel> albums = snapshot.data as List<AlbumModel>;

          return ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: albums.length,
            itemBuilder: (_, index) {
              final album = albums[index];

              return AlbumCard(album: album);
            },
          );
        },
      ),
    );
  }
}

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
      appBar: _buildCustomAppBar(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const Divider(height: 1, color: Color(0xFFe8d9f0)),

            _buildAlbumList(),
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
            'Shared Albums',
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
    final user = widget.user;
    final userImageIndex = user.id;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user.username,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF60107B),
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
          const SizedBox(height: 15),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/300?img=${userImageIndex.toString()}',
                ),
              ),
              const SizedBox(width: 20),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailColumn(value: '15', label: 'Álbuns'),
                    _buildDetailColumn(
                      value: user.phone.split(' ')[0],
                      label: 'Fone',
                    ),
                    _buildDetailColumn(
                      value: user.address.city,
                      label: 'Cidade',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailColumn({required String value, required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildAlbumList() {
    return StreamBuilder<dynamic>(
      stream: _bloc.output,
      builder: (_, snapshot) {
        // Carregando
        if (!snapshot.hasData || snapshot.data == true) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Erro
        if (snapshot.hasData && snapshot.data == false) {
          return const Center(child: Text("Erro ao carregar álbuns."));
        }

        // Sucesso
        final List<AlbumModel> albums = snapshot.data as List<AlbumModel>;

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          itemCount: albums.length,
          itemBuilder: (_, index) {
            final album = albums[index];
            return AlbumCard(album: album, user: widget.user);
          },
        );
      },
    );
  }
}

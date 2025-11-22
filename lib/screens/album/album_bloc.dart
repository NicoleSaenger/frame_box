import 'dart:async';

import '../../models/album_model.dart';

//import '../../services/album_service.dart';

class AlbumBloc {
  final controller = StreamController<dynamic>.broadcast();

  Sink get input => controller.sink;

  Stream<dynamic> get output => controller.stream;

  Future<void> get(int userId) async {
    input.add(true);

    // LISTA DE ÁLBUNS MOCKADA
    List<AlbumModel> mockAlbums = [];

    final List<String> user1Titles = [
      "quidem molestiae enim",
      "sunt qui excepturi placeat culpa",
      "omnis laborum odio",
      "non esse culpa molestiae omnis sed optio",
      "eaque aut omnis a",
      "natus impedit quibusdam illo est",
      "quibusdam autem aliquid et et quia",
      "qui fuga est a eum",
      "saepe unde necessitatibus rem",
      "distinctio laborum qui",
    ];

    if (userId == 1) {
      for (int i = 0; i < user1Titles.length; i++) {
        final albumId = 1 + i;
        mockAlbums.add(
          AlbumModel(userId: userId, id: albumId, title: user1Titles[i]),
        );
      }
    }
    // Bloco para Usuário ID 2 (se precisar de dados para o ID 11 a 20)
    else if (userId == 2) {
      for (int i = 0; i < 10; i++) {
        final albumId = 11 + i;
        mockAlbums.add(
          AlbumModel(
            userId: userId,
            id: albumId,
            title: 'Mock Album Title ${albumId} - User ${userId}',
          ),
        );
      }
    }

    await Future.delayed(const Duration(milliseconds: 500));

    final albums = mockAlbums;

    if (albums.isEmpty) {
      input.add(false);
    } else {
      input.add(albums);
    }
  }

  void dispose() {
    controller.close();
  }
}

/* Código antigo com ligação a API

class AlbumBloc {
  final controller = StreamController<dynamic>.broadcast();

  Sink get input => controller.sink;

  Stream<dynamic> get output => controller.stream;

  Future<void> get(int userId) async {
    input.add(true);
    final stream = await AlbumService.getAlbumsByUser(userId);

    if (stream == null) {
      input.add(false);
    } else {
      input.add(stream);
    }
  }

  void dispose() {
    controller.close();
  }
}
*/

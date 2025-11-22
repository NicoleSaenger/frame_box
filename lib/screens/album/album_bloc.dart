import 'dart:async';

import '../../models/album_model.dart';

//import '../../services/album_service.dart';

class AlbumBloc {
  final controller = StreamController<dynamic>.broadcast();

  Sink get input => controller.sink;

  Stream<dynamic> get output => controller.stream;

  Future<void> get(int userId) async {
    input.add(true);

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

    final List<String> user2Titles = [
      "quam nostrum impedit mollitia quod et dolor",
      "consequatur autem doloribus natus consectetur",
      "ab rerum non rerum consequatur ut ea unde",
      "ducimus molestias eos animi atque nihil",
      "ut pariatur rerum ipsum natus repellendus praesentium",
      "voluptatem aut maxime inventore autem magnam atque repellat",
      "aut minima voluptatem ut velit",
      "nesciunt quia et doloremque",
      "velit pariatur quaerat similique libero omnis quia",
      "voluptas rerum iure ut enim",
    ];

    if (userId == 1) {
      for (int i = 0; i < user1Titles.length; i++) {
        final albumId = 1 + i;
        mockAlbums.add(
          AlbumModel(userId: userId, id: albumId, title: user1Titles[i]),
        );
      }
    } else if (userId == 2) {
      for (int i = 0; i < user2Titles.length; i++) {
        final albumId = 11 + i;
        mockAlbums.add(
          AlbumModel(userId: userId, id: albumId, title: user2Titles[i]),
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

import 'dart:async';

import '../../services/album_service.dart';

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
